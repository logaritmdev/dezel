#include "Stylesheet.h"
#include "Descriptor.h"
#include "Function.h"
#include "Variable.h"
#include "Selector.h"
#include "Fragment.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Parser.h"
#include "InvalidInvocationException.h"

namespace Dezel {
namespace Style {

using std::min;

//------------------------------------------------------------------------------
// MARK: Default Functions
//------------------------------------------------------------------------------

namespace Functions {

static void min(const Function* function, const vector<Argument>& arguments, vector<Value*> result)
{
	function->assertArgumentCount(arguments, 2);

	auto arg1 = arguments[0].getValues();
	auto arg2 = arguments[1].getValues();

	if (arg1.size() != arg2.size()) {
		throw InvalidInvocationException(
			"The function `min` requires that each argument have the same amount of values."
		);
	}

	auto length = arg1.size();

	result.reserve(length);

	for (int i = 0; i < length; i++) {

		auto va = arg1[i];
		auto vb = arg2[i];

		if (va->getType() != kValueTypeNumber ||
			vb->getType() != kValueTypeNumber) {
			throw InvalidInvocationException(
				"The function `min` requires that each argument must be a number."
			);
		}

		if (va->getUnit() != vb->getUnit()) {
			throw InvalidInvocationException(
				"The function `min` requires that each argument have the same type and unit."
			);
		}

		auto na = reinterpret_cast<NumberValue*>(va)->getValue();
		auto nb = reinterpret_cast<NumberValue*>(va)->getValue();

		result.push_back(new NumberValue(std::min(na, nb), va->getUnit()));
	}
}

static void max(const Function* function, const vector<Argument>& arguments, vector<Value*> result)
{
	function->assertArgumentCount(arguments, 2);

	auto arg1 = arguments[0].getValues();
	auto arg2 = arguments[1].getValues();

	if (arg1.size() != arg2.size()) {
		throw InvalidInvocationException(
			"The function `min` requires that each argument have the same amount of values."
		);
	}

	auto length = arg1.size();

	result.reserve(length);

	for (int i = 0; i < length; i++) {

		auto va = arg1[i];
		auto vb = arg2[i];

		if (va->getType() != kValueTypeNumber ||
			vb->getType() != kValueTypeNumber) {
			throw InvalidInvocationException(
				"The function `min` requires that each argument must be a number."
			);
		}

		if (va->getUnit() != vb->getUnit()) {
			throw InvalidInvocationException(
				"The function `min` requires that each argument have the same type and unit."
			);
		}

		auto na = reinterpret_cast<NumberValue*>(va)->getValue();
		auto nb = reinterpret_cast<NumberValue*>(va)->getValue();

		result.push_back(new NumberValue(std::max(na, nb), va->getUnit()));
	}
}

}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Stylesheet::Stylesheet()
{
	this->addFunction(new Function("min", Functions::min));
	this->addFunction(new Function("max", Functions::max));
}

Stylesheet::~Stylesheet()
{
	for (auto variable : this->variables) delete variable.second;
	for (auto function : this->functions) delete function.second;
}

void
Stylesheet::setVariable(string name, string value)
{
	auto variable = new Variable(name);
	Parser::parse(variable, value);
	this->addVariable(variable);
}

void
Stylesheet::evaluate(string source)
{
	Parser::parse(this, source);
}

void
Stylesheet::evaluate(string source, string url)
{
	Parser::parse(this, source, url);
}

void
Stylesheet::addVariable(Variable* variable)
{
	this->variables[variable->name] = variable;
}

void
Stylesheet::addFunction(Function* function)
{
	this->functions[function->name] = function;
}

void
Stylesheet::addDescriptor(Descriptor* descriptor)
{
	if (descriptor->parent == nullptr) {
		this->rootDescriptors.push_back(descriptor);
	}

	if (descriptor->properties.size() > 0) {
		this->ruleDescriptors.push_back(descriptor);
	}

	for (auto child : descriptor->childDescriptors) {
		this->addDescriptor(child);
	}
}

}
}
