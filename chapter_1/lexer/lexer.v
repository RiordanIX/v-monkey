module lexer

import token

pub struct Lexer {
	input    string
mut:
	pos      int
	read_pos int
	ch       byte
}

pub fn new(input string) &Lexer {
	mut l := &Lexer{input: input}
	l.read_char()
	return l
}

fn (l mut Lexer) read_char() {
	if l.read_pos >= l.input.len {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_pos]
	}
	l.pos = l.read_pos
	l.read_pos++
}

pub fn (l mut Lexer) next_token() token.Token {
	mut tok := token.Token{}
	match l.ch {
		`=` { tok = new_token_b(.tok_assign, l.ch) }
		`;` { tok = new_token_b(.tok_semicolon, l.ch) }
		`,` { tok = new_token_b(.tok_comma, l.ch) }
		`(` { tok = new_token_b(.tok_lparen, l.ch) }
		`)` { tok = new_token_b(.tok_rparen, l.ch) }
		`+` { tok = new_token_b(.tok_plus, l.ch) }
		`-` { tok = new_token_b(.tok_minus, l.ch) }
		`{` { tok = new_token_b(.tok_lbrace, l.ch) }
		`}` { tok = new_token_b(.tok_rbrace, l.ch) }
		0 { tok = new_token_s(.tok_eof, "") }
		else {
			if is_letter(l.ch) {
				tok = new_token_s(.tok_ident, l.read_identifier())
				return tok
			} else {
				tok = new_token_s(.tok_illegal,
					"ILLEGAL at absolute index ${l.pos}")
			}
		}
	}
	l.read_char()
	return tok
}

fn (l mut Lexer) read_identifier() string {
	pos := l.pos
	for is_letter(l.ch) {
		l.read_char()
	}
	return l.input[pos..l.pos]
}

fn is_letter(ch byte) bool {
	return (`a` <= ch && ch <= `z`) || (`A` <= ch && ch <= `Z`) || ch == `_`
}

fn new_token_b(tt token.TokenType, ch byte) token.Token {
	return token.Token{tt, ch.str()}
}

fn new_token_s(tt token.TokenType, str string) token.Token {
	return token.Token{tt, str}
}
