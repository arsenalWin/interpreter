%using SimpleScript.RunTime;

%namespace SimpleScript.Analyzing

%{
	SymbolTable symTable = SymbolTable.GetInstance;
	public StatementList program = new StatementList();
%}

%start program

%union {
    public long Integer;
    public string String;
    public double Double;
	public bool Bool;
	public Expression expr;
	public StatementList statementList;
	public IStatement  statement;
	public MoveSpeed moveSpeed;
}
// Defining Tokens
%token COMMENT
%token BEGIN
%token EOL
%token SEMI
%token COLON
%token COMMA

%token <Integer> INTEGER_LITERAL
%token <Double>	 DOUBLE_LITERAL
%token <Bool>	 BOOL_LITERAL
%token <String>	 STRING_LITERAL

// move Statement
%token JOINT
%token LINEAR
%token CIRCULAR

//welding
%token ARC
%token START
%token WEAVE

//VAR
%token REGISTER
%token POS_REGISTER
%token DOUT
%token DIN

//
%token FINE
%token CNT
%token WJNT
%token OFFSET
%token CONDITION
%token SKIP
%token ACC
%token SEC
%token LABEL
%token JUMP
%token CALL
%token PULSE
%token IF
%token SELECT
%token ELSE
%token MAIN
%token POS_
%token END

// SPEED
%token PERCENT
%token MM_SEC
%token CM_MIN
%token INCH_MIN
%token DEG_SEC

%token OP_RIGHT_PAR
%token OP_LEFT_PAR
%token OP_LEFT_BRA
%token OP_RIGHT_BRA
%token OP_LEFT_BIG
%token OP_RIGHT_BIG
%left OP_ASSIGN
%left OP_ADD OP_MINUS
%left OP_MUL OP_CHU 
%left OP_MOD OP_DIV
%left OP_AND
%left OP_OR
%left OP_EQU
%left OP_NOT_EQU
%left OP_LT
%left OP_GT
%left OP_GT_EQ
%left OP_LT_EQ

%token <String>  POS
%token GROUP
%token DEG
%token MM
%token UT
%token UF
%token CONFIG
%token J1
%token J2
%token J3
%token J4
%token J5
%token J6
%token X
%token Y
%token Z
%token W
%token P

%token PROGRAM_NAME

// YACC Rules
%%
program			:	BEGIN EOL statementList EOL POS_ posInfoList END	{program = $3.statementList;}
				;

statementList	:	/*Empty*/	{if($$.statementList == null)	{$$.statementList = new StatementList();}}

				|	statement	{	if($$.statementList == null)	{$$.statementList = new StatementList();}
									$$.statementList.InsertFront($1.statement);
									
								}
				|	statementList EOL statement	{ $1.statementList.Add($3.statement); $$.statementList = $1.statementList; }
				;
			
//运动指令 焊接指令 I/O指令 LABEL指令 JUMP指令 CALL指令 IF指令 SELECT指令 WAIT指令 OFFSET指令 PAUSE指令
statement	:	moveStatement		{ $$.statement = $1.statement; }
			;

moveStatement	:	JOINT POS moveSpeed moveFine SEMI	{$$.statement = new MoveStatement(MoveTypes.Joint, $2, $3.moveSpeed);}
				;

moveSpeed		:	INTEGER_LITERAL PERCENT	{$$.moveSpeed = new MoveSpeed($1, "percent");}
				|	INTEGER_LITERAL MM_SEC	{$$.moveSpeed = new MoveSpeed($1, "mm/sec");}
				|	INTEGER_LITERAL CM_MIN	{$$.moveSpeed = new MoveSpeed($1, "cm/min");}	
				|	INTEGER_LITERAL INCH_MIN	{$$.moveSpeed = new MoveSpeed($1, "inch/min");}	
				|	INTEGER_LITERAL DEG_SEC	{$$.moveSpeed = new MoveSpeed($1, "deg/sec");}	
				;

moveFine		:	FINE
				;
				

posInfoList	:	/*Empty*/
			|	posInfo
			|	posInfoList EOL posInfo
			;

posInfo		:	POS OP_LEFT_BIG EOL GROUP COLON EOL UF COLON INTEGER_LITERAL COMMA UT COLON INTEGER_LITERAL COMMA EOL 
				J1 OP_ASSIGN DOUBLE_LITERAL DEG COMMA J2 OP_ASSIGN DOUBLE_LITERAL DEG COMMA J3 OP_ASSIGN DOUBLE_LITERAL DEG COMMA EOL
			    J4 OP_ASSIGN DOUBLE_LITERAL DEG COMMA J5 OP_ASSIGN DOUBLE_LITERAL DEG COMMA J6 OP_ASSIGN DOUBLE_LITERAL DEG EOL
				OP_LEFT_BIG SEMI
				{ int yId = symTable.Add($1); symTable.SetType(yId, SimpleScriptTypes.PosInfo); 
				SymbolTablePosElement ielem = (SymbolTablePosElement)symTable.Get(yId);
				ielem.Value.Type = 0;
				ielem.Value.J1 = $18; ielem.Value.J2 = $23; ielem.Value.J3 = $28;
				ielem.Value.J4 = $34; ielem.Value.J5 = $39; ielem.Value.J6 = $44;
				}
			;
%%

// No argument CTOR. By deafult Parser's ctor requires scanner as param.
public Parser(Scanner scn) : base(scn) { }