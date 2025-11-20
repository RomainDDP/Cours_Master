
#include <assert.h>
#include "Inst.hpp"

typedef enum {
	IGNORE = 0x00000,
	RECORD = 0x10000,
	EQUAL  = 0x20000,
	POW2   = 0x30000,
	ISIMM  = 0x40000,
	NOVAR  = 0x50000
} check_t;

typedef enum {
	COPY = 0x10000,
	LOG2 = 0x20000
} action_t;

typedef struct select_t {
	Quad quads[5];
	Inst insts[];
} select_t;

inline Param pread(uint32_t x) { return Param::read(x); }
inline Param pwrite(uint32_t x) { return Param::write(x); }
inline Param pcst(uint32_t x) { return Param::cst(x); }


/**
 * @class Param
 * Parameter of a machine instruction.
 */

/**
 * Print the parameter.
 */
void Param::print(ostream& out) const {
	switch(_type) {
	case NONE:
		break;
	case CST:
		out << '#' << _val;
		break;
	case READ:
		out << "read " << Quad::reg(_val);
		break;
	case WRITE:
		out << "write " << Quad::reg(_val);
		break;
	default:
		assert(false);
		break;
	}
}


/**
 * @class Inst
 * Represents a machine instruction.
 */

/**
 * Print a machine instruction.
 */
void Inst::print(ostream& out) const {
	for(auto p = _fmt; *p != '\0'; p++) {
		if(*p != '%')
			out << *p;
		else {
			int n = (*++p) - '0';
			out << _params[n].value();
		}
	}
}


/**
 * Instruction end marker.
 */
Inst Inst::end;


// instruction selectors
select_t
	select_add = {
		{ Quad::add(RECORD|0, RECORD|1, RECORD|2) },
		{ Inst("\tadd R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
	},
	select_addi = {
		{ Quad::seti(RECORD|2, ISIMM|3), Quad::add(RECORD|0, RECORD|1, EQUAL|2) },
		{ Inst("\tadd R%0, R%1, #%2", pwrite(COPY|0), pread(COPY|1), pcst(COPY|3)) }
	},
	select_addi2 = {
		{ Quad::seti(RECORD|2, ISIMM|3), Quad::add(RECORD|0, EQUAL|2, RECORD|1) },
		{ Inst("\tadd R%0, R%1, #%2", pwrite(COPY|0), pread(COPY|1), pcst(COPY|3)) }
	},

	select_call = {
		{ Quad::call(RECORD|0) },
		{ Inst("\tbl L%0", pcst(COPY|0)), Inst::end }
	},
	select_label = {
		{ Quad::lab(RECORD|0) },
		{ Inst("L%0:", pcst(COPY|0)), Inst::end }
	},
	select_ldreq = {
		{ Quad::seti(RECORD|0, RECORD|1) },
		{ Inst("\tldr R%0, =%1", pwrite(COPY|0), pcst(COPY|1)), Inst::end }
	},
	select_mov = {
		{ Quad::set(RECORD|0, RECORD|1) },
		{ Inst("\tmov R%0, R%1", pwrite(COPY|0), pread(COPY|1)), Inst::end }
	},
	select_movi = {
		{ Quad::seti(RECORD|0, ISIMM|1) },
		{ Inst("\tmov R%0, #%1", pwrite(COPY|0), pcst(COPY|1)), Inst::end }
	},

	select_return = {
		{ Quad::return_() },
		{ Inst("\tbx LR"), Inst::end }
	},


// NEG : vi <- -vj  → rsb Ri, Rj, #0
select_neg = {
    { Quad::neg(RECORD|0, RECORD|1) },
    { Inst("\trsb R%0, R%1, #0", pwrite(COPY|0), pread(COPY|1), pcst(COPY|2)), Inst::end }
},

// INV : vi <- ~vj → mvn Ri, Rj
select_inv = {
    { Quad::inv(RECORD|0, RECORD|1) },
    { Inst("\tmvn R%0, R%1", pwrite(COPY|0), pread(COPY|1)), Inst::end }
},

// SUB : vi <- vj - vk
select_sub = {
    { Quad::sub(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tsub R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// MUL : vi <- vj * vk
select_mul = {
    { Quad::mul(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tmul R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// DIV : vi <- vj / vk   (pseudo-instruction div)
select_div = {
    { Quad::div(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tdiv R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// AND : vi <- vj & vk
select_and = {
    { Quad::and_(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tand R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// OR : vi <- vj | vk
select_or = {
    { Quad::or_(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\torr R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// XOR : vi <- vj ^ vk
select_xor = {
    { Quad::xor_(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\teor R%0, R%1, R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// SHL : vi <- vj << vk  → mov Ri, Rj, lsl Rk
select_shl = {
    { Quad::shl(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tmov R%0, R%1, lsl R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// SHR : vi <- vj >> vk  → mov Ri, Rj, lsr Rk
select_shr = {
    { Quad::shr(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tmov R%0, R%1, lsr R%2", pwrite(COPY|0), pread(COPY|1), pread(COPY|2)), Inst::end }
},

// LOAD : vi <- Mem[vj]  → ldr Ri, [Rj]
select_load = {
    { Quad::load(RECORD|0, RECORD|1) },
    { Inst("\tldr R%0, [R%1]", pwrite(COPY|0), pread(COPY|1)), Inst::end }
},

// STORE : Mem[vi] <- vj → str Rj, [Ri]
select_store = {
    { Quad(Quad::STORE, IGNORE|0, RECORD|0, RECORD|1) },
    { Inst("\tstr R%1, [R%0]",
           pread(COPY|0), pread(COPY|1)),
      Inst::end }
},


// GOTO inconditionnel : goto L → b L
select_b = {
    { Quad::goto_(RECORD|0) },
    { Inst("\tb L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_EQ : if (vi == vj) goto L
select_beq = {
    { Quad::goto_eq(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbeq L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_NE : if (vi != vj) goto L
select_bne = {
    { Quad::goto_ne(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbne L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_LT : if (vi < vj) goto L
select_blt = {
    { Quad::goto_lt(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tblt L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_LE : if (vi <= vj) goto L
select_ble = {
    { Quad::goto_le(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tble L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_GT : if (vi > vj) goto L
select_bgt = {
    { Quad::goto_gt(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbgt L%0", pcst(COPY|0)), Inst::end }
},

// GOTO_GE : if (vi >= vj) goto L
select_bge = {
    { Quad::goto_ge(RECORD|0, RECORD|1, RECORD|2) },
    { Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbge L%0", pcst(COPY|0)), Inst::end }
},

select_andi = {
    { Quad::seti(RECORD|2, ISIMM|3), Quad::and_(RECORD|0, RECORD|1, EQUAL|2) },
    { Inst("\tand R%0, R%1, #%2", pwrite(COPY|0), pread(COPY|1), pcst(COPY|3)), Inst::end }
},

select_andi2 = {
    { Quad::seti(RECORD|2, ISIMM|3), Quad::and_(RECORD|0, EQUAL|2, RECORD|1) },
    { Inst("\tand R%0, R%1, #%2", pwrite(COPY|0), pread(COPY|1), pcst(COPY|3)), Inst::end }
},

// goto L; label L  →  label L
select_goto_fallthrough = {
    { Quad::goto_(RECORD|0), Quad::lab(EQUAL|0) },
    { Inst("L%0:", pcst(COPY|0)), Inst::end }
},

// goto_eq L, vi, vj; goto L'; lab L  →  cmp; beq L'; L:
select_beq_opt = {
    { Quad::goto_eq(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbeq L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// NE
select_bne_opt = {
    { Quad::goto_ne(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbne L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// LT
select_blt_opt = {
    { Quad::goto_lt(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tblt L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// LE
select_ble_opt = {
    { Quad::goto_le(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tble L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// GT
select_bgt_opt = {
    { Quad::goto_gt(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbgt L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// GE
select_bge_opt = {
    { Quad::goto_ge(RECORD|0, RECORD|1, RECORD|2),
      Quad::goto_(RECORD|3),
      Quad::lab(EQUAL|0) },
    {
      Inst("\tcmp R%1, R%2", pread(COPY|1), pread(COPY|2)),
      Inst("\tbge L%3",      pcst(COPY|3)),
      Inst("L%0:",           pcst(COPY|0)),
      Inst::end
    }
},

// vi <- 2^n; v0 <- v1 * vi  →  v0 <- v1 << n
select_mul_shl = {
    { Quad::seti(RECORD|2, POW2|3),
      Quad::mul(RECORD|0, RECORD|1, EQUAL|2) },
    {
      Inst("\tmov R%0, R%1, lsl #%2",
           pwrite(COPY|0), pread(COPY|1), pcst(LOG2|3)),
      Inst::end
    }
},

select_mul_shl2 = {
    { Quad::seti(RECORD|2, POW2|3),
      Quad::mul(RECORD|0, EQUAL|2, RECORD|1) },
    {
      Inst("\tmov R%0, R%1, lsl #%2",
           pwrite(COPY|0), pread(COPY|1), pcst(LOG2|3)),
      Inst::end
    }
},

// vi <- 2^n; v0 <- v1 / vi  →  v0 <- v1 >> n
select_div_shr = {
    { Quad::seti(RECORD|2, POW2|3),
      Quad::div(RECORD|0, RECORD|1, EQUAL|2) },
    {
      Inst("\tmov R%0, R%1, lsr #%2",
           pwrite(COPY|0), pread(COPY|1), pcst(LOG2|3)),
      Inst::end
    }
};


select_t *selectors[] = {

    /* 1 — Multi-quads spécialisés */
	/*&select_goto_fallthrough,
    &select_beq_opt,
    &select_bne_opt,
    &select_blt_opt,
    &select_ble_opt,
    &select_bgt_opt,
    &select_bge_opt,
	*/

    /* 2 — GOTO conditionnels simples */
    &select_beq,
    &select_bne,
    &select_blt,
    &select_ble,
    &select_bgt,
    &select_bge,

    /* 3 — GOTO inconditionnel simple */
    &select_b,

    /* 4 — LOAD / STORE */
    &select_load,
    &select_store,

    /* 5 — Immédiats arithmétique */
    &select_addi,
    &select_addi2,
    &select_andi,
    &select_andi2,

    /* 6 — Puissance de 2 → shifts */
    &select_mul_shl,
    &select_mul_shl2,
    &select_div_shr,

    /* 7 — Arithmétique générale */
    &select_add,
    &select_sub,
    &select_mul,
    &select_div,
    &select_and,
    &select_or,
    &select_xor,
    &select_shl,
    &select_shr,
    &select_neg,
    &select_inv,

    /* 8 — MOV / MOVI */
    &select_mov,
    &select_movi,
	&select_call,

    /* 9 — LDR =constante */
    &select_ldreq,

    /* 10 — LABEL (toujours en fin) */
    &select_label,

    /* 11 — RETURN */
    &select_return,

    nullptr
};


/* useful functions */
inline check_t check(uint32_t x)
	{ return static_cast<check_t>(x & 0xffff0000); }
inline action_t action(uint32_t x)
	{ return static_cast<action_t>(x & 0xffff0000); }
inline uint32_t value(uint32_t x)
	{ return static_cast<uint32_t>(x & 0x0000ffff); }

int bitcount(int32_t v) {
    int cnt = 0;
    for(int i = 0; v && i < 32; i++, v >>= 1)
        if((v & 1) != 0)
            cnt++;
    return cnt;
}

uint32_t rightmostbit(uint32_t x) {
    for(int i = 0; i < 32; i++, x >>= 1)
        if((x & 1) != 0)
            return i;
    return (uint32_t)-1;
}

bool isImmediate(uint32_t x) {
	if(x == 0)
		return true;
	for(int i = 0; i < 16 && ((x & 0b11) == 0); i++, x >>= 2);
	return (x & 0xffffff00) == 0;
}


/**
 * Test of a match of an argument with a given template.
 * @param tmp	Template argument.
 * @param arg	Actual argument.
 * @param vars	Template variables.
 * @return		True if this match, false else.
 */
bool matchParam(uint32_t tmp, uint32_t arg, uint32_t vars[]) {
	switch(check(tmp)) {
	case IGNORE:
		return true;
	case POW2:
		if(bitcount(arg) != 1)
			return false;
	case RECORD:
		vars[value(tmp)] = arg;
		return true;
	case EQUAL:
		return vars[value(tmp)] == arg;
	case ISIMM:
		if(!isImmediate(arg))
			return false;
		else {
			vars[value(tmp)] = arg;
			return true;
		}
	default:
		assert(false);
		break;
	}
	return true;
}


/**
 * Test of a match of a quadruplet with a given template.
 * @param temp	Template quadruplet.
 * @param quad	Quadruplet to match with.
 * @param arg	Argument to compare with and to update.
 * @return		True if this match, false else.
 */
bool matchQuad(const Quad& temp, const Quad& quad, uint32_t vars[]) {
	return temp.type == quad.type
		&& matchParam(temp.d, quad.d, vars)
		&& matchParam(temp.a, quad.a, vars)
		&& matchParam(temp.b, quad.b, vars);
}


/**
 * Make an instruction from instruction template and variables.
 * @param temp	Instruction template.
 * @param vars	Template variable.
 * @return		Made instruction.
 */
Inst makeInst(const Inst& temp, uint32_t vars[]) {
	Inst inst = Inst(temp.format());
	for(int i = 0; i < 4 && temp[i].type() != Param::NONE; i++)
		switch(action(temp[i].value())) {
		case COPY:
			inst[i] = Param(temp[i].type(), vars[value(temp[i].value())]);
			break;
		case LOG2:
			inst[i] = Param(temp[i].type(), rightmostbit(vars[value(temp[i].value())]));
			break;
		default:
			assert(false);
			break;
		}
	return inst;
}


/**
 * Select instruction in the given sequence.
 * @param quads	List of quadruplets to select in.
 * @return		List of corresponding instructions.
 */
list<Inst> select(const list<Quad>& quads) {
	list<Inst> insts;
	uint32_t vars[16];

	// traverse all instructions
	for(auto i = quads.begin(); i != quads.end();) {
		//cerr << "DEBUG: " << *i << endl;

		// traverse all selectors
		select_t *selector = nullptr;
		auto j = i;
		for(auto s = selectors; selector == nullptr && *s != nullptr; s++) {
			j = i;
			selector = *s;
			//cerr << "DEBUG:\t\tcheck " << (*s)->insts[0].format() << endl;
			for(int x = 0; j != quads.end() && (*s)->quads[x].type != Quad::NOP; ++x, ++j)
				if(!matchQuad((*s)->quads[x], *j, vars)) {
					selector = nullptr;
					break;
				}
		}

		// apply the selector
		if(selector == nullptr) {
			cerr << "WARNING: cannot translate " << *i << endl;
			++i;
		}
		else {
			for(int x = 0; selector->insts[x].format() != nullptr; x++)
				insts.push_back(makeInst(selector->insts[x], vars));
			i = j;
		}
	}
	return insts;
}
