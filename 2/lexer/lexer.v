module lexer

import token

pub struct Lexer {
	input    string
mut:
	pos      int
	read_pos int
	ch       byte
}

pub fn new_lexer(input string) &Lexer {
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

	l.skip_whitespace()

	match l.ch {
		`=` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				literal := ch.str() + l.ch.str()
				tok = new_token_s(.tok_eq, literal)
			} else {
				tok = new_token_b(.tok_assign, l.ch)
			}
		}
		`;` { tok = new_token_b(.tok_semicolon, l.ch) }
		`,` { tok = new_token_b(.tok_comma, l.ch) }
		`(` { tok = new_token_b(.tok_lparen, l.ch) }
		`)` { tok = new_token_b(.tok_rparen, l.ch) }
		`+` { tok = new_token_b(.tok_plus, l.ch) }
		`-` { tok = new_token_b(.tok_minus, l.ch) }

		`!` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				literal := ch.str() + l.ch.str()
				tok = new_token_s(.tok_not_eq, literal)
			} else {
				tok = new_token_b(.tok_bang, l.ch)
			}
		}
		`*` { tok = new_token_b(.tok_asterisk, l.ch) }
		`/` { tok = new_token_b(.tok_slash, l.ch) }
		`<` { tok = new_token_b(.tok_lt, l.ch) }
		`>` { tok = new_token_b(.tok_gt, l.ch) }

		`{` { tok = new_token_b(.tok_lbrace, l.ch) }
		`}` { tok = new_token_b(.tok_rbrace, l.ch) }
		0 { tok = new_token_s(.tok_eof, "") }
		else {
			if is_letter(l.ch) {
				tok.literal = l.read_identifier()
				tok.token = token.lookup_ident(tok.literal)
				return tok
			} else if is_digit(l.ch) {
				tok.token = .tok_int
				tok.literal = l.read_number()
				return tok
			} else {
				tok = new_token_s(.tok_illegal,
					"ILLEGAL char at absolute index ${l.pos}: '${l.ch.str()}'")
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

fn (l mut Lexer) read_number() string {
	pos := l.pos
	for is_digit(l.ch) {
		l.read_char()
	}
	return l.input[pos..l.pos]
}

fn is_letter(ch byte) bool {
	return (`a` <= ch && ch <= `z`) || (`A` <= ch && ch <= `Z`) || ch == `_`
}

fn is_digit(ch byte) bool {
	return (`0` <= ch && ch <= `9`)
}

fn new_token_b(tt token.TokenType, ch byte) token.Token {
	return token.Token{tt, ch.str()}
}

fn new_token_s(tt token.TokenType, str string) token.Token {
	return token.Token{tt, str}
}

fn (l mut Lexer) skip_whitespace() {
	for l.ch in [` `, `\t`, `\n`, `\r`] {
		l.read_char()
	}
}

fn (l Lexer) peek_char() byte {
	return if l.read_pos >= l.input.len { 0 } else { l.input[l.read_pos] }
}

