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

static void add(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result)
{
	if (arguments.size() != 2) {
		throw InvalidInvocationException("The function `add` requires 2 arguments.");
	}

	auto aValues = arguments[0]->getValues();
	auto bValues = arguments[1]->getValues();

	if (aValues.size() > 1 ||
		bValues.size() > 1) {
		throw InvalidInvocationException("The function `add` can only add a single value for each parameter.");
	}

	auto aValue = aValues[0];
	auto bValue = bValues[0];

	if (aValue->getType() != kValueTypeNumber ||
		bValue->getType() != kValueTypeNumber) {
		throw InvalidInvocationException("The function `add` can only add numbers.");
	}

	auto aNumber = reinterpret_cast<NumberValue*>(aValue);
	auto bNumber = reinterpret_cast<NumberValue*>(bValue);

	if (aNumber->getUnit() != aNumber->getUnit()) {
		throw InvalidInvocationException("The function `add` can only add a values with the same unit.");
	}

	result.push_back(new NumberValue(aNumber->getValue() + bNumber->getValue(), aNumber->getUnit()));
}

static void sub(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result)
{
	if (arguments.size() != 2) {
		throw InvalidInvocationException("The function `sub` requires 2 arguments.");
	}

	auto aValues = arguments[0]->getValues();
	auto bValues = arguments[1]->getValues();

	if (aValues.size() > 1 ||
		bValues.size() > 1) {
		throw InvalidInvocationException("The function `sub` can only add a single value for each parameter.");
	}

	auto aValue = aValues[0];
	auto bValue = bValues[0];

	if (aValue->getType() != kValueTypeNumber ||
		bValue->getType() != kValueTypeNumber) {
		throw InvalidInvocationException("The function `sub` can only add numbers.");
	}

	auto aNumber = reinterpret_cast<NumberValue*>(aValue);
	auto bNumber = reinterpret_cast<NumberValue*>(bValue);

	if (aNumber->getUnit() != aNumber->getUnit()) {
		throw InvalidInvocationException("The function `sub` can only add a values with the same unit.");
	}

	result.push_back(new NumberValue(aNumber->getValue() - bNumber->getValue(), aNumber->getUnit()));
}

static void min(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result)
{
	if (arguments.size() != 2) {
		throw InvalidInvocationException("The function `min` requires 2 arguments.");
	}

	auto aValues = arguments[0]->getValues();
	auto bValues = arguments[1]->getValues();

	if (aValues.size() > 1 ||
		bValues.size() > 1) {
		throw InvalidInvocationException("The function `min` can only add a single value for each parameter.");
	}

	auto aValue = aValues[0];
	auto bValue = bValues[0];

	if (aValue->getType() != kValueTypeNumber ||
		bValue->getType() != kValueTypeNumber) {
		throw InvalidInvocationException("The function `min` can only add numbers.");
	}

	auto aNumber = reinterpret_cast<NumberValue*>(aValue);
	auto bNumber = reinterpret_cast<NumberValue*>(bValue);

	if (aNumber->getUnit() != aNumber->getUnit()) {
		throw InvalidInvocationException("The function `min` can only add a values with the same unit.");
	}

	result.push_back(new NumberValue(std::min(aNumber->getValue(), bNumber->getValue()), aNumber->getUnit()));
}

static void max(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result)
{
	if (arguments.size() != 2) {
		throw InvalidInvocationException("The function `max` requires 2 arguments.");
	}

	auto aValues = arguments[0]->getValues();
	auto bValues = arguments[1]->getValues();

	if (aValues.size() > 1 ||
		bValues.size() > 1) {
		throw InvalidInvocationException("The function `max` can only add a single value for each parameter.");
	}

	auto aValue = aValues[0];
	auto bValue = bValues[0];

	if (aValue->getType() != kValueTypeNumber ||
		bValue->getType() != kValueTypeNumber) {
		throw InvalidInvocationException("The function `max` can only add numbers.");
	}

	auto aNumber = reinterpret_cast<NumberValue*>(aValue);
	auto bNumber = reinterpret_cast<NumberValue*>(bValue);

	if (aNumber->getUnit() != aNumber->getUnit()) {
		throw InvalidInvocationException("The function `max` can only add a values with the same unit.");
	}

	result.push_back(new NumberValue(std::max(aNumber->getValue(), bNumber->getValue()), aNumber->getUnit()));
}

}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Stylesheet::Stylesheet()
{
	this->addFunction(new Function("add", Functions::add));
	this->addFunction(new Function("sub", Functions::sub));
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
	vector<Value*> values;
	Parser::parse(values, value);

	auto variable = new Variable(name);

	for (auto value : values) {
		variable->values.push_back(value);
	}

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
