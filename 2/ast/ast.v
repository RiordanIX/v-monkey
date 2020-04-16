module ast

import (
	token as tk
)

pub type Statement = LetStatement

pub type Expression = Identifier

// The Program node is our root Node for the entire program.
pub struct Program {
pub mut:
	statements []Statement
}

pub fn (p &Program) token_literal() string {
	if p.statements.len > 0 {
		return p.statements[0].token_literal()
	} else {
		return ''
	}
}


// STATEMENTS::::::::
// A LetStatement is what declares a variable. It needs to allow any expression
// be assigned to the Identifier
pub struct LetStatement {
pub:
	token tk.Token
pub mut:
	name  &Identifier
	value Expression
}

pub fn (s &Statement) token_literal() string {
	match s {
		else {return it.token.literal }
	}
}

// EXPRESSIONS::::::::::
pub struct Identifier {
pub:
	token tk.Token
pub mut:
	value string
}

pub fn (e &Expression) token_literal() string {
	match e {
		else {return it.token.literal }
	}
}

