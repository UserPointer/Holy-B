module lexer.lexer;

import std.stdio;
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
	}
	
	return tokens;
}

void main() {
	string source = "/* I am gay */";
	
	auto tokens = lex(source);
	
	foreach(token; tokens) {
		writefln("Type: %s, value: %s, pos: %s", token.type, token.value, token.pos);
	}
}