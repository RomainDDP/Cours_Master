
#include <list>
#include <map>
#include <vector>
using namespace std;

#include "Quad.hpp"
#include "RegAlloc.hpp"

/*
 * This DAG instruction selector works under conditions:
 * 	a temporary variable is assigned once and used once!
 */

class DAGNode {
	friend class DAG;
public:
	static const auto GET = Quad::NOP;

	DAGNode(): _type(Quad::NOP) {}

	static DAGNode get_cst(Quad::reg_t x, Quad::arg_t val);
	static DAGNode unop(Quad::reg_t x, Quad::type_t type, DAGNode *arg);
	static DAGNode binop(Quad::reg_t x, Quad::type_t type, DAGNode *arg1, DAGNode *arg2);
	static DAGNode get_var(Quad::reg_t var);
	static DAGNode set(Quad::reg_t x, DAGNode *arg);
	static DAGNode load(Quad::reg_t x, DAGNode *arg);
	static DAGNode store(DAGNode *addr, DAGNode *val);
	static DAGNode goto_incond(Quad::lab_t lab);
	static DAGNode goto_cond(Quad::type_t, Quad::lab_t lab, DAGNode *arg1, DAGNode *arg2);

	inline Quad::type_t type() const { return _type; }
	inline Quad::reg_t var() const { return _target.var; }
	inline Quad::lab_t label() const { return _target.lab; }
	inline Quad::arg_t cst() const { return _data.cst; }
	inline DAGNode *arg() const { return _data.arg; }
	inline DAGNode *arg1() const { return _data.arg; }
	inline DAGNode *arg2() const { return _arg2; }

	bool operator==(const DAGNode& node) const;
	inline bool operator!=(const DAGNode& node) const { return !operator==(node); }

private:
	inline DAGNode(Quad::type_t type): _type(type) {}

	Quad::type_t _type;
	union {
		Quad::reg_t var;
		Quad::lab_t lab;
	} _target;
	union {
		Quad::arg_t cst;
		DAGNode *arg;
	} _data;
	DAGNode *_arg2;
};


/**
 * @class DAGNode
 * Represents a node in the DAG.
 */

DAGNode DAGNode::get_cst(Quad::reg_t x, Quad::arg_t val) {
	DAGNode n(Quad::SETI);
	n._target.var = x;
	n._data.cst = val;
	return n;
}

DAGNode DAGNode::unop(Quad::reg_t x, Quad::type_t type, DAGNode *arg) {
	DAGNode n(type);
	n._target.var = x;
	n._data.arg = arg;
	return n;
}

DAGNode DAGNode::binop(Quad::reg_t x, Quad::type_t type, DAGNode *arg1, DAGNode *arg2) {
	DAGNode n(type);
	n._target.var = x;
	n._data.arg = arg1;
	n._arg2 = arg2;
	return n;

}

DAGNode DAGNode::get_var(Quad::reg_t var) {
	DAGNode n(GET);
	n._target.var = var;
	return n;
}

DAGNode DAGNode::set(Quad::reg_t x, DAGNode *arg) {
	DAGNode n(Quad::SET);
	n._target.var = x;
	n._data.arg = arg;
	return n;
}

DAGNode DAGNode::load(Quad::reg_t x, DAGNode *addr) {
	DAGNode n(Quad::LOAD);
	n._target.var = x;
	n._data.arg = addr;
	return n;
}

DAGNode DAGNode::store(DAGNode *addr, DAGNode *val) {
	DAGNode n(Quad::STORE);
	n._data.arg = addr;
	n._arg2 = val;
	return n;
}

DAGNode DAGNode::goto_incond(Quad::lab_t lab) {
	DAGNode n(Quad::GOTO);
	n._target.lab = lab;
	return n;
}

DAGNode DAGNode::goto_cond(Quad::type_t type, Quad::lab_t lab, DAGNode *arg1, DAGNode *arg2) {
	DAGNode n(type);
	n._target.lab = lab;
	n._data.arg = arg1;
	n._arg2 = arg2;
	return n;
}

bool DAGNode::operator==(const DAGNode& node) const {
	if(_type != node._type)
		return false;
	switch(_type) {
	case Quad::SETI:
		return cst() == node.cst();
	case GET:
		return var() == node.var();
	case Quad::SET:
		return var() == node.var() && arg() == node.arg();
	case Quad::LOAD:
		return arg() == node.arg();
	case Quad::STORE:
		return arg1() == node.arg1() && arg2() == node.arg2();
	case Quad::GOTO:
		return label() == node.label();
	case Quad::GOTO_EQ:
	case Quad::GOTO_NE:
	case Quad::GOTO_LT:
	case Quad::GOTO_LE:
	case Quad::GOTO_GT:
	case Quad::GOTO_GE:
		return label() == node.label() && arg1() == node.arg1() && arg2() == node.arg2();
	case Quad::NEG:
	case Quad::INV:
		return arg() == node.arg();
	default:	// assume binary operator
		return arg1() == node.arg1() && arg2() == node.arg2();
	}
}


class DAG {
public:
	DAG(StackMapper& map);
	~DAG();
	void insert(Quad& q);
private:
	list<DAGNode *> _roots;
	void clearMem();
	DAGNode *getReg(Quad::reg_t x);
	map<Quad::reg_t, DAGNode *> _var_map;
	map<Quad::type_t, list<DAGNode *> *> _type_map;
	StackMapper& _global_map;
	list<DAGNode *> _forgotten;
};


/**
 * @class DAG
 * Used to build a DAG from a BB and the to recognize instruction models and
 * then generate the machine instructions. The DAG cannot be reset and should
 * be rebuild for each BB.
 */

DAG::DAG(StackMapper& map): _global_map(map) {
	for(int i = Quad::NOP; i <= Quad::POP; i++)
		_type_map[Quad::type_t(i)] = new list<DAGNode *>;
}

///
DAG::~DAG() {
	for(auto x: _type_map)
		for(auto p: *x.second)
			delete p;
	for(auto p: _roots)
		delete p;
	for(auto p: _forgotten)
		delete p;
}


/**
 * Insert the quadruplet in the DAG.
 * @param q		Quadruplet to insert.
 */
void DAG::insert(Quad& q) {

	// get the context
	if(_type_map.find(q.type) == _type_map.end())
		_type_map[q.type] = new list<DAGNode *>;
	auto list = _type_map[q.type];
	DAGNode node;
	bool created = false;
	bool is_branch = false;

	// prepare the node
	switch(q.type) {

	case Quad::SETI:
		node = DAGNode::get_cst(q.d, q.a);
		break;
	case Quad::SET:
		if(_global_map.isGlobal(q.d))
			node = *getReg(q.a);
		else
			_var_map[q.d] = getReg(q.a);
		break;
	case Quad::LOAD:
		node = DAGNode::load(q.d, getReg(q.a));
		break;
	default:
		break;
	}

	// add it if needed
	switch(node.type()) {
	case Quad::NOP:
		break;
	case Quad::STORE:
		clearMem();
	case Quad::SET:
	case Quad::GOTO:
	case Quad::GOTO_EQ:
	case Quad::GOTO_NE:
	case Quad::GOTO_LT:
	case Quad::GOTO_LE:
	case Quad::GOTO_GT:
	case Quad::GOTO_GE:
	case Quad::LAB:
	case Quad::CALL:
	case Quad::RETURN:
		_roots.push_back(new DAGNode(node));
		break;
	default: {

			// look for existence
			DAGNode *actual_node = nullptr;
			for(auto p: *list)
				if(*p == node) {
					actual_node = p;
					break;
				}
			if(actual_node == nullptr) {
				actual_node = new DAGNode(node);
				list->push_front(actual_node);
			}

			// if assign to global, generate set and clear
			if(_global_map.isGlobal(node.var())) {
				_var_map.erase(node.var());
				_roots.push_back(new DAGNode(DAGNode::set(node.var(), actual_node)));
			}

			// record alias
			_var_map[node.var()] = actual_node;
		}
		break;
	}
}


/**s
 * Clear any variable pointing to a memory access.
 */
void DAG::clearMem() {
	auto loads = _type_map[Quad::LOAD];
	for(auto p: *loads)
		_forgotten.push_front(p);
	loads->clear();
}


/**
 * Get the node associated with the variable. If there is no node, create it.
 * @param x		Register to find node for.
 * @return		Corresponding node.
 */
DAGNode *DAG::getReg(Quad::reg_t x) {
	/*auto i = _var_map.find(x);
	if(i != _var_map.end())
		return (*i).second;
	else {
		auto node = DAGNode::get_var(x);
		_var_map[x] = node;
		return node;
	}*/
	return nullptr;
}
