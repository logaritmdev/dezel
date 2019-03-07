#ifndef __value_BooleanValue_h__
#define __value_BooleanValue_h__

#include "StringValue.h"
#include "Value.h"
#include "ValueException.h"

/**
 * True or false.
 */
class BooleanValue : public Value {
private:
	bool value;

public:
	BooleanValue(bool value);
	BooleanValue(const Token &t, bool value);
	virtual ~BooleanValue();
	bool getValue() const;
	void setValue(bool value);
	virtual Value *operator+(const Value &v) const;
	virtual Value *operator-(const Value &v) const;
	virtual Value *operator*(const Value &v) const;
	virtual Value *operator/(const Value &v) const;
	virtual bool operator==(const Value &v) const;
	virtual bool operator<(const Value &v) const;
};

#endif  // __value_BooleanValue_h__
