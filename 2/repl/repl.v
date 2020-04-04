module repl

import (
	os
	lexer
	token
)

const (
	prompt = ">> "
)

pub fn start() {
	for {
		print(prompt)
		line := os.get_line()
		if line == "" { break }
		mut l := lexer.new_lexer(line)
		mut tok := l.next_token()

		for tok.token != token.TokenType.tok_eof {
			println("token #${tok.token}: ${tok.literal}")
			tok = l.next_token()
		}
	}
}
