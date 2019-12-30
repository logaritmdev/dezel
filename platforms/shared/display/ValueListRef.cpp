#include "ValueListRef.h"
#include "Value.h"

#include <string>
#include <vector>

using std::string;
using std::vector;

using Dezel::Style::Value;

void
ValueListDelete(ValueListRef values)
{
	auto items = reinterpret_cast<vector<Value*>*>(values);

	for (auto value : *items) {
		delete value;
	}

	delete items;
}

size_t
ValueListGetCount(ValueListRef values)
{
	return reinterpret_cast<vector<Value*>*>(values)->size();
}

ValueRef
ValueListGetValue(ValueListRef values, size_t index)
{
	return reinterpret_cast<ValueRef>(
		reinterpret_cast<vector<Value*>*>(values)->at(index)
	);
}
