#include "Parser.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"

namespace View::Style {

Parser::Parser()
{

}

void
Parser::parse(const string input)
{
	TokenizerStream stream(input);
	Tokenizer tokenizer(stream);

	while (true) {
		auto token = tokenizer.next();
		if (token.getTokenType() == kTokenTypeEOF) {
			break;
		}
	}
}

}
