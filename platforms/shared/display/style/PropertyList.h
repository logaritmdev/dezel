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

	vector<Property*> list;
	unordered_map<string, size_t> keys;
	unordered_map<string, Property*> vals;

public:

	void set(string name, Property* property);

	Property* get(size_t at) const {
		return this->list.at(at);
	}

	Property* get(string at) const {
		return this->vals.at(at);
	}

	void merge(const PropertyList& dictionary);

    typedef vector<Property*>::iterator iterator;
    typedef vector<Property*>::const_iterator const_iterator;

	size_t size() const {
		return this->list.size();
	}

	inline iterator begin() noexcept {
		return this->list.begin();
	}

	inline iterator end() noexcept {
		return this->list.end();
	}

	inline const_iterator cbegin() const noexcept {
		return this->list.cbegin();
	}

	inline const_iterator cend() const noexcept {
		return this->list.cend();
	}
};

}
}

#endif
