#include "Rule.h"
#include "Selector.h"

#include <iostream>

namespace Dezel {
namespace Style {

string
Rule::toString(int depth)
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
