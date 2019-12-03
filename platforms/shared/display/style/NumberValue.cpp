#include "NumberValue.h"

namespace Dezel {
namespace Style {

using std::to_string;
using std::stod;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

NumberValue::NumberValue(double value, ValueUnit unit) : Value(kValueTypeNumber, unit), value(value)
{

}

NumberValue::NumberValue(string value, ValueUnit unit) : Value(kValueTypeNumber, unit), value(stod(value))
{

}

NumberValue::~NumberValue()
{

}

string
NumberValue::toString()
{
	string output = to_string(this->value);

	switch (this->unit) {
		case kValueUnitNone:
			break;
		case kValueUnitPC:
			output.append("%");
			break;
		case kValueUnitPX:
			output.append("px");
			break;
		case kValueUnitVW:
			output.append("vw");
			break;
		case kValueUnitVH:
			output.append("vh");
			break;
		case kValueUnitPW:
			output.append("pw");
			break;
		case kValueUnitPH:
			output.append("ph");
			break;
		case kValueUnitCW:
			output.append("cw");
			break;
		case kValueUnitCH:
			output.append("ch");
			break;
		case kValueUnitDeg:
			output.append("deg");
			break;
		case kValueUnitRad:
			output.append("rad");
			break;
	}

	return output;
}

}
}
