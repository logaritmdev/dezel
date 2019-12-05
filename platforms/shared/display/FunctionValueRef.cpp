#include "FunctionValueRef.h"
#include "FunctionValue.h"
#include "Value.h"

#include <vector>

using std::vector;

using Dezel::Style::FunctionValue;
using Dezel::Style::Value;

const char*
FunctionValueGetName(FunctionValueRef function)
{
	return reinterpret_cast<FunctionValue*>(function)->getName().c_str();
}

size_t
FunctionValueGetArgumentCount(FunctionValueRef function)
{
	return reinterpret_cast<FunctionValue*>(function)->getArguments().size();
}

ValueListRef
FunctionValueGetArgumentValues(FunctionValueRef function, size_t index)
{
	auto values = &reinterpret_cast<FunctionValue*>(function)->getArguments().at(index)->getValues();

	return reinterpret_cast<ValueListRef>(
		const_cast<vector<Value*>*>(values)
	);
}
