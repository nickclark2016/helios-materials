grammar Suncript;

compilationUnit : ( shaderBlock | structBlock | functionBlock)*;

structBlock:
	StructSpecifier Identifier LeftBrace
	(
		variable StatementEnd
	)* RightBrace StatementEnd
	;
StructSpecifier : 'struct';

shaderBlock:
	Shader Identifier LeftBrace inputBlock*
	(
		functionBlock
		| moduleBlock
	)* RightBrace
	;

functionBlock:
	Function Identifier LeftParen argumentList? RightParen Returns types LeftBrace statement*
		RightBrace
	;

moduleBlock : Module Identifier LeftBrace RightBrace;

inputBlock:
	Input Identifier ':' types At bindingStatement Comma locationStatement StatementEnd
	;
bindingStatement	:	Binding Equals Decimal;
locationStatement	:	Location Equals Decimal;

postfixExpression:
	primaryExpression
	| postfixExpression LeftBracket expression RightBracket
	| postfixExpression LeftParen parameterList? RightParen
	| types LeftParen parameterList? RightParen
	| variable Equals postfixExpression
	;

primaryExpression:
	literal
	| idexpression
	| LeftParen expression RightParen
	;

argumentList	:	(argument (Comma argument)*);
argument		:	Identifier ':' typeIdSeq;
parameterList	:	( parameter ( Comma parameter)*);
parameter		:	(expression | literal);

idexpression	:	unqualifiedid;
unqualifiedid	:	Identifier;

typeIdSeq : types (LeftBracket Decimal RightBracket)?;

// expressions
unaryExpression:
	postfixExpression
	| Increment castExpression
	| Decrement castExpression
	| unaryOperator castExpression
	;

castExpression:
	unaryExpression
	| LeftParen typeIdSeq RightParen castExpression
	;

multiplicativeExpression:
	castExpression
	| multiplicativeExpression Multiply castExpression
	| multiplicativeExpression Divide castExpression
	;

additiveExpression:
	multiplicativeExpression
	| additiveExpression Add multiplicativeExpression
	| additiveExpression Subtract multiplicativeExpression
	;

shiftExpression : additiveExpression; // TODO: Shift expressions

relationExpression:
	shiftExpression
	| relationExpression Less shiftExpression
	| relationExpression Greater shiftExpression
	| relationExpression LessEquals shiftExpression
	| relationExpression GreaterEquals shiftExpression
	;

equalityExpression:
	relationExpression
	| equalityExpression Equality relationExpression
	| equalityExpression Inequality relationExpression
	;

andExpression:
	equalityExpression
	| andExpression BitAnd equalityExpression
	;

exclusiveOrExpression:
	andExpression
	| exclusiveOrExpression BitXor andExpression
	;

inclusiveOrExpression:
	exclusiveOrExpression
	| inclusiveOrExpression BitOr exclusiveOrExpression
	;

logicalAndExpression:
	inclusiveOrExpression
	| logicalAndExpression LogicalAnd inclusiveOrExpression
	;

logicalOrExpression:
	logicalAndExpression
	| logicalOrExpression LogicalOr logicalAndExpression
	;

conditionalExpression:
	logicalOrExpression
	| logicalOrExpression '?' expression ':' conditionalExpression
	;

assignmentExpression:
	conditionalExpression
	| logicalOrExpression assignmentOperator initializationClause
	;

statement			:	expressionStatement | jumpStatement;
expressionStatement	:	expression? StatementEnd;
jumpStatement		:	Return expression? StatementEnd;

expression : assignmentExpression;

initializationClause : assignmentExpression;

// shader keywords
Shader			:	'shader';
Module			:	'module';
Function		:	'fn';
Input			:	'in';
Output			:	'out';
Returns			:	'->';
Binding			:	'binding';
Location		:	'location';
variable		:	Identifier ':' typeIdSeq;
Comma			:	',';
At				:	'at';
StatementEnd	:	';';
Return			:	'return';

types : Builtins | Identifier;

Builtins : Matrices | Scalars | Vectors | Void;

// Void type
Void : 'void';

// scalar types
Scalars : Boolean | Double | Float | Int | UInt;

Boolean	:	'bool';
Double	:	'f64';
Float	:	'f32';
Int		:	'i32';
UInt	:	'u32';

// vector types
Vectors:
	BoolVec2
	| BoolVec3
	| BoolVec4
	| DoubleVec2
	| DoubleVec3
	| DoubleVec4
	| FloatVec2
	| FloatVec3
	| FloatVec4
	| IntVec2
	| IntVec3
	| IntVec4
	| UIntVec2
	| UIntVec3
	| UIntVec4
	;

BoolVec2	:	'bvec2';
BoolVec3	:	'bvec3';
BoolVec4	:	'bvec4';
DoubleVec2	:	'f64vec2';
DoubleVec3	:	'f64vec3';
DoubleVec4	:	'f64vec4';
FloatVec2	:	'f32vec2';
FloatVec3	:	'f32vec3';
FloatVec4	:	'f32vec4';
IntVec2		:	'i32vec2';
IntVec3		:	'i32vec3';
IntVec4		:	'i32vec4';
UIntVec2	:	'u32vec2';
UIntVec3	:	'u32vec3';
UIntVec4	:	'u32vec4';

Matrices:
	FloatMatrix2
	| FloatMatrix3
	| FloatMatrix4
	| DoubleMatrix2
	| DoubleMatrix3
	| DoubleMatrix4
	;

FloatMatrix2	:	'f32mat2';
FloatMatrix3	:	'f32mat3';
FloatMatrix4	:	'f32mat4';
DoubleMatrix2	:	'f64mat2';
DoubleMatrix3	:	'f64mat3';
DoubleMatrix4	:	'f64mat4';

Identifier : Character (Character | Digit | Underscore)*;

// Operators
assignmentOperator : Equals;
unaryOperator:
	BitOr
	| Multiply
	| BitAnd
	| Add
	| Not
	| Invert
	| Subtract
	;

Multiply		:	'*';
Divide			:	'/';
Add				:	'+';
Subtract		:	'-';
Equals			:	'=';
LogicalOr		:	'||';
LogicalAnd		:	'&&';
BitOr			:	'|';
BitAnd			:	'&';
BitXor			:	'^';
Equality		:	'==';
Inequality		:	'!=';
Less			:	'<';
LessEquals		:	'<=';
Greater			:	'>';
GreaterEquals	:	'>=';
Increment		:	'++';
Decrement		:	'--';
Not				:	'!';
Invert			:	'~';

LeftBrace		:	'{';
RightBrace		:	'}';
LeftParen		:	'(';
RightParen		:	')';
LeftBracket		:	'[';
RightBracket	:	']';

literal : Decimal | Floating;

Decimal		:	'0' | (NonZeroDigit Digit*);
Floating	:	DigitSequence? '.' DigitSequence;

// Fragments
fragment DigitSequence	:	Digit*;
fragment Character		:	[a-zA-Z];
fragment NonZeroDigit	:	[1-9];
fragment Digit			:	[0-9];
fragment Underscore		:	[_];

// Skipped sections
Whitespace	:	[ \t]+ -> skip;
Newline		:	('\r' '\n'? | '\n') -> skip;
