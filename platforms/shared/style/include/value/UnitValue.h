#ifndef __value_UnitValue_h__
#define __value_UnitValue_h__

#include "StringValue.h"
#include "Value.h"
#include "ValueException.h"

/**
 * A dimension unit: em,ex,px,ch,in,cm,mm,pt,pc
 */
class UnitValue : public Value {
public:
	enum UnitGroup { NO_GROUP, LENGTH, TIME, ANGLE };
	UnitValue(Token &token);
	virtual ~UnitValue();
	const char *getUnit() const;
	virtual Value *operator+(const Value &v) const;
	virtual Value *operator-(const Value &v) const;
	virtual Value *operator*(const Value &v) const;
	virtual Value *operator/(const Value &v) const;
	virtual bool operator<(const Value &v) const;
	virtual bool operator==(const Value &v) const;
	static UnitGroup getUnitGroup(const std::string &unit);
	static double lengthToPx(const double length, const std::string &unit);
	static double pxToLength(double px, const std::string &unit);
	static double timeToMs(double time, const std::string &unit);
	static double msToTime(double ms, const std::string &unit);
	static double angleToRad(double angle, const std::string &unit);
	static double radToAngle(double rad, const std::string &unit);
};

#endif  // __value_UnitValue_h__
