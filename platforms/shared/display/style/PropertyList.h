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

	vector<string> keys;
	vector<Property*> vals;
	unordered_map<string, Property*> data;

public:

	void add(Property* property);

	Property* get(size_t idx) const {
		return this->vals.at(idx);
	}

	Property* get(string key) const {
		return this->data.at(key);
	}

	bool has(string key) const {
		return this->data.find(key) != this->data.end();
	}

	void merge(const PropertyList& dictionary);
	void diffs(const PropertyList& dictionary, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes);

	//--------------------------------------------------------------------------
	// MARK: Iterator
	//--------------------------------------------------------------------------

    typedef vector<Property*>::iterator iterator;
    typedef vector<Property*>::const_iterator const_iterator;

	size_t size() const {
		return this->vals.size();
	}

	inline iterator begin() noexcept {
		return this->vals.begin();
	}

	inline iterator end() noexcept {
		return this->vals.end();
	}

	inline const_iterator cbegin() const noexcept {
		return this->vals.cbegin();
	}

	inline const_iterator cend() const noexcept {
		return this->vals.cend();
	}
};

}
}

#endif
