module parser

import (
	ast
	lexer
	token
)

pub struct Parser {
mut:
	l          &lexer.Lexer
	cur_token  token.Token
	peek_token token.Token
}

pub fn new(l mut lexer.Lexer) &Parser {
	mut p := &P{l: l)
	// Read 2 tokens so cur_token and peek_token are set

	p.next_token()
	p.next_token()
}

fn (p mut Parser) next_token() {
	p.cur_token = p.peek_token
	p.peek_token = p.l.next_token()
}

pub fn (p &Parser) parse_program() &ast.Program {
	return ast.Program{}
}
