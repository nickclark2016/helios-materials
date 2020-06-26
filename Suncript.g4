grammar Suncript;

compilationUnit : (shaderBlock | functionBlock)*;

shaderBlock:
	Shader Identifier LeftBrace inputBlock* moduleBlock* RightBrace
	;
functionBlock:
	Function Identifier LeftParen RightParen Returns types LeftBrace RightBrace
	;
moduleBlock : Module Identifier LeftBrace RightBrace;

inputBlock:
	Input Identifier ':' types At bindingStatement Comma locationStatement StatementEnd
	;
bindingStatement	:	Binding Equals Decimal;
locationStatement	:	Location Equals Decimal;

// shader keywords
Shader			:	'shader';
Module			:	'module';
Function		:	'fn';
Input			:	'in';
Output			:	'out';
Returns			:	'->';
Binding			:	'binding';
Location		:	'location';
Equals			:	'=';
variable		:	Identifier ':' types;
Comma			:	',';
At				:	'at';
StatementEnd	:	';';
types			:	Builtins | Identifier;

Builtins : Scalars | Vectors | Void;

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

Identifier : Character (Character | Digit | Underscore)*;

Decimal : '0' | (NonZeroDigit Digit*);

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