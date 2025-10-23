module lexer.lexer;

import std.stdio : writefln;

import tokens.tokenType;
import tokens.token;

Token[] tokenize(string source) {
    import std.conv : to;
    import std.ascii : isWhite, isAlpha, isDigit;

    Token[] tokens;
    immutable string[] keywords = ["function", "begin", "end", "conclusion"];
    size_t pos = 0;
    size_t col = 1;
    const size_t LEN = source.length;

    while(pos < LEN) {
        char current = source[pos];
        if(current.isWhite) {
            if(current == '\n') {
                ++col;
            }
            ++pos;
            continue;
        } else if(current.isAlpha || current == '_') {
            size_t start = pos;

            while(pos < LEN && (source[pos].isAlpha || source[pos] == '_' || source[pos].isDigit)) {
                ++pos;
            }

            string identifier = source[start..pos];
            TokenType type = TokenType.IDENTIFIER;

            foreach(keyword; keywords) {
                if(identifier == keyword) {
                    final switch(identifier) {
                        case "function": type = TokenType.FUNCTION; break;
                        case "begin": type = TokenType.BEGIN; break;
                        case "end": type = TokenType.END; break;
                        case "conclusion": type = TokenType.CONCLUSION; break;
                    }
                }
            }

            tokens ~= new Token(type, identifier, pos, col);
            ++pos;
            continue;
        } else if(current == '"') {
            ++pos;

            size_t start = pos;

            while(pos < LEN && pos+1 < LEN && source[pos+1] != '"') {
                ++pos;
            }

            ++pos;

            string ident = source[start..pos];

            tokens ~= new Token(TokenType.STRING, ident, pos, col);
            ++pos;
            continue;
        } else if(current.isDigit) {
            size_t start = pos;
            bool isFloat = false;

            while(pos < LEN && (source[pos].isDigit || source[pos] == '.')) {
                if(source[pos] == '.') {
                    if(!isFloat) {
                        isFloat = true;
                    } else {
                        throw new Exception("Error: Extra point '" ~ source[pos] ~ "' on line " ~ to!string(col)); 
                    }
                }
                ++pos;
            }

            string ident = source[start..pos];
            TokenType type = TokenType.INT;

            if(isFloat) {
                type = TokenType.FLOAT;
            }

            tokens ~= new Token(type, ident, pos, col);
            ++pos;
            continue;
        }

        switch(current) {
            case '(': 
                tokens ~= new Token(TokenType.LEFT_PAREN, "(", pos, col);
                ++pos;
                break;
            case ')': 
                tokens ~= new Token(TokenType.RIGHT_PAREN, ")", pos, col);
                ++pos;
                break;
            case '{': 
                tokens ~= new Token(TokenType.LEFT_BRACE, "{", pos, col);
                ++pos;
                break;
            case '}': 
                tokens ~= new Token(TokenType.RIGHT_BRACE, "}", pos, col);
                ++pos;
                break;
            case '!': 
                tokens ~= new Token(TokenType.EXCLAMATION_MARK, "!", pos, col);
                ++pos;
                break;
            default:
                throw new Exception("Error: Unknown symbol '" ~ current ~ "' on line " ~ to!string(col));
                break;
        }
    }

    return tokens;
}

void main() {
    string source = `
    23.4
    `;
    Token[] tokens = tokenize(source);

    foreach(Token token; tokens) {
        writefln("TYPE: %s, TOKEN: %s, POS: %s, COL: %s", token.type, token.token, token.pos, token.col);
    }
}