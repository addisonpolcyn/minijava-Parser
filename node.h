#include <list>
#include <string>
#include <map>
#include <iostream>

enum Types { Integer, Array, Boolean, Object };

/*******************    IDENTIFIER CLASS    *********************/
class Identifier {
protected:
    std::string id;
public:
    Identifier(const std::string str);
    std::string visit();
};

/*******************    EXP CLASS    ****************************/
/* Exp Abstract-Class */
class Exp {
public:
    virtual Types visit() = 0;
};

/* Exp Sub-Classes */
class And : public Exp {
protected:
    Exp *lhs;
    Exp *rhs;
    int lineno;
public:
    And(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Or : public Exp {
protected:
    Exp *lhs;
    Exp *rhs;
    int lineno;
public:
    Or(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Is : public Exp {
protected:
    Exp *lhs;
    Exp *rhs;
    int lineno;
public:
    Is(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class IsNot : public Exp {
protected:
    Exp *lhs;
    Exp *rhs;
    int lineno;
public:
    IsNot(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class LessThan : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    LessThan(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class LessThanEqual : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    LessThanEqual(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class GreaterThan : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    GreaterThan(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class GreaterThanEqual : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    GreaterThanEqual(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Plus : public Exp {
protected:
    Exp *lhs;
    Exp *rhs;
    int lineno;
public:
    Plus(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Minus : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    Minus(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Times : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    Times(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class Div : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    Div(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class ArrayLookup : public Exp {
protected:
    Exp * lhs;
    Exp * rhs;
    int lineno;
public:
    ArrayLookup(Exp *lhs, Exp *rhs, int lineno);
    Types visit();
};

class ArrayLength : public Exp {
protected:
    Exp * e;
public:
    ArrayLength(Exp *e);
    Types visit();
};

class Call : public Exp {
protected:
    Exp * e;
    Identifier * i;
    std::list<Exp *> * el;
public:
    Call(Exp *e, Identifier *i, std::list<Exp *> *el);
    Types visit();
};

class IntegerLiteral : public Exp {
protected:
    int num;
public:
    IntegerLiteral(int i);
    Types visit();
};

class True : public Exp {
public:
    True() {}
    Types visit();
};

class False : public Exp {
public:
    False() {}
    Types visit();
};

class IdentifierExp : public Exp {
protected:
    std::string id;
public:
    IdentifierExp(std::string str);
    Types visit();
};

class This : public Exp {
public:
    This() {}
    Types visit();
};

class NewArray : public Exp {
protected:
    Exp * e;
public:
    NewArray(Exp *e);
    Types visit();
};

class NewObject : public Exp {
protected:
    Identifier * i;
public:
    NewObject(Identifier *i);
    Types visit();
};

class Not : public Exp {
protected:
    Exp * e;
    int lineno;
public:
    Not(Exp *e, int lineno);
    Types visit();
};

class NegativeExp : public Exp {
protected:
    Exp * e;
    int lineno;
public:
    NegativeExp(Exp *e, int lineno);
    Types visit();
};

class PositiveExp : public Exp {
protected:
    Exp * e;
    int lineno;
public:
    PositiveExp(Exp *e, int lineno);
    Types visit();
};


/*******************    STATEMENT CLASS    ****************************/
//abstract Statement class
class Statement {
public:
    virtual void visit() = 0;
};

class Block : public Statement {
protected:
    std::list<Statement *> *sl;
public:
    Block(std::list<Statement *> *sl);
    void visit();
};

class If : public Statement {
protected:
    Exp *e;
    Statement *s1;
    Statement *s2;
    int lineno;

public:
    If(Exp *e, Statement *s1, Statement *s2, int lineno);
    void visit();
};

class While : public Statement {
protected:
    Exp *e;
    Statement *s;
    int lineno;

public:
    While(Exp *e, Statement *s, int lineno);
    void visit();
};

class Print : public Statement {
protected:    
    Exp *e;
    int lineno;

public:
    Print(Exp *e, int lineno);
    void visit();
};

class Println : public Statement {
protected:    
    Exp *e;
    int lineno;

public:
    Println(Exp *e, int lineno);
    void visit();
};

class PrintString : public Statement {
protected:    
    const std::string str;
public:
    PrintString(const std::string str);
    void visit();
};

class PrintStringln : public Statement {
protected:    
    const std::string str;
public:
    PrintStringln(const std::string str);
    void visit();
};

class Assign : public Statement {
protected:
    Identifier *i;
    Exp *e;

public:
    Assign(Identifier *i, Exp *e);
    void visit();
};

class ArrayAssign : public Statement {
protected:
    Identifier *i;
    Exp * e1;
    Exp * e2;
public:
   ArrayAssign(Identifier *i, Exp *e1, Exp *e2);
   void visit();
};

/*******************    TYPE CLASS    ****************************/
class Type {
public:
    virtual Types getType() = 0;
};
class IntArrayType : public Type {
public:
    IntArrayType() {}
    Types getType();
};

class BooleanType : public Type {
public:    
    BooleanType() {}
    Types getType();
};

class IntegerType : public Type {
public:
    IntegerType() {}
    Types getType();
};

class IdentifierType : public Type {  
protected:
    std::string str;
public:
    IdentifierType(const std::string s);
    Types getType();
};

/*******************    VAR CLASS    ****************************/
class VarDecl {
protected:
    Type *t;
    Identifier *i;
public:
    VarDecl(Type *t, Identifier *i);
    void visit();
};

/*******************    FORMAL CLASS    ****************************/
class Formal {
protected:
    Type *t;
    Identifier *i;
public:
    Formal(Type *t, Identifier *i);
    void visit();
};

/*******************    METHOD CLASS    ****************************/
class MethodDecl {
protected:
    Type *t;
    Identifier *i;
    std::list<Formal *> *fl;
    std::list<VarDecl *> *vl;
    std::list<Statement *> *sl;
    Exp *e;

public:
    MethodDecl(Type *t, Identifier *i, std::list<Formal *> *fl, std::list<VarDecl *> *vl, std::list<Statement *> *sl, Exp *e);
    void visit();
};


/*******************    CLASS DECLARATION CLASS ****************************/
//abstract class
class ClassDecl {
public:
    virtual void visit() = 0;
};

class ClassDeclSimple : public ClassDecl {
protected:
    Identifier *i;
    std::list<VarDecl *> *vl;
    std::list<MethodDecl *> *ml;

public:
    ClassDeclSimple(Identifier *i, std::list<VarDecl *> *vl, std::list<MethodDecl *> *ml);
    void visit();
};

class ClassDeclExtends : public ClassDecl { 
protected:
    Identifier *i;
    Identifier *j;
    std::list<VarDecl *> *vl;
    std::list<MethodDecl *> *ml;

public:
    ClassDeclExtends(Identifier *i, Identifier *j, std::list<VarDecl *> *vl, std::list<MethodDecl *> *ml);
    void visit();
};

/*******************    MAIN CLASS    ****************************/
class MainClass {
protected:
    Identifier *i1;
    Identifier *i2;
    Statement *s;

public:
    MainClass(Identifier *i1, Identifier *i2, Statement *s);
    void visit();
};

/*******************    PROGRAM CLASS ****************************/
class Program {
protected:
    MainClass *m;
    std::list<ClassDecl *> *cl;
public:
    Program(MainClass *m, std::list<ClassDecl *> *cl);
    void visit();
};

extern std::map<std::string, int> varTable;
extern std::map<std::string, ClassDeclSimple *> classTable;
extern Program *root;
