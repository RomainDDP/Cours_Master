#include "AST.hpp"

///
optional<value_t> ConstExpr::eval() const {
	return _val;
}

///
optional<value_t> MemExpr::eval() const {
	switch(_dec->type()) {
	case Declaration::CST:
		return static_cast<ConstDecl *>(_dec)->value();
	default:
		return {};
	}
}


///
optional<value_t> UnopExpr::eval() const {
	auto a = _arg->eval();
	if(!a)
		return {};
	switch(_op) {
	case NEG: return -*a;
	default: return {};
	}
}


///
optional<value_t> BinopExpr::eval() const {
	auto a1 = _arg1->eval();
	if(!a1)
		return {};
	auto a2 = _arg2->eval();
	if(!a2)
		return {};
	switch(_op) {
	case ADD:
		return *a1 + *a2;
	default:
		return {};
}	}



///
optional<value_t> BitFieldExpr::eval() const {
	return {};
}
