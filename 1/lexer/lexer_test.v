module lexer

import token

pub struct LexText{
	expected_type    token.TokenType
	expected_literal string
}

fn test_special_tokens() {
	input := "=+-!*/<>(){},;"

	tests := [
		LexText{ token.TokenType.tok_assign, "=" },
		LexText{ token.TokenType.tok_plus, "+" },
		LexText{ token.TokenType.tok_minus, "-" },
		LexText{ token.TokenType.tok_bang, "!" },
		LexText{ token.TokenType.tok_asterisk, "*" },
		LexText{ token.TokenType.tok_slash, "/" },
		LexText{ token.TokenType.tok_lt, "<" },
		LexText{ token.TokenType.tok_gt, ">" },
		LexText{ token.TokenType.tok_lparen, "(" },
		LexText{ token.TokenType.tok_rparen, ")" },
		LexText{ token.TokenType.tok_lbrace, "{" },
		LexText{ token.TokenType.tok_rbrace, "}" },
		LexText{ token.TokenType.tok_comma, "," },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_eof, "" },
	]

	mut l := new(input)

	for i, tt in tests {
		tok := l.next_token()

		if tok.literal != tt.expected_literal {
			eprintln('tests[$i] - literal wrong. expected "${tt.expected_literal}", got "${tok.literal}"')
			assert false
		}
		if tok.token != tt.expected_type {
			eprintln('tests[$i] - token type wrong. expected "${tt.expected_type}", got "${tok.token}"')
			assert false
		}
	}
	println("Finished `test_special_tokens` successfully!")
}

fn test_lang_subset() {
	input := 'let five = 5;
	         |let ten = 10;
	         |
	         |let add = fn(x, y) {
	         |	x + y;
	         |};
	         |
	         |let result = add(five, ten);
	         |
	         |if (5 < 10) {
	         |	return true;
	         |} else {
	         |	return false;
	         |}
	         |
	         |10 == 10;
	         |10 != 9;
	         |
	         '.strip_margin()
	tests := [
		LexText{ token.TokenType.tok_let, "let" },
		LexText{ token.TokenType.tok_ident, "five" },
		LexText{ token.TokenType.tok_assign, "=" },
		LexText{ token.TokenType.tok_int, "5" },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_let, "let" },
		LexText{ token.TokenType.tok_ident, "ten" },
		LexText{ token.TokenType.tok_assign, "=" },
		LexText{ token.TokenType.tok_int, "10" },
		LexText{ token.TokenType.tok_semicolon, ";" },

		LexText{ token.TokenType.tok_let, "let" },
		LexText{ token.TokenType.tok_ident, "add" },
		LexText{ token.TokenType.tok_assign, "=" },
		LexText{ token.TokenType.tok_func, "fn" },
		LexText{ token.TokenType.tok_lparen, "(" },
		LexText{ token.TokenType.tok_ident, "x" },
		LexText{ token.TokenType.tok_comma, "," },
		LexText{ token.TokenType.tok_ident, "y" },
		LexText{ token.TokenType.tok_rparen, ")" },
		LexText{ token.TokenType.tok_lbrace, "{" },
		LexText{ token.TokenType.tok_ident, "x" },
		LexText{ token.TokenType.tok_plus, "+" },
		LexText{ token.TokenType.tok_ident, "y" },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_rbrace, "}" },
		LexText{ token.TokenType.tok_semicolon, ";" },

		LexText{ token.TokenType.tok_let, "let" },
		LexText{ token.TokenType.tok_ident, "result" },
		LexText{ token.TokenType.tok_assign, "=" },
		LexText{ token.TokenType.tok_ident, "add" },
		LexText{ token.TokenType.tok_lparen, "(" },
		LexText{ token.TokenType.tok_ident, "five" },
		LexText{ token.TokenType.tok_comma, "," },
		LexText{ token.TokenType.tok_ident, "ten" },
		LexText{ token.TokenType.tok_rparen, ")" },
		LexText{ token.TokenType.tok_semicolon, ";" },

		LexText{ token.TokenType.tok_if, "if" },
		LexText{ token.TokenType.tok_lparen, "(" },
		LexText{ token.TokenType.tok_int, "5" },
		LexText{ token.TokenType.tok_lt, "<" },
		LexText{ token.TokenType.tok_int, "10" },
		LexText{ token.TokenType.tok_rparen, ")" },
		LexText{ token.TokenType.tok_lbrace, "{" },
		LexText{ token.TokenType.tok_return, "return" },
		LexText{ token.TokenType.tok_true, "true" },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_rbrace, "}" },
		LexText{ token.TokenType.tok_else, "else" },
		LexText{ token.TokenType.tok_lbrace, "{" },
		LexText{ token.TokenType.tok_return, "return" },
		LexText{ token.TokenType.tok_false, "false" },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_rbrace, "}" },

		LexText{ token.TokenType.tok_int, "10" },
		LexText{ token.TokenType.tok_eq, "==" },
		LexText{ token.TokenType.tok_int, "10" },
		LexText{ token.TokenType.tok_semicolon, ";" },
		LexText{ token.TokenType.tok_int, "10" },
		LexText{ token.TokenType.tok_not_eq, "!=" },
		LexText{ token.TokenType.tok_int, "9" },
		LexText{ token.TokenType.tok_semicolon, ";" },

		// End of the test string
		LexText{ token.TokenType.tok_eof, "" },
	]
	mut l := new(input)

	for i, tt in tests {
		tok := l.next_token()

		if tok.literal != tt.expected_literal {
			eprintln('tests[$i] - literal wrong. expected "${tt.expected_literal}", got "${tok.literal}"')
			assert false
		}
		if tok.token != tt.expected_type {
			eprintln('tests[$i] - token type wrong. expected "${tt.expected_type}", got "${tok.token}"')
			assert false
		}
	}
	println("Finished `test_lang_subset` successfully!")
}

