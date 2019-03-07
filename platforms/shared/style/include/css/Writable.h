#ifndef __CssWritable_h__
#define __CssWritable_h__

#include "Writer.h"

class Writable {
public:
	virtual void write(Writer &css) const = 0;
};

#endif  // __CssWritable_h__
