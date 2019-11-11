
#include "PropertyList.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
PropertyList::set(string name, Property* property)
{
// TODO
// Si une propriété est ajouté par après mais uqe la key existe déja
// on enleve mais on fait toujours un push back
	if (this->vals.find(name) != this->vals.end()) {
		this->vals[name] = property;
		return;
	}

	const auto position = this->list.size();

	this->vals[name] = property;
	this->keys[name] = position;
	this->list.push_back(property);
}

void
PropertyList::merge(const PropertyList& dictionary)
{
	for (auto property : dictionary.list) {
		this->set(property->getName(), property);
	}
}


}
}
