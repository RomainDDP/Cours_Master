#pragma once

enum class CodeOperation {

	Percer,
	Souder,
	Fraiser

};

class Piece {

private:
    int _id;
    CodeOperation _codeOp;

public:
    Piece(int id, CodeOperation code): _id(id), _codeOp(code) {};
    inline int getId() const { return _id; };
    inline CodeOperation getCodeOperation() const { return _codeOp; };

};


