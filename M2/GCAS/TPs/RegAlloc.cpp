#include <cassert>
#include <vector>
#include <algorithm>
using namespace std;
#include "RegAlloc.hpp"

/**
 * @class StackMapper
 * Map the variable to stack offset.
 */

StackMapper::StackMapper(): _offset(0), _global(0) {
}

/**
 * Add a variable to the map.
 * @param reg	Assign a stack offset to the register.
 */
void StackMapper::add(Quad::reg_t reg) {
	_offset -= 4;
	_offsets[reg] = _offset;
}

/**
 * Get the offset of a register.
 * @param reg	Register to get offset of.
 * @return		Get an offset for the register, possibly allocate it.
 */
int32_t StackMapper::offsetOf(Quad::reg_t reg) {
	auto x =_offsets.find(reg);
	if(x != _offsets.end())
		return (*x).second;
	else {
		_offset -= 4;
		_offsets[reg] = _offset;
		return _offset;
	}
}

/**
 * @fn uint32_t StackMapper::stackSize() const;
 * Get the size to allocate in the stack.
 */

/**
 * Mark the current stack position as being the end of the global variable save area.
 */
void StackMapper::markGlobal() {
	_global = _offset;
}

/**
 * Test if a virtual register is a global variable register.
 * @param reg	Virtual register to look.
 * @return		True if it matches a global variable, false else.
 */
bool StackMapper::isGlobal(Quad::reg_t reg) {
	auto p = _offsets.find(reg);
	return p != _offsets.end() && (*p).second < _global;
}

/**
 * Rewind the size of the stack to the given size to remove temporary allocation,
 * to keep only global variables.
 */
void StackMapper::rewind() {
	_offset = _global;
	vector<int32_t> to_remove;
	for(auto p: _offsets)
		if(p.second < _global)
			to_remove.push_back(p.first);
	for(auto v: to_remove)
		_offsets.erase(v);
}


/**
 * @class RegAlloc
 * Supports allocation of register for a BB.
 */

/**
 * Build a register allocator.
 * @param mapper	Mapper for stack allocation (when variable have been allocated).
 * @param insts		List of instruction to complete with allocated instructions
 * 					and stack store/load instructions.
 */
RegAlloc::RegAlloc(StackMapper& mapper, list<Inst>& insts)
: _mapper(mapper), _insts(insts) {
	for(int i = 0; i < Quad::ALLOC_COUNT; i++)
		_avail.push_back(i);
}

/**
 * Perform allocation in one instruction and add the instruction to the list.
 * @param inst		Instruction sto process.
 */
void RegAlloc::process(Inst inst) {
    // 1. Traiter les paramètres (lecture / écriture)
    for (int i = 0; i < Inst::param_num; ++i) {
        Param &p = inst[i];
        switch (p.type()) {
        case Param::READ:
            processRead(p);
            break;
        case Param::WRITE:
            processWrite(p);
            break;
        default:
            // NONE ou CST → rien à faire
            break;
        }
    }

    // 2. Libérer les registres lus non-variables (morts après cette instruction)
    for (auto vreg : _fried) {
        if (!isVar(vreg))
            free(vreg);
    }
    _fried.clear();

    // 3. Ajouter l'instruction fixée à la liste
    _insts.push_back(inst);
}


/**
 * Complete the allocation of a BB by generating store of modified global variables.
 */
void RegAlloc::complete() {
    // Sauvegarder toutes les variables IOML modifiées dans ce BB
    for (auto r : _written)
        if (isVar(r))
            store(r);

    _written.clear();
}

/* Touch un registre dans la liste des LRU (le met à la fin). */
void RegAlloc::touch(Quad::reg_t reg) {
    _lru.remove(reg);
    _lru.push_back(reg);
}

/**
 * Allocate a read register.
 * @param param		Parameter to fix.
 */
void RegAlloc::processRead(Param& param) {
    assert("parameter should be a read parameter!" && param.type() == Param::READ);

    Quad::reg_t vreg = param.value();
    bool need_load = false;

    if (_map.count(vreg) == 0) {
        allocate(vreg);
        if (isVar(vreg))
            need_load = true;
    }

    Quad::reg_t hreg = _map[vreg];

    if (need_load)
        load(vreg);

    param = Param::read(hreg);

    touch(vreg);
    _fried.push_back(vreg);
}



/**
 * Allocata write register.
 * @param param		Parameter to fix.
 */
void RegAlloc::processWrite(Param& param) {
    Quad::reg_t vreg = param.value();

    if (_map.count(vreg) == 0)
        allocate(vreg);

    Quad::reg_t hreg = _map[vreg];
    param = Param::write(hreg);

    touch(vreg);

    // Marqué comme écrit (doit être spilled la fin du BB)
    _written.push_back(vreg);
    _fried.push_back(vreg);
}



/**
 * Allocate an hardware register through the free ones or spill a register
 * to get a new free hardware register.
 */
Quad::reg_t RegAlloc::allocate(Quad::reg_t vreg) {

    // Est-ce qu'il est alloué ?
    if (_map.count(vreg))
        return _map[vreg];

    Quad::reg_t hreg;

    // Registre physique libre.
    if (!_avail.empty()) {
        hreg = _avail.front();
        _avail.pop_front();
    }
    else {
        // Besoin de spill un registre.
        Quad::reg_t victim = chooseSpill();
        spill(victim);

        // Now a register must be free
        assert(!_avail.empty());
        hreg = _avail.front();
        _avail.pop_front();
    }

   	// On l'ajoute dans la map 
    _map[vreg] = hreg;
    touch(vreg);

    return hreg;
}

/*
 * Fonction qui permet de déterminer un registre à spill.
 * */

Quad::reg_t RegAlloc::chooseSpill() {

	// 1. Tente de spill une variable (global) qui n'est ni fried ni written.
    for (auto r : _lru)
        if (isVar(r) &&
            std::find(_fried.begin(), _fried.end(), r) == _fried.end() &&
            std::find(_written.begin(), _written.end(), r) == _written.end())
            return r;

	// 2. Tente de spill un tmp ni fried ni écrit.
    for (auto r : _lru)
        if (!isVar(r) &&
            std::find(_fried.begin(), _fried.end(), r) == _fried.end() &&
            std::find(_written.begin(), _written.end(), r) == _written.end())
            return r;

	// 3. Dernier cas, spill n'importe quel non-fried même si écrit.
    for (auto r : _lru)
        if (std::find(_fried.begin(), _fried.end(), r) == _fried.end())
            return r;

    assert(false && "No spill candidate found!");
    return 0;
}

/**
 * Generate code to spill the given virtual register.
 * @param reg	Virtual register to spill.
 */
void RegAlloc::spill(Quad::reg_t reg) {
	store(reg);
	_avail.push_front(_map[reg]);
	_map.erase(reg);
}

/**
 * Free the given virtual register.
 * @param reg	Virtual register to free.
 */
void RegAlloc::free(Quad::reg_t reg) {
    auto it = _map.find(reg);
    if (it == _map.end())
        return; // rien à libérer

    Quad::reg_t hreg = it->second;
    _map.erase(it);

    // On remet le registre matériel dans la liste des dispos
    _avail.push_front(hreg);
}


/**
 * Generate a store instruction to the stack.
 * @param reg		Virtual register to store.
 */
void RegAlloc::store(Quad::reg_t reg) {
	auto hreg = _map[reg];
	auto offset = _mapper.offsetOf(reg);
	_insts.push_back(Inst("\tstr R%0, [SP, #%1]", Param::read(hreg), Param::cst(offset)));
}

/**
 * Generate a load from the stack.
 * @param reg		Virtual register to load to.
 * @param offset	Offset in the stack of the value to load.
 */
void RegAlloc::load(Quad::reg_t reg) {
	auto hreg = _map[reg];
	auto offset = _mapper.offsetOf(reg);
	_insts.push_back(Inst("\tldr R%0, [SP, #%1]", Param::write(hreg), Param::cst(offset)));
}

/**
 * Test if a virtual register contains a variable.
 * @param reg	Virtual register to test.
 * @return		True if reg contains a IOML variable false else.
 */
bool RegAlloc::isVar(Quad::reg_t reg) const {
	return _mapper.isGlobal(reg);
}
