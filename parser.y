%{
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <list>
#include "node.h"

#define YYDEBUG 1

//root of AST
Program *root;

int yylex();
void yyerror(const char *str);
int yyparse();

extern "C" int yylineno;
extern "C" FILE *yyin;

void yyerror(const char *str)
{
    fprintf(stderr, "Syntax error on line: %d\n", yylineno);
}
 
extern "C" int yywrap()
{
    return 1;
} 
  
int main(int argc, char **argv) {
    /* Process file as command line args */
    yyin = fopen(argv[1], "r");
    
    /* Parse file and build AST */
    yyparse();
    fclose(yyin);

    /* Traverse AST */
    root->evaluate();

    /* Finish */
    return 0;
}

%}

%start Program

%union {
    /* Terminals */
    int num;
    char *id;
    char *str;

    /* Non-Terminals */
    Exp *expr;
    Statement *stmt;
    Type *type;
    Formal *formal;
    MethodDecl *method;
    VarDecl *var;
    ClassDecl *classDecl;
    MainClass *main;
    Program *pgm;

    /* Lists */
    std::list<ClassDecl *> *classDeclList;
    std::list<Exp *> *expList;
    std::list<Formal *> *formalList;
    std::list<MethodDecl *> *methodDeclList;
    std::list<Statement *> *stmtList;
    std::list<VarDecl *> *varDeclList;
}

%define parse.error verbose
%token CLASS PUBLIC STATIC VOID MAIN EXTENDS RETURN /* Declarations */
%token LENGTH PRINTLN PRINT /* Functions */
%token IF ELSE WHILE /* Loops and if-statements */
%token THIS NEW STRING /* Objects */
%token ID INTEGER_LITERAL STRING_LITERAL /* Variables */
%token INT BOOL /* Primitive Types */
%token TRUE FALSE /* booleans */
%token EQUAL NOT DOT /* Operators */
%token AND OR LESS GREATER GREATERTHANEQUAL LESSTHANEQUAL IS ISNOT PLUS MINUS TIMES SLASH /* Binary Operators - op */
%token COMMA SEMICOLON OPARANTHESIS EPARANTHESIS OBRACK EBRACK OBRACE EBRACE QUOTE /* Separators */

/* Terminals */
%type <num> INTEGER_LITERAL
%type <str> STRING_LITERAL
%type <id> ID

/* Non-Terminals */
%type <expr> Exp H_Exp I_Exp J_Exp K_Exp L_Exp T_Exp F_Exp G_Exp Root_Exp Object
%type <stmt> Statement
%type <type> Type PrimeType
%type <formal> FormalRest
%type <method> MethodDecl
%type <var> VarDecl
%type <classDecl> ClassDecl
%type <main> MainClass
%type <pgm> Program

/* Lists */
%type <classDeclList> ClassDeclList
%type <expList> ExpList
%type <formalList> FormalList
%type <methodDeclList> MethodDeclList
%type <stmtList> StatementList
%type <varDeclList> VarDeclList

%%

Program:
        MainClass ClassDeclList
        { $$ = new Program($1, $2); root = $$; std::cout << "fired Program $$$$$$$$$$$$$$$\n"; }
        ;

MainClass:
        CLASS ID OBRACE PUBLIC STATIC VOID MAIN OPARANTHESIS STRING OBRACK EBRACK ID EPARANTHESIS
            OBRACE Statement EBRACE EBRACE
        { $$ = new MainClass(new Identifier($2), new Identifier($12), $15); std::cout << "fired Main #############\n"; }
        ;

ClassDecl:
        CLASS ID OBRACE VarDeclList MethodDeclList EBRACE 
        { $$ = new ClassDeclSimple(new Identifier($2), $4, $5); std::cout << "fired Class Decl Simple @@@@@@@@@@@@@@@@\n"; }
        |
        CLASS ID EXTENDS ID OBRACE VarDeclList MethodDeclList EBRACE
        { $$ = new ClassDeclExtends(new Identifier($2), new Identifier($4), $6, $7); std::cout << "fired Class Decl Extends @@@@@@@@@@@@@\n"; }
        ;

ClassDeclList:
        ClassDeclList ClassDecl { std::cout << "class list wanted upstream ^^^^^^^^^^^^^^^^^^^^^\n"; $$ = $1; $1->push_back($2); std::cout << "loaded up classdecl list push\n"; }
        | /* Empty */  { std::cout << "class list wanted DOWNSTREAM EMPTY\n"; $$ = new std::list<ClassDecl *>(); std::cout << "alocated new list\n"; }
        ;

VarDecl:
        Type ID SEMICOLON { std::cout << "fired Var Decl @@@@@@@@@@@@@@\n"; }
        |
        ID EQUAL Exp SEMICOLON { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> var dec id = exp\n"; }
        ;

VarDeclList:
        VarDeclList VarDecl { std::cout << "var list wanted upstream ^^^^^^^^^^^^^^^^^^^^^\n";
        $$ = $1; $1->push_back($2); std::cout << "loaded up vardecl list push\n"; }
        | /* Empty */  { std::cout << "var list wanted DOWNSTREAM EMPTY\n"; $$ = new std::list<VarDecl *>(); std::cout << "alocated new list\n"; }
        ;

MethodDecl:
        PUBLIC Type ID OPARANTHESIS FormalList EPARANTHESIS 
            OBRACE VarDeclList StatementList RETURN Exp SEMICOLON EBRACE
        { /*$$ = new MethodDecl($2, $3, $5, $7, $8, $10);*/ std::cout << "fired method decl EEEEEERRRRRRRRRr@@@@@@@@@@@@@@@\n"; }
        ;

MethodDeclList:
        MethodDeclList MethodDecl { std::cout << "method list wanted upstream ^^^^^^^^^^^^^^^^^^^^^\n";
        $$ = $1; $1->push_back($2); std::cout << "loaded up methoddecl list push\n"; }
        | /* Empty */  { std::cout << "method list wanted DOWNSTREAM EMPTY\n"; $$ = new std::list<MethodDecl *>(); std::cout << "alocated new list\n"; }
        ;

FormalList:
        Type ID FormalRestList { std::cout << "formal list wanted upstream ^^^^^^^^^^^^^^^^^^^^^\n"; }
        | /* Empty */
        ;

FormalRest:
        COMMA Type ID { $$ = new Formal($2, new Identifier($3)); std::cout << "fired formal @@@@@@@@@@@@@@@2\n"; }
        ;

FormalRestList:
        FormalRestList FormalRest { std::cout << "formal rest list list wanted upstream ??????????????????????????\n"; }
        | /* Empty */
        ;

PrimeType:
        INT { $$ = new IntegerType(); std::cout << "fired int type #############\n"; }
        |
        BOOL { $$ = new BooleanType(); std::cout << "fired bool type #############\n"; }
        |
        ID { $$ = new IdentifierType($1); std::cout << "fired id type #############\n"; }
        ;

Type:
        PrimeType 
        |
        Type OBRACK EBRACK { $$ = new IntArrayType(); std::cout << "fired int array type #############\n"; }
        ;

Statement:
        OBRACE StatementList EBRACE { std::cout << "fired statementList ################"; $$ = new Block($2); }
        |
        IF OPARANTHESIS Exp EPARANTHESIS Statement ELSE Statement { $$ = new If($3, $5, $7); std::cout << "fired If #############\n"; }
        |
        WHILE OPARANTHESIS Exp EPARANTHESIS Statement { $$ = new While($3, $5); std::cout << "fired While #############\n"; }
        |
        PRINTLN OPARANTHESIS Exp EPARANTHESIS SEMICOLON { $$ = new Println($3); std::cout << "fired Println #############\n"; }
        |
        PRINTLN OPARANTHESIS STRING_LITERAL EPARANTHESIS SEMICOLON { $$ = new PrintStringln($3); std::cout << "fired println Stringlit ############"; }
        |
        PRINT OPARANTHESIS Exp EPARANTHESIS SEMICOLON { $$ = new Print($3); std::cout << "fired Print #############\n"; }
        |
        PRINT OPARANTHESIS STRING_LITERAL EPARANTHESIS SEMICOLON { $$ = new PrintString($3); std::cout << "fired print string lit ################"; }
        |
        ID EQUAL Exp SEMICOLON { $$ = new Assign(new Identifier($1), $3); std::cout << "fired Assign #############\n"; }
        |
        ID Index EQUAL Exp SEMICOLON { std::cout << "fired ArrayAssign @@@@@@@@@@@\n"; }
        |
        RETURN Exp SEMICOLON { std::cout << "fired return @@@@@@@@@@@@@@@@@@@"; }
        ;

StatementList:
        StatementList Statement { std::cout << "statment list wanted upstream ^^^^^^^^^^^^^^^^^^^^^\n";
        $$ = $1, $1->push_back($2); 
        std::cout << "loaded stmt list\n"; }
        | /* Empty */ { std::cout << "empty stmt list\n"; 
        $$ = new std::list<Statement *>(); std::cout <<"built stmt list\n";}
        ;

Index:
        OBRACK Exp EBRACK { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> index (exp)\n"; }
        |
        Index OBRACK Exp EBRACK { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> index [exp]\n"; }
       ;

Exp: 
        Exp OR T_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp OR\n"; }
        |
        T_Exp
        ;

T_Exp:
        T_Exp AND F_Exp { $$ = new And($1, $3); std::cout << "fired And #############\n"; }
        |
        F_Exp
        ;

F_Exp:
        F_Exp IS G_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp == \n"; }
        |
        F_Exp ISNOT G_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp != \n"; }
        |
        G_Exp
        ;

G_Exp:
        G_Exp LESS H_Exp { $$ = new LessThan($1, $3); std::cout << "fired Less #############\n"; }
        |
        G_Exp LESSTHANEQUAL H_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp <=\n"; }
        |
        G_Exp GREATER H_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp >\n"; }
        |
        G_Exp GREATERTHANEQUAL H_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp >=\n"; }
        |
        H_Exp
        ;

H_Exp:
        H_Exp PLUS I_Exp { $$ = new Plus($1, $3); std::cout << "fired Plus #############\n"; }
        |
        H_Exp MINUS I_Exp { $$ = new Minus($1, $3); std::cout << "fired Minus #############\n"; }
        |
        I_Exp
        ;

I_Exp:
        I_Exp TIMES J_Exp { $$ = new Times($1, $3); std::cout << "fired Times #############\n"; }
        |
        I_Exp SLASH J_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp division\n"; }
        |
        J_Exp
        ;

J_Exp:
        PLUS K_Exp { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp (+)\n"; }
        |
        MINUS K_Exp  { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp (-)\n"; }
        |
        NOT K_Exp { $$ = new Not($2); std::cout << "fired Not #############\n"; }
        |
        K_Exp
        ;

K_Exp:
        K_Exp DOT LENGTH { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp dot length\n"; }
        |
        K_Exp DOT ID OPARANTHESIS ExpList EPARANTHESIS { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp dot id explist\n"; }
        |
        L_Exp
        ;

L_Exp:
        ID Root_Exp DOT LENGTH { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp length\n"; }
        |
        Root_Exp
        ;
        
Root_Exp:  
        OPARANTHESIS Exp EPARANTHESIS { $$ = $2; std::cout << "fired (exp) ###########"; }
        |
        ID Index { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp id index\n"; }
        |
        INTEGER_LITERAL { $$ = new IntegerLiteral($1); std::cout << "fired integer literal ###########\n"; }
        |
        TRUE { $$ = new True(); std::cout << "fired True #############\n"; }
        |
        FALSE { $$ = new False(); std::cout << "fired False #############\n"; }
        |
        Object { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp object\n"; }
        ;  

Object:
        ID { $$ = new IdentifierExp($1); std::cout << "fired IdentExp #############\n"; }
        |
        THIS { $$ = new This(); std::cout << "fired This #############\n"; }
        |
        NEW ID OPARANTHESIS EPARANTHESIS { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exp new id()\n"; }
        |
        NEW PrimeType Index { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX exp new object prime\n"; }
        ;

ExpList:
        Exp ExpRestList { std::cout << "@@@@@@@@@@TESTTESTTESTTESTTEST> exp exprest list\n"; } 
        | /* Empty */  { std::cout << "exp list wanted @@@@@@@@@2222TESTESTESTDOWNSTREAM EMPTY\n"; /*$$ = new std::list<Exp *>(); std::cout << "alocated new list\n";*/ }
        ;

ExpRest:
        COMMA Exp { std::cout << "@@@@@@@@@@@@@@@@TESTTESTESTESTESTES> exprest comma\n"; /*$$->push_back($2); std::cout << "loaded up classdecl list push\n";*/ }
        ;

ExpRestList:
        ExpRestList ExpRest { std::cout << "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> exprestlist\n"; } 
        | /* Empty */
        ;

%%
