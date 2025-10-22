module tokens.tokenType;

enum TokenType {
    // Types 
    IDENTIFIER,
    STRING,
    CHAR,
    INT,
    FLOAT,

    // Keywords
    FUNCTION,
    BEGIN,
    END,
    CONCLUSION,

    // Seperators
    LEFT_PAREN,                 // (
    RIGHT_PAREN,                // )
    LEFT_BRACE,                 // }
    RIGHT_BRACE,                // }  
    EXCLAMATION_MARK,           // !

    EOF
}