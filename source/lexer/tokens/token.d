module tokens.token;

import tokens.tokenType;

class Token {
public:
    this(TokenType type, string token, size_t pos, size_t col) {
        this.type = type;
        this.token = token;
        this.pos = pos;
        this.col = col;
    }

    TokenType type;
    string token;
    size_t pos;
    size_t col;
}