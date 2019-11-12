
#include "PropertyList.h"

namespace Dezel {
namespace Style {

using std::rotate;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
PropertyList::set(string name, Property* property)
{
	if (this->has(name)) {

		auto index = this->order[name];

		rotate(
			this->array.begin() + index,
			this->array.begin() + index + 1,
			this->array.end()
		);

		auto position = this->array.size() - 1;

		this->items[name] = property;
		this->order[name] = position;
		return;
	}

	auto position = this->array.size();

	this->items[name] = property;
	this->order[name] = position;
	this->array.push_back(property);
}

void
PropertyList::merge(const PropertyList& dictionary)
{
	for (auto property : dictionary.array) {
		this->set(
			property->getName(),
			property
		);
	}
}

void
PropertyList::diffs(const PropertyList& dictionary, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes)
{
	auto remains = dictionary.items;

	for (auto & item : this->items) {

		const auto key = item.first;
		const auto val = item.second;

		remains.erase(key);

		if (dictionary.has(key) == false) {
			removes.push_back(val);
			continue;
		}

		if (dictionary.get(key) != val) {
			updates.push_back(val);
			continue;
		}
	}

	for (auto & item : remains) {
		inserts.push_back(item.second);
	}
}

}
}
