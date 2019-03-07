#ifndef __value_NumberValue_h__
#define __value_NumberValue_h__

#include <cmath>
#include <vector>
#include "StringValue.h"
#include "UnitValue.h"
#include "Value.h"


class NumberValue : public Value {

	void verifyUnits(const NumberValue &n);

public:
	NumberValue(const Token &token);
	NumberValue(double value);
	NumberValue(double value, Token::Type type, const std::string *unit);
	NumberValue(const NumberValue &n);
	virtual ~NumberValue();
	static bool isNumber(const Value &val);
	double convert(const std::string &unit) const;
	virtual Value *operator+(const Value &v) const;
	virtual Value *operator-(const Value &v) const;
	virtual Value *operator*(const Value &v) const;
	virtual Value *operator/(const Value &v) const;
	virtual bool operator==(const Value &v) const;
	virtual bool operator<(const Value &v) const;
	void setType(const NumberValue &n);
	std::string getUnit() const;
	void setUnit(std::string unit);
	double getValue() const;
	void setValue(double d);
};

#endif  // __value_NumberValue_h__
