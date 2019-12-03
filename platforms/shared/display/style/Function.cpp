#include "Function.h"
#include "InvalidInvocationException.h"

#include <string>

namespace Dezel {
namespace Style {

using std::to_string;

Function::Function(string name, Callback callback) : name(name), callback(callback)
{

}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

}
}
