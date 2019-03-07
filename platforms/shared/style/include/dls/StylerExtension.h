#ifndef __Extension_h__
#define __Extension_h__

#include "Selector.h"

class StylerExtension {
private:
	Selector target;
	Selector extension;
	bool all;

public:
	StylerExtension();
	virtual ~StylerExtension();
	Selector &getTarget();
	Selector &getExtension();
	const Selector &getTarget() const;
	const Selector &getExtension() const;
	void setExtension(const Selector &extension);
	void setAll(bool b);
	bool isAll() const;
	void updateSelector(Selector &s) const;
	void replaceInSelector(Selector &s) const;
};

#endif  // __Extension_h__
