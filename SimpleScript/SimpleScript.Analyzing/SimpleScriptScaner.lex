%using SimpleScript.RunTime;

%namespace SimpleScript.Analyzing

%option stack, minimize, parser, verbose, persistbuffer, unicode, compressNext, embedbuffers

%{
public void yyerror(string format, params object[] args) // remember to add override back
{
	System.Console.Error.WriteLine("Error: line {0} - " + format, yyline);
}
%}
// Single comments
LineComment	!.*

//Base Definitions
D		[0-9]
AZ		[a-zA-Z]
AZex 	[a-zA-Z0-9_]+
//Literals
IntegerLiteral	{D}+
DoubleLiteral	-?{D}+(\.{D}+)?
BooleanLiteral	(ON|OFF)
StringLiteral	'.*'
ProgramName		([a-zA-Z]([a-zA-Z0-9_])*)

//Spaces and End of Line
WhiteSpace		[ \t]
Eol				(\r\n?|\n)
Semi			;
Colon			:
Comma			,

//move type
Joint		J
Linear		L
Circular	C

//welding
Arc			Arc
Start		Start
Weave		Weave

//var
Register	R
PosRegister	PR
Dout		DO
Din			DI

//
Fine		FINE
Cnt			CNT
Wjnt		WJNT
Offset		OFFSET
Condition	CONDITION
Skip		SKIP
Acc			ACC
Sec			sec
Label		LBL
Jump		JMP
Call		CALL
Pulse		Pulse
If			IF
Select		SELECT
Else		ELSE
Prog		/PROG
Main		/MN
Pos			/POS
End			/END

//speed
Percent		"%"
MmSec		"mm/sec"
CmMin		"cm/min"
InchMin		"inch/min"
DegSec		"deg/sec"


OpAssign	=
OpAdd		"+"
OpMinus		"-"
OpMul		"*"
OpChu		"/"
OpMod		MOD
OpDiv		DIV
LeftPar		"("
RightPar	")"
LeftBra		"["
RightBra	"]"
LeftBig		"{"
RightBig	"}"
OpAnd		and
OpOr		or
OpEqu		"=="
OpNotEqu	"<>"
OpLt		"<"
OpGt		">"
OpGtEq		">="
OpLtEq		"<="

//POS
Home		HOME
Pos			P\[{D}+.*\]
Group		GP1
Deg			deg
Mm			mm
Ut			UT
Uf			UF
Config		CONFIG
J1			J1
J2			J2
J3			J3
J4			J4
J5			J5
J6			J6
X			X
Y			Y
Z			Z
W			W
P			P





// The states into which this FSA can pass.
%x CMMT		// Inside a comment.
%x CMMT2
%%

//
// Start of Rules
//


// Remove whitespaces.
{WhiteSpace}+	{ ; }

// End of Line (Haven't yet figured it how to do this :-) )
{Eol}+		{ return (int) Tokens.EOL; }

// Remove these lines 
// TODO: show these lines
{LineComment}+					{yy_push_state (CMMT);}//return (int) Tokens.COMMENT; }
<CMMT>{
{Eol} { yy_pop_state ();}
}



{IntegerLiteral}				{ Int64.TryParse (yytext, NumberStyles.Integer, CultureInfo.CurrentCulture, out yylval.Integer);
								return (int) Tokens.INTEGER_LITERAL; }

{DoubleLiteral}					{ double.TryParse (yytext, NumberStyles.Float, CultureInfo.CurrentCulture, out yylval.Double); 
								return (int) Tokens.DOUBLE_LITERAL; }

{BooleanLiteral}				{ if(yytext == "ON") {yylval.Bool =	true;}
								else {yylval.Bool =	false;}
								return (int) Tokens.BOOL_LITERAL; }
{StringLiteral}					{ if (yytext.Length > 2) { yylval.String = yytext.Substring(1, yytext.Length - 2); }
									else { yylval.String = ""; }
								return (int) Tokens.STRING_LITERAL; }

{Joint}		{ return (int) Tokens.JOINT; }
{Linear}	{ return (int) Tokens.LINEAR; }
{Circular}	{ return (int) Tokens.CIRCULAR; }

{Arc}		{ return (int) Tokens.ARC; }
{Start}		{ return (int) Tokens.START; }
{Weave}		{ return (int) Tokens.WEAVE; }

{Register}		{ return (int) Tokens.REGISTER; }
{PosRegister}	{ return (int) Tokens.POS_REGISTER; }
{Dout}			{ return (int) Tokens.DOUT; }
{Din}			{ return (int) Tokens.DIN; }

{Percent}		{ return (int) Tokens.PERCENT; }
{MmSec}			{ return (int) Tokens.MM_SEC; }
{CmMin}			{ return (int) Tokens.CM_MIN; }
{InchMin}		{ return (int) Tokens.INCH_MIN; }
{DegSec}		{ return (int) Tokens.DEG_SEC; }

{Fine}			{ return (int) Tokens.FINE; }
{Cnt}			{ return (int) Tokens.CNT; }
{Wjnt}			{ return (int) Tokens.WJINT; }
{Offset}		{ return (int) Tokens.OFFSET; }
{Condition}		{ return (int) Tokens.CONDITION; }
{Skip}			{ return (int) Tokens.SKIP; }
{Acc}			{ return (int) Tokens.ACC; }
{Sec}			{ return (int) Tokens.SEC; }
{Label}			{ return (int) Tokens.LABEL; }
{Jump}			{ return (int) Tokens.JUMP; }
{Call}			{ return (int) Tokens.CALL; }
{Pulse}			{ return (int) Tokens.PULSE; }
{End}			{ return (int) Tokens.END; }
{If}			{ return (int) Tokens.IF; }
{Select}		{ return (int) Tokens.SELECT; }
{Else}			{ return (int) Tokens.ELSE; }

{OpAssign}	{ return (int) Tokens.OP_ASSIGN; }
{OpAdd}		{ return (int) Tokens.OP_ADD; }
{OpMinus}	{ return (int) Tokens.OP_MINUS; }
{OpMul}		{ return (int) Tokens.OP_MUL; }
{OpDiv}		{ return (int) Tokens.OP_DIV; }
{OpChu}		{ return (int) Tokens.OP_CHU; }
{OpMod}		{ return (int) Tokens.OP_MOD; }
{LeftPar}	{ return (int) Tokens.OP_LEFT_PAR; }
{RightPar}	{ return (int) Tokens.OP_RIGHT_PAR; }
{LeftBra}	{ return (int) Tokens.OP_LEFT_BRA; }
{RightBra}	{ return (int) Tokens.OP_RIGHT_BRA; }
{OpAnd}		{ return (int) Tokens.OP_AND; }
{OpOr}		{ return (int) Tokens.OP_OR; }
{OpEqu}		{ return (int) Tokens.OP_EQU; }
{OpNotEqu}	{ return (int) Tokens.OP_NOT_EQU; }
{OpLt}		{ return (int) Tokens.OP_LT; }
{OpGt}		{ return (int) Tokens.OP_GT; }
{OpGtEq}	{ return (int) Tokens.OP_GT_EQ; }
{OpLtEq}	{ return (int) Tokens.OP_LT_EQ; }
{Pos}		{if(yytext.Contains("\"HOME\"")) { yylval.String = yytext.Replace("\"HOME\"","HOME"); } 
			return (int) Tokens.Pos; }

{ProgramName}					{ yylval.String = yytext; 
								return (int) Tokens.PROGRAM_NAME; }



