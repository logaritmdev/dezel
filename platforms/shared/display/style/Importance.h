#ifndef Importance_h
#define Importance_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

struct Importance {

	int type = 0;
	int name = 0;
	int style = 0;
	int state = 0;

	bool operator == (const Importance& b) const  {
		return (
			this->style == b.style &&
			this->state == b.state &&
			this->name == b.name &&
			this->type == b.type
		);
	}

	bool operator > (const Importance& b) const {
		if (this->style > b.style) return true;
		if (this->state > b.state) return true;
		if (this->name > b.name) return true;
		if (this->type > b.type) return true;
		return false;
	}

	bool operator < (const Importance& b) const {
		if (this->style < b.style) return true;
		if (this->state < b.state) return true;
		if (this->name < b.name) return true;
		if (this->type < b.type) return true;
		return false;
	}

	string toString() const;

};

}
}

#endif
