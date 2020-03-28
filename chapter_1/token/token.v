module token

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

	// Special chars
	tok_comma // 7
	tok_semicolon // 8
	tok_lparen // 9
	tok_rparen // 10
	tok_lbrace // 11
	tok_rbrace // 12

	// Keywords
	tok_func // 13
	tok_let // 14
}

pub struct Token {
pub mut:
	token_type TokenType
	literal    string
}

pub fn lookup_ident(ident string) TokenType {
	if ident in keywords.keys() {
		return keywords[ident]
	} else {
		return .tok_ident
	}
}

fn init_keywords() map[string]TokenType {
	mut keywords := map[string]TokenType
	keywords["fn"] = .tok_func
	keywords["let"] = .tok_let
	return keywords
}

