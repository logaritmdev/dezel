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
	vector<Property*> list;
	unordered_map<string, Property*> data;

	static void diff(
		const PropertyList& initial,
		const PropertyList& current,
		vector<Property*>& inserts,
		vector<Property*>& updates,
		vector<Property*>& removes
	);

public:

	void add(Property* property);

	Property* get(size_t idx) const {
		return this->list.at(idx);
	}

	Property* get(string key) const {
		return this->data.at(key);
	}

	bool has(string key) const {
		return this->data.find(key) != this->data.end();
	}

	void merge(const PropertyList& properties);
	void diffs(const PropertyList& properties, vector<Property*>& inserts, vector<Property*>& updates, vector<Property*>& removes);
	void clear();

	//--------------------------------------------------------------------------
	// MARK: Iterator
	//--------------------------------------------------------------------------

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
