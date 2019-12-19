
#include "PropertyList.h"

#include <iostream>
#include <iterator>

namespace Dezel {
namespace Style {

using std::rotate;
using std::distance;

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

void
PropertyList::diff(const PropertyList& initial, const PropertyList& current, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes)
{
	/*
	 * The initial property list is empty, all items from the
	 * current will be inserted.
	 */

	if (initial.size() == 0) {
		inserts = current.list;
		return;
	}

	/*
	 * The current property list is empty, all items from the
	 * initial will be removed
	 */

	if (current.size() == 0) {
		removes = initial.list;
		return;
	}

	/*
	 * Compare the element from the current list. Once completed we will have
	 * the elements that needs to be removed and these do not need to be
	 * ordered by their insertion index
	 */

	auto remains = initial.data;

	for (auto property : current.list) {

		auto key = property->getName();

		remains.erase(key);

		if (initial.has(key) == false) {
			inserts.push_back(property);
			continue;
		}

		if (initial.get(key) != property) {
			updates.push_back(property);
			continue;
		}
	}

	/*
	 * If we were to compare by looping through the initial properties instead
	 * the code below would contains the insertion. In order to keep the
	 * proper insertion order, we would have push the properties in the same
	 * order they appear in the list vector.
	 */

	for (auto property : remains) {
		removes.push_back(property.second);
	}
}

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

		this->list[dist] = property;

		rotate(
			this->list.begin() + dist,
			this->list.begin() + dist + 1,
			this->list.end()
		);

		this->data[name] = property;
		return;
	}

	this->keys.push_back(name);
	this->list.push_back(property);
	this->data[name] = property;
}

void
PropertyList::merge(const PropertyList& dictionary)
{
	if (this->size() == 0) {
		this->keys = dictionary.keys;
		this->list = dictionary.list;
		this->data = dictionary.data;
		return;
	}

	for (auto property : dictionary.list) {
		this->add(property);
	}
}

void
PropertyList::diffs(const PropertyList& properties, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes)
{
	PropertyList::diff(*this, properties, inserts, updates, removes);
}

void
PropertyList::clear()
{
	this->keys.clear();
	this->list.clear();
	this->data.clear();
}

}
}
