module ast

import (
	token as tk
)

interface Node {
	token_literal() string
}

interface Statement {
	// v Replace with `Node` when implemented
	token_literal() string
	// ^
	statement_node()
}

interface Expression {
	// v Replace with `Node` when implemented
	token_literal() string
	// ^
	expression_node()
}

// The Program node is our root Node for the entire program.
pub struct Program {
pub mut:
	statements []Statement
}

fn (p &Program) token_literal() string {
	if p.statements.len > 0 {
		return p.statements[0].TokenLiteral()
	} else {
		return ''
	}
}


// A LetStatment is what declares a variable. It needs to allow any expression
// be assigned to the Identifier
pub struct LetStatement {
pub:
	token tk.Token
pub mut:
	name  &Identifier
	value Expression
}

fn (ls &LetStatement) statement_node() {}
fn (ls &LetStatement) token_literal() string { return ls.token.literal }

pub struct Identifier {
pub:
	token tk.Token
pub mut:
	value string
}

fn (i &Identifier) expression_node() {}
fn (i &Identifier) token_literal() string { return i.token.literal }

