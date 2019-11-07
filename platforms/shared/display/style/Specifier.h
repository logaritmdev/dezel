#ifndef Weight_h
#define Weight_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

struct Specifier {

	int type = 0;
	int name = 0;
	int style = 0;
	int state = 0;

	bool operator == (const Specifier& b) const  {
		return (
			this->style == b.style &&
			this->state == b.state &&
			this->name == b.name &&
			this->type == b.type
		);
	}

	bool operator > (const Specifier& b) const {
		if (this->style > b.style) return true;
		if (this->state > b.state) return true;
		if (this->name > b.name) return true;
		if (this->type > b.type) return true;
		return false;
	}

	bool operator < (const Specifier& b) const {
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
