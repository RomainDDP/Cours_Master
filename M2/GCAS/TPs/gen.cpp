#include "AST.hpp"
#include "Quad.hpp"

#include <assert.h>

const Quad::lab_t
	base_call = 10000,
	field_get_call = 10000,	// R0=expr, R1=high bit, R2=low bit
	field_set_call = 100001;	// R0=expr, R1=high bit, R2=low bit, R2=assigned value


///
Quad::reg_t ConstExpr::gen(QuadProgram& prog) {
	auto r = prog.newReg();
	prog.emit(Quad::seti(r, _val));
	return r;
}

///
Quad::reg_t MemExpr::gen(QuadProgram& prog) {
    switch(_dec->type()) {

    case Declaration::CST: {
        auto r = prog.newReg();
        prog.emit(Quad::seti(r, static_cast<ConstDecl *>(_dec)->value()));
        return r;
    }

    case Declaration::VAR:
        return prog.regFor(static_cast<VarDecl *>(_dec)->name());

    case Declaration::REG: {
        auto r = prog.newReg();
        auto addr = prog.newReg();
        prog.emit(Quad::seti(addr, static_cast<RegDecl *>(_dec)->address()));
        prog.emit(Quad::load(r, addr));
        return r;
    }

    default:
        assert(false);
        return 0;
    }
}


///
Quad::reg_t UnopExpr::gen(QuadProgram& prog) {
	auto ro = _arg->gen(prog);
	auto r = prog.newReg();
	switch(_op) {
	case NEG:
		prog.emit(Quad::neg(r, ro));
		break;
	
	default:
		prog.emit(Quad::inv(r, ro));
		break;
	}
	return r;
}


///
Quad::reg_t BinopExpr::gen(QuadProgram& prog) {
	auto r1 = _arg1->gen(prog);
	auto r2 = _arg2->gen(prog);

	auto rd = prog.newReg();

	Quad q;

	switch(_op) {
		case ADD:
			q = Quad::add(rd, r1, r2);
			break;
		case SUB:
			q = Quad::sub(rd, r1, r2);
			break;
		case MUL:
			q = Quad::mul(rd, r1, r2);
			break;
		case DIV:
			q = Quad::div(rd, r1, r2);
			break;
		case MOD:
			q = Quad::mod(rd, r1, r2);
			break;
		case BIT_AND:
			q = Quad::and_(rd, r1, r2);
			break;
		case BIT_OR:
			q = Quad::or_(rd, r1, r2);
			break;
		case XOR:
			q = Quad::xor_(rd, r1, r2);
			break;
		case SHL:
			q = Quad::shl(rd, r1, r2);
			break;
		case SHR:
			q = Quad::shr(rd, r1, r2);
			break;
		case ROL:
			q = Quad::rol(rd, r1, r2);
			break;
		case ROR:
			q = Quad::ror(rd, r1, r2);
			break;
		default:
			assert(false);
			break;
	}

	prog.emit(q);
	
	return rd;
}


///
Quad::reg_t BitFieldExpr::gen(QuadProgram& prog) {
    
	auto r_e  = _expr->gen(prog);
    auto r_hi = _hi->gen(prog);
    auto r_lo = _lo->gen(prog);

    // Test optimisation : hi == lo ?
    auto r_res = prog.newReg();

    // Si hi et lo sont constants → simplification directe
    auto v_hi = _hi->eval();
    auto v_lo = _lo->eval();

    if (v_hi && v_lo && *v_hi == *v_lo) {
        // (e >> lo) & 1
        auto r_shift = prog.newReg();
        auto r_one   = prog.newReg();

        prog.emit(Quad::shr(r_shift, r_e, r_lo));   // e >> lo
        prog.emit(Quad::seti(r_one, 1));
        prog.emit(Quad::and_(r_res, r_shift, r_one));
        return r_res;
    }

    // Sinon : appel du sous-programme field_get
    prog.emit(Quad::set(0, r_e));
    prog.emit(Quad::set(1, r_hi));
    prog.emit(Quad::set(2, r_lo));

    prog.emit(Quad::call(field_get_call));

    // Résultat dans R0
    prog.emit(Quad::set(r_res, 0));

    return r_res;
}



///
void CompCond::gen(Quad::lab_t lab_true, Quad::lab_t lab_false, QuadProgram& prog) const {
	
	auto a1 = _arg1->gen(prog);
	auto a2 = _arg2->gen(prog);
	Quad q;
	
	switch(_comp) {
		case EQ: 
			q = Quad::goto_eq(lab_true, a1, a2);
			break;
		case NE:
			q = Quad::goto_ne(lab_true, a1, a2);
			break;
		case GE:
			q = Quad::goto_ge(lab_true, a1, a2);
			break;
		case LE:
			q = Quad::goto_le(lab_true, a1, a2);
			break;
		case GT:
			q = Quad::goto_gt(lab_true, a1, a2);
			break;
		case LT:
			q = Quad::goto_lt(lab_true, a1, a2);
			break;
		default:
			assert(false);
	}

	prog.emit(q);
	prog.emit(Quad::goto_(lab_false));
}

///
void NotCond::gen(Quad::lab_t lab_true, Quad::lab_t lab_false, QuadProgram& prog) const {
	_cond->gen(lab_false, lab_true, prog);
}

///
void AndCond::gen(Quad::lab_t lab_true, Quad::lab_t lab_false, QuadProgram& prog) const {

	auto L1 = prog.newLab();

	_cond1->gen(L1, lab_false, prog);
	prog.emit(Quad::lab(L1));
	_cond2->gen(lab_true, lab_false, prog);

}

///
void OrCond::gen(Quad::lab_t lab_true, Quad::lab_t lab_false, QuadProgram& prog) const {

	auto L1 = prog.newLab();

	_cond1->gen(lab_true, L1, prog);
	prog.emit(Quad::lab(L1));
	_cond2->gen(lab_true, lab_false, prog);

}


///
void NOPStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {}

///
void SeqStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {

	prog.comment(pos);
	_stmt1->gen(automaton, prog);
	_stmt2->gen(automaton, prog);
}

///
void IfStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {
    prog.comment(pos);

    // Labels
    auto L_true  = prog.newLab();
    auto L_false = prog.newLab();
    auto L_end   = prog.newLab();

    // 1. Génération du test conditionnel
    _cond->gen(L_true, L_false, prog);

    // 2. Bloc TRUE
    prog.emit(Quad::lab(L_true));
    _stmt1->gen(automaton, prog);
    prog.emit(Quad::goto_(L_end));

    // 3. Bloc FALSE
    prog.emit(Quad::lab(L_false));
    if(_stmt2) {
        _stmt2->gen(automaton, prog);
    }

    // 4. Label de sortie
    prog.emit(Quad::lab(L_end));
}


///
void SetStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {
	prog.comment(pos);
	auto r = _expr->gen(prog);
	switch(_dec->type()) {
	case Declaration::VAR:
		prog.emit(Quad::set(prog.regFor(static_cast<VarDecl *>(_dec)->name()), r));
		break;
	case Declaration::REG: {
			auto ra = prog.newReg();
			prog.emit(Quad::seti(ra, static_cast<RegDecl *>(_dec)->address()));
			prog.emit(Quad::store(ra, r));
		}
		break;
	default:
		assert(false);
		break;
	}
}


///
void SetFieldStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {
	prog.comment(pos);

	auto mem = MemExpr(_dec).gen(prog); 
	auto expr = _expr->gen(prog);
	auto low = _lo->gen(prog);
	auto high = _hi->gen(prog);

	auto res = prog.newReg();

	prog.emit(Quad::set(0, mem));
	prog.emit(Quad::set(1, high));
	prog.emit(Quad::set(2, low));
	prog.emit(Quad::set(3, expr));

	prog.emit(Quad::call(field_set_call));

	prog.emit(Quad::set(res, 0));
}

///
void GotoStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {
	
	prog.comment(pos);
	prog.emit(Quad::goto_(_state->label()));

}

///
void StopStatement::gen(AutoDecl& automaton, QuadProgram& prog) const {
	prog.comment(pos);
	prog.emit(Quad::goto_(automaton.stopLabel()));
}


/**
 * Generate the code to implement a "when" directive.
 * @param automaton		Current automaton.
 * @param prog			Program to generate quadruplets in.
 */
void When::gen(AutoDecl& automaton, QuadProgram& prog) {
	prog.comment(pos);

    // 1. Lire le registre du signal
    auto r_addr = prog.newReg();
    auto r_sig  = prog.newReg();

    prog.emit(Quad::seti(r_addr, _sig->reg()->address()));
    prog.emit(Quad::load(r_sig, r_addr));

    // 2. Extraire le bit : (r_sig >> bit) & 1
    auto r_bitIndex = prog.newReg();
    prog.emit(Quad::seti(r_bitIndex, _sig->bit()));

    auto r_shifted = prog.newReg();
    auto r_bit     = prog.newReg();
    auto r_one     = prog.newReg();

    prog.emit(Quad::shr(r_shifted, r_sig, r_bitIndex));
    prog.emit(Quad::seti(r_one, 1));
    prog.emit(Quad::and_(r_bit, r_shifted, r_one));

    // 3. Label de fin de clause
    auto L_end = prog.newLab();

    // 4. Tester le bit selon la négation
    //    r_bit vaut 0 ou 1
    auto r_zero = prog.newReg();
    prog.emit(Quad::seti(r_zero, 0));

    if(!_neg) {
        // when BIT == 1
        // si (r_bit == 0) -> goto L_end
        prog.emit(Quad::goto_eq(L_end, r_bit, r_zero));
    } else {
        // when !BIT
        // si (r_bit != 0) -> goto L_end
        prog.emit(Quad::goto_ne(L_end, r_bit, r_zero));
    }

    // 5. Action de la clause
    _action->gen(automaton, prog);

    // 6. LABEL L_end
    prog.emit(Quad::lab(L_end));}


/**
 * Generate the code for a state.
 * @param automaton		Current automaton.
 * @param prog			Program to generate quadruplets in.
 */
void State::gen(AutoDecl& automaton, QuadProgram& prog) {
	prog.emit(Quad::lab(_label));
	_action->gen(automaton, prog);
	auto loop = prog.newLab();
	prog.emit(Quad::lab(loop));
	for(auto when: _whens)
		when->gen(automaton, prog);
	prog.emit(Quad::goto_(loop));
}


/**
 * Generate the code for the automatin.
 * @param prog	Program to generate in.
 */
void AutoDecl::gen(QuadProgram& prog) {
	_stop_label = prog.newLab();
	for(auto state: _states)
		state->setLabel(prog.newLab());
	_init->gen(*this, prog);
	for(auto state: _states)
		state->gen(*this, prog);
	prog.emit(Quad::lab(_stop_label));
	prog.emit(Quad::return_());
}

