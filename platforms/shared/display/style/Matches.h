#ifndef Matches_h
#define Matches_h

#include "Match.h"

#include <vector>

namespace Dezel {
namespace Style {

class Matches : public std::vector<Match> {

public:

	void order();

};

}
}

#endif
