#ifndef Value_h
#define Value_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

enum ValueType {
	kValueTypeNull,
	kValueTypeString,
	kValueTypeNumber,
	kValueTypeBoolean
};

enum ValueUnit {
	kValueUnitNone,
	kValueUnitPX,
	kValueUnitPC,
	kValueUnitVW,
	kValueUnitVH,
	kValueUnitPW,
	kValueUnitPH,
	kValueUnitCW,
	kValueUnitCH,
	kValueUnitDeg,
	kValueUnitRad
};

class Parser;

class Value {

private:

	struct Data {
		virtual string toString() = 0;
	};

	struct String : Data {

		string value;

		String(string value) : value(value) {}

		string toString() {
			return this->value;
		}
	};

	struct Number : Data {

		double value;

		Number(double value) : value(value) {}

		string toString() {
			return std::to_string(this->value);
		}
	};

	struct Boolean : Data {

		bool value;

		Boolean(bool value) : value(value) {}

		string toString() {
			return std::to_string(this->value);
		}
	};

	ValueType type = kValueTypeNull;
	ValueUnit unit = kValueUnitNone;
	Data* data = nullptr;

	Value() {}

public:

	friend class Parser;

	static Value* createNull() {
		return new Value();
	}

	static Value* createString(string string) {
		auto value = new Value();
		value->data = new String(string);
		value->type = kValueTypeString;
		return value;
	}

	static Value* createNumber(double number) {
		auto value = new Value();
		value->data = new Number(number);
		value->type = kValueTypeNumber;
		return value;
	}

	static Value* createBoolean(bool boolean) {
		auto value = new Value();
		value->data = new Boolean(boolean);
		value->type = kValueTypeBoolean;
		return value;
	}

	string getString() {

		if (this->type == kValueTypeString) {
			return static_cast<String*>(this->data)->value;
		}

		assert(false);
	}

	double getNumber() {

		if (this->type == kValueTypeString) {
			return static_cast<Number*>(this->data)->value;
		}

		assert(false);
	}

	double getBoolean() {

		if (this->type == kValueTypeBoolean) {
			return static_cast<Boolean*>(this->data)->value;
		}

		assert(false);
	}

	string toString();
};

}
}

#endif
