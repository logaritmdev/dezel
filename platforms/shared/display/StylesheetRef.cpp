#include "StylesheetRef.h"
#include "Stylesheet.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Parser.h"
#include "ParseException.h"

#include <string>

using Dezel::Style::Stylesheet;
using Dezel::Style::Tokenizer;
using Dezel::Style::TokenizerStream;
using Dezel::Style::Parser;
using Dezel::Style::ParseException;

StylesheetRef
StylesheetCreate()
{
	return reinterpret_cast<StylesheetRef>(new Stylesheet());
}

void
StylesheetDelete(StylesheetRef stylesheet)
{
	delete reinterpret_cast<Stylesheet*>(stylesheet);
}

void
StylesheetSetVariable(StylesheetRef stylesheet, const char* name, const char* value, ParseError** error)
{
	try {

		reinterpret_cast<Stylesheet*>(stylesheet)->setVariable(std::string(name), std::string(value));

	} catch (ParseException& e) {

		*error = new ParseError();
		(*error)->message = strdup(e.getMessage().c_str());
		(*error)->url = strdup(e.getFile().c_str());
		(*error)->col = static_cast<unsigned>(e.getCol());
		(*error)->row = static_cast<unsigned>(e.getRow());

	}
}

void
StylesheetEvaluate(StylesheetRef stylesheet, const char* source, const char* url, ParseError** error)
{
	try {

		reinterpret_cast<Stylesheet*>(stylesheet)->evaluate(std::string(source), std::string(url));

	} catch (ParseException& e) {

		*error = new ParseError();
		(*error)->message = strdup(e.getMessage().c_str());
		(*error)->url = strdup(e.getFile().c_str());
		(*error)->col = static_cast<unsigned>(e.getCol());
		(*error)->row = static_cast<unsigned>(e.getRow());

	}
}


