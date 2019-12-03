#include "FunctionValueRef.h"
#include "FunctionValue.h"

using Dezel::Style::FunctionValue;

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

ValueRef
FunctionValueGetArgumentValue(FunctionValueRef function, size_t index)
{
	return reinterpret_cast<ValueRef>(
		reinterpret_cast<FunctionValue*>(function)->getArguments().at(index)
	);
}
