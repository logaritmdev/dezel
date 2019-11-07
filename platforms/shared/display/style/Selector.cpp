#include "Selector.h"
#include "Fragment.h"

#include <iostream>

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

string
Selector::toString(int depth) const
{
   string output;

	output.append(depth * 2, ' ');

   auto selector = this->head;

   while (selector) {

	   if (output.length()) {
		   output.append(" ");
	   }

	   output.append(selector->toString());

	   selector = selector->getNext();
   }

   return output;
}

}
}
