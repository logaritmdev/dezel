#include "Value.h"

namespace Dezel {
namespace Style {

string
Value::toString() {

	string output;

	switch (this->type) {

		case kValueTypeNull:
			output.append("null");
			break;

		case kValueTypeString:
			output.append(static_cast<String*>(this->data)->toString());
			break;

		case kValueTypeNumber:
			output.append(static_cast<Number*>(this->data)->toString());
			break;

		case kValueTypeBoolean:
			output.append(static_cast<Boolean*>(this->data)->toString());
			break;
	}

	switch (this->unit) {

		case kValueUnitNone:
			break;

		case kValueUnitPX:
			output.append("px");
			break;

		case kValueUnitPC:
			output.append("%");
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
