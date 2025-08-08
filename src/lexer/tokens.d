module lexer.tokens;

import std.string;

enum TokenType {
	FN,
	MAIN,
	
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
	
	IDENTIFIER,
	
	NUMBER,
	STRING,
	
	ASSIGN,
	SEMICOLON,
	
	EOF
}

class Token {
	public TokenType type;
	public string value;
	public size_t pos;
	
	public this(TokenType type, string value, size_t pos) {
		this.type = type;
		this.value = value;
		this.pos = pos;
	}
}