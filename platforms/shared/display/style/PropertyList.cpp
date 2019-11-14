
#include "PropertyList.h"

#include <iostream>
#include <iterator>

namespace Dezel {
namespace Style {

using std::rotate;
using std::distance;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
PropertyList::add(Property* property)
{
	auto name = property->getName();

	if (this->has(name)) {

		auto dist = distance(this->keys.begin(), find(
			this->keys.begin(),
			this->keys.end(),
			name
		));

		rotate(
			this->keys.begin() + dist,
			this->keys.begin() + dist + 1,
			this->keys.end()
		);

		this->vals[dist] = property;

		rotate(
			this->vals.begin() + dist,
			this->vals.begin() + dist + 1,
			this->vals.end()
		);

		this->data[name] = property;
		return;
	}

	this->keys.push_back(name);
	this->vals.push_back(property);
	this->data[name] = property;
}

void
PropertyList::merge(const PropertyList& dictionary)
{
	if (this->size() == 0) {
		this->keys = dictionary.keys;
		this->vals = dictionary.vals;
		this->data = dictionary.data;
		return;
	}

	for (auto property : dictionary.vals) {
		this->add(property);
	}
}

void
PropertyList::diffs(const PropertyList& dictionary, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes)
{
	auto remains = dictionary.data;

	for (auto & property : this->data) {

		const auto key = property.first;
		const auto val = property.second;

		remains.erase(key);

		if (dictionary.has(key) == false) {
			removes.push_back(val);
			continue;
		}

		const auto cur = dictionary.get(key);

		if (cur != val) {
			updates.push_back(cur);
			continue;
		}
	}

	for (auto & item : remains) {
		inserts.push_back(item.second);
	}
}

}
}
