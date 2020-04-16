module parser

import (
	ast
	lexer
)

fn test_let_statements() {
	input := 'let x = 5;
	         |let y = 10;
	         |let foobar = 838383;
	         |
	         '.strip_margin()
	l := lexer.new_lexer(input)
	p := new(l)

	program := p.parse_program()
	if program.statements.len == 0 {
		eprintln("parse_program() returned empty program.")
		assert false
	}
	if program.statements.len != 3 {
		eprint("program does not contain 3 statements, ")
		eprintln("but ${program.statements.len}")
		assert false
	}
	tests := []string {
		"x",
		"y",
		"foobar",
	}

	for i, t in tests {
		stmt := program.statements[i]
		if !let_statment(stmt, tt) {
			assert false
		}
	}
}

fn let_statement(s ast.Statement, name string) bool {
	if s.token_literal() != "let" {
		eprintln("s.token_literal != 'let', got '${s.token_literal}'")
		return false
	}
	match s {
		ast.LetStatement {
			if it.name.value != name {
				eprint("LetStatement Name.Value != ${name}, ")
				eprintln("got ${it.name.value}")
				return false
			}
			if it.name.token_literal() != name {
				eprint("it.name.token_literal() not ${name}, ")
				eprintln("got ${it.name.token_literal()}")
				return false
			}
		}
		else {
			eprintln("s is not a LetStatement, got ${typeof(s)}.")
			return false
		}
	}
}

