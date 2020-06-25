grammar Suncript;

shaderBlock:
	Shader Identifier LeftBrace
	(
		functionBlock
		| moduleBlock
	)* RightBrace
	;
functionBlock:
	Function Identifier LeftParen RightParen Returns types LeftBrace RightBrace
	;
moduleBlock : Module Identifier LeftBrace RightBrace;

// shader keywords
Shader		:	'shader';
Module		:	'module';
Function	:	'fn';
Input		:	'in';
Output		:	'out';
Returns		:	'->';

variable : Identifier ':' types;

types : Builtins | Identifier;

Builtins : Scalars | Void;

// Void type
Void : 'void';

// scalar types
Scalars : Boolean | Double | Float | Int | UInt;

Boolean	:	'bool';
Double	:	'f64';
Float	:	'f32';
Int		:	'i32';
UInt	:	'u32';

Identifier : Character (Character | Digit | Underscore)*;

DecimalNumber : NonZeroDigit Digit*;

// Fragments
fragment Character		:	[a-zA-Z];
fragment NonZeroDigit	:	[1-9];
fragment Digit			:	[0-9];
fragment Underscore		:	[_];

// Skipped sections
Whitespace	:	[ \t]+ -> skip;
Newline		:	('\r' '\n'? | '\n') -> skip;

LeftBrace	:	'{';
RightBrace	:	'}';
LeftParen	:	'(';
RightParen	:	')';