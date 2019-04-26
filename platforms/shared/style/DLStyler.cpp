#include <string>
#include <vector>
#include <queue>
#include <iostream>
#include "Stylesheet.h"
#include "StylerStylesheet.h"
#include "StylerTokenizer.h"
#include "StylerParser.h"
#include "StylerException.h"
#include "ProcessingContext.h"
#include "ParseException.h"
#include "DLStyler.h"
#include "DLStylerPrivate.h"
#include "DLStylerNode.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleSelectorPrivate.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"
#include "DLStylerStyleBuilder.h"

DLStylerRef
DLStylerCreate()
{
	return new OpaqueDLStyler;
}

void
DLStylerDelete(DLStylerRef styler)
{
	delete styler;
}

void
DLStylerSetRoot(DLStylerRef styler, DLStylerNodeRef node)
{
	styler->root = node;
}

void
DLStylerLoadStyles(DLStylerRef styler, const char* code, const char* file)
{
	string source;

	for (auto &var : styler->vars) {
		source.append("$");
		source.append(var.first);
		source.append(":");
		source.append(var.second);
		source.append(";");
		source.append("\n");
	}

	source.append(code);

	Stylesheet stylesheet;
	list<const char*> files = {file};
	istringstream stylerSource(source);

	StylerStylesheet stylerStylesheet;
	StylerTokenizer stylerTokenizer(stylerSource, file);
	StylerParser stylerParser(stylerTokenizer, files);

	ProcessingContext* processingContext = new ProcessingContext();

	try {
		stylerParser.parseStylesheet(stylerStylesheet);
	} catch(ParseException* e) {
		cerr << "Error: " << e->getSource() << ": Line " << e->getLineNumber() << ", Column " << e->getColumn() << " Parse Error: " << e->what() << endl;
		return;
	} catch(exception* e) {
		cerr << "Error: " << e->what() << endl;
		return;
	}

	try {
		stylerStylesheet.process(stylesheet, processingContext);
	} catch(ParseException* e) {
		cerr << "Error: " << e->getSource() << ": Line " << e->getLineNumber() << ", Column " << e->getColumn() << " Parse Error: " << e->what() << endl;
		return;
	} catch(StylerException* e) {
		cerr << "Error: " << e->getSource() << ": Line " << e->getLineNumber() << ", Column " << e->getColumn() << " Error: " << e->what() << endl;
		return;
	} catch(exception* e) {
		cerr << "Error: " << e->what() << endl;
		return;
	}

	DLStylerStyleBuilder builder(styler);
	for (auto &statement : stylesheet.getStatements()) {
		statement->write(builder);
	}

	builder.build();

	// DLStylerPrintTypes(styler);
	// DLStylerPrintRules(styler);
}

void
DLStylerSetVariable(DLStylerRef styler, const char* name, const char* value)
{
	styler->vars[string(name)] = string(value);
}

void
DLStylerPrintTypes(DLStylerRef styler)
{
	std::cout << "Types: \n";

	for (auto &pair : styler->types) {

		auto key = pair.first;
		auto val = pair.second;

		std::cout << key << "\n";

		for (auto &pair : val) {
			DLStylerPrintItem(pair.second);
		}

		std::cout << "\n";
	}
}

void
DLStylerPrintRules(DLStylerRef styler)
{
	std::cout << "Rules: \n";

	for (auto &pair : styler->rules) {

		auto key = pair.first;
		auto val = pair.second;

		std::cout << key << "\n";

		for (auto &pair : val->items) {
			DLStylerPrintItem(pair.second);
		}

		std::cout << "\n";
	}
}

void
DLStylerPrintItem(DLStylerStyleItemRef item)
{
	std::cout << "    ";
	std::cout << item->property;
	std::cout << ": ";

	if (item->type == kDLStylerStyleItemTypeNull) {
		std::cout << "(null) null";
	}

	if (item->type == kDLStylerStyleItemTypeNumber) {

		std::cout << "(number)";
		std::cout << " ";
		std::cout << item->num_value;

		switch (item->unit) {

			case kDLStylerStyleItemUnitNone:
				std::cout << " ";
				std::cout << "<no unit>";
				break;

			case kDLStylerStyleItemUnitPX:
				std::cout << "px";
				break;

			case kDLStylerStyleItemUnitPC:
				std::cout << "%";
				break;

			case kDLStylerStyleItemUnitVW:
				std::cout << "vw";
				break;

			case kDLStylerStyleItemUnitVH:
				std::cout << "vh";
				break;

			case kDLStylerStyleItemUnitPW:
				std::cout << "pw";
				break;

			case kDLStylerStyleItemUnitPH:
				std::cout << "ph";
				break;

			case kDLStylerStyleItemUnitCW:
				std::cout << "cw";
				break;

			case kDLStylerStyleItemUnitCH:
				std::cout << "ch";
				break;

			case kDLStylerStyleItemUnitDeg:
				std::cout << "deg";
				break;

			case kDLStylerStyleItemUnitRad:
				std::cout << "rad";
				break;
		}
	}

	if (item->type == kDLStylerStyleItemTypeString) {
		std::cout << "(string)";
		std::cout << " ";
		std::cout << item->str_value;
	}

	if (item->type == kDLStylerStyleItemTypeBoolean) {
		std::cout << "(boolean)";
		std::cout << " ";
		std::cout << item->boo_value;
	}

	std::cout << "\n";
}
