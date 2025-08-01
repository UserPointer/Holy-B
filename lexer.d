module lexer.lexer;

import std.stdio;
import std.uni : isAlpha;
import std.ascii : isDigit;
import lexer.tokens;

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
			
			tokens ~= new Token(TokenType.IDENTIFIER, source[start..pos], pos);
			
			continue;
		}
	}
	
	return tokens;
}

void main() {
	string source = "hello";
	
	auto tokens = lex(source);
	
	foreach(token; tokens) {
		writefln("Type: %s, value: %s", token.type, token.value);
	}
}