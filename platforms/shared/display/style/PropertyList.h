#ifndef PropertyList_h
#define PropertyList_h

#include "Property.h"

#include <string>
#include <vector>
#include <unordered_map>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;
using std::unordered_map;

class PropertyList {

private:

	vector<Property*> array;
	unordered_map<string, size_t> order;
	unordered_map<string, Property*> items;

public:

	void set(string name, Property* property);

	Property* get(size_t idx) const {
		return this->array.at(idx);
	}

	Property* get(string key) const {
		return this->items.at(key);
	}

	bool has(string key) const {
		return this->items.find(key) != this->items.end();
	}

	void merge(const PropertyList& dictionary);
	void diffs(const PropertyList& dictionary, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes);

	//--------------------------------------------------------------------------
	// MARK: Iterator
	//--------------------------------------------------------------------------

    typedef vector<Property*>::iterator iterator;
    typedef vector<Property*>::const_iterator const_iterator;

	size_t size() const {
		return this->array.size();
	}

	inline iterator begin() noexcept {
		return this->array.begin();
	}

	inline iterator end() noexcept {
		return this->array.end();
	}

	inline const_iterator cbegin() const noexcept {
		return this->array.cbegin();
	}

	inline const_iterator cend() const noexcept {
		return this->array.cend();
	}
};

}
}

#endif
