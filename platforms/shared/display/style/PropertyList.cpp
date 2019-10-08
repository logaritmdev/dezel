
#include "PropertyList.h"

namespace Dezel {
namespace Style {

void
PropertyList::set(string name, Property* property)
{
	if (this->vals.count(name) > 0) {
		this->vals[name] = property;
		return;
	}

	const auto position = this->list.size();

	this->vals[name] = property;
	this->keys[name] = position;
	this->list.push_back(property);
}

}
}
