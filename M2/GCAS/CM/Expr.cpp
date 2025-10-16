#include <ostream>

class Expr {

	public:
		virtual ~Expr(void) = 0;
		virtual void print(std::ostream& out) = 0;
		virtual float eval(float x) = 0;
};

class Xvar : public Expr {
	public:
		virtual void print(std::ostream& out) { out << "x"; }
		virtual float eval(float x) { return x; }

};

class Const : public Expr {

	private:
		float _k;

	public:
		Const(float k) : _k(k) {};
		Const() : _k(0) {};
		virtual ~Const() = default;
		virtual void print(std::ostream& out) { out << "k = " << _k; };
		virtual float eval(float x) { return _k; };
};

class Neg : public Expr {

	private:
		Expr *_g;

	public:
		Neg(Expr *g) : _g(g) {};
		Neg() = default;
		virtual ~Neg() = default;
		virtual void print(std::ostream& out) { _g->print(out); };
		virtual float eval(float x) { return -_g->eval(x); };

};

class Binop : public Expr {

	private: 
		Expr *_op_a;
		Expr *_op_b;

	public:
		Binop(Expr *a, Expr *b) : _op_a(a), _op_b(b) {}
		Binop() = default;
		virtual ~Binop() = default;
		virtual void print(std::ostream& out) { 
			out << "Operand a : ";
			_op_a->print(out);
			out << '\n';
			out << "Operand b : ";
			_op_b->print(out);
		}

		virtual float eval(float x) = 0;

};

class Add : public Binop {

	public:
		Add(Expr *a, Expr *b) : Binop(a, b) {


		}	
		



};
