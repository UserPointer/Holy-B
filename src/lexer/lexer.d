module lexer.lexer;

import std.stdio;
import std.uni : isAlpha;
import std.ascii : isDigit;
import lexer.tokens;
import std.exception;

Token[] lex(string source) {
	Token[] tokens;
	size_t pos = 0;
	
	while(pos < source.length) {
		if(source[pos] == ' ' || source[pos] == '\t' || source[pos] == '\n') {
			++pos;
			
			continue;
		}
		
		else if(source[pos] == '/' && pos + 1 < source.length && source[pos + 1] == '/') {
			while(pos < source.length && source[pos] != '\n') {
				++pos;
			}
			
			continue;
		}
		
		else if(source[pos] == '/' && pos + 1 < source.length && source[pos + 1] == '*') {		
			pos += 2;
			
			while(pos < source.length && source[pos] != '*' && pos + 1 < source.length && source[pos + 1] != '/') {
				++pos;
			}
			
			pos += 2;
			
			continue;
		}
		
		else if(source[pos].isAlpha || source[pos] == '_') {
			size_t start = pos;
			
			while(pos < source.length && (source[pos].isAlpha || source[pos].isDigit || source[pos] == '_')) {
				++pos;
			}

			if(source[start..pos] == "main") {
				tokens ~= new Token(TokenType.MAIN, source[start..pos], pos);
			} else {
				tokens ~= new Token(TokenType.IDENTIFIER, source[start..pos], pos);
			}
			
			continue;
		}
		
		else if(source[pos].isDigit) {
			size_t start = pos;
			
			while(pos < source.length && source[pos].isDigit) {
				++pos;
			}
			
			tokens ~= new Token(TokenType.NUMBER, source[start..pos], pos);
			
			continue;
		}
		
		else if(source[pos] == '"') {
			++pos;
		
			size_t start = pos;
			
			while(pos < source.length && source[pos] != '"') {
				++pos;
			}
			
			if(pos >= source.length) {
				throw new Exception("Error: there is no closing parenthesis");				
			}

			tokens ~= new Token(TokenType.STRING, source[start..pos], pos);
			
			++pos;
			
			continue;
		}

		switch(source[pos]) {
			case '=':
				tokens ~= new Token(TokenType.ASSIGN, "=", pos);

				++pos;

				break;

			case ';':
				tokens ~= new Token(TokenType.SEMICOLON, ";", pos);

				++pos;

				break;

			default:
				throw new Exception("Error: unknown a symbol");
		}
	}
	
	tokens ~= new Token(TokenType.EOF, "", pos);
	
	return tokens;
}

void main() {
	string source = `str = "Hello, World!";`;
	
	auto tokens = lex(source);
	
	foreach(token; tokens) {
		writefln("Type: %s, value: %s, pos: %s", token.type, token.value, token.pos);
	}
}