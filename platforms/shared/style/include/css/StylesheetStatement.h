#ifndef __StylesheetStatement_h__
#define __StylesheetStatement_h__

#include "Writable.h"
#include "Stylesheet.h"

class StylesheetStatement : public Writable {
protected:
	Stylesheet *stylesheet;
	bool reference;

public:
	StylesheetStatement() : reference(false) {};
	virtual ~StylesheetStatement() {};
	virtual void setStylesheet(Stylesheet *s);
	Stylesheet *getStylesheet() const;
	void setReference(bool ref);
	bool isReference() const;
	virtual void process(Stylesheet &s, void *context) const = 0;
};

#endif  // __StylesheetStatement_h__
