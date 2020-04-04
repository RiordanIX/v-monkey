module token

// This must be declared before the const field due to a bug. Should be fixed
// in V 0.2
fn init_keywords() map[string]TokenType {
	mut keywords := map[string]TokenType
	keywords["fn"] = .tok_func
	keywords["let"] = .tok_let
	keywords["true"] = .tok_true
	keywords["false"] = .tok_false
	keywords["if"] = .tok_if
	keywords["else"] = .tok_else
	keywords["return"] = .tok_return
	return keywords
}

pub const (
	keywords = init_keywords()
)

pub enum TokenType {
	tok_illegal // 0
	tok_eof // 1

	// Identifiers
	tok_ident // 2
	tok_int // 3

	// operators
	tok_assign // 4
	tok_plus // 5
	tok_minus // 6
	tok_bang // 7
	tok_asterisk // 8
	tok_slash // 9
	tok_lt // 10
	tok_gt // 11
	tok_eq // 12
	tok_not_eq // 13

	// Special chars
	tok_comma // 14
	tok_semicolon // 15
	tok_lparen // 16
	tok_rparen //17
	tok_lbrace //18
	tok_rbrace //19

	// Keywords
	tok_func // 20
	tok_let // 21
	tok_true // 22
	tok_false // 23
	tok_if // 24
	tok_else // 25
	tok_return // 26
}

pub struct Token {
pub mut:
	token   TokenType
	literal string
}

pub fn lookup_ident(ident string) TokenType {
	if ident in keywords {
		return keywords[ident]
	} else {
		return .tok_ident
	}
}

