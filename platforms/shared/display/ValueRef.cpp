#include "ValueRef.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "Parser.h"
#include "ParseException.h"

#include <string>
#include <vector>

using std::string;
using std::vector;

using Dezel::Style::Value;
using Dezel::Style::StringValue;
using Dezel::Style::NumberValue;
using Dezel::Style::BooleanValue;
using Dezel::Style::Parser;
using Dezel::Style::ParseException;

void
ValueParse(const char* source, void* context, ValueParseCallback callback)
{
	vector<Value*> values;

	try {
		Parser::parse(values, string(source));
	} catch (ParseException& e) {
		return;
	}

	auto count = values.size();

	if (count == 0) {
		return;
	}

	auto value = reinterpret_cast<ValueRef*>(&values[0]);

	callback(
		value,
		count,
		context
	);

	for (auto value : values) {
		delete value;
	}
}

ValueType
ValueGetType(ValueRef value)
{
	return reinterpret_cast<Value*>(value)->getType();
}

ValueUnit
ValueGetUnit(ValueRef value)
{
	return reinterpret_cast<Value*>(value)->getUnit();
}

const char*
ValueGetString(ValueRef value)
{
	return reinterpret_cast<StringValue*>(
		reinterpret_cast<Value*>(value)
	)->getValue().c_str();
}

double
ValueGetNumber(ValueRef value)
{
	return reinterpret_cast<NumberValue*>(
		reinterpret_cast<Value*>(value)
	)->getValue();
}

bool
ValueGetBoolean(ValueRef value)
{
	return reinterpret_cast<BooleanValue*>(
		reinterpret_cast<Value*>(value)
	)->getValue();
}

VariableValueRef
ValueGetVariable(ValueRef value)
{
	return reinterpret_cast<VariableValueRef>(value);
}

FunctionValueRef
ValueGetFunction(ValueRef value)
{
	return reinterpret_cast<FunctionValueRef>(value);
}
