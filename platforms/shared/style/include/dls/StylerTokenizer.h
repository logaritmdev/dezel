#ifndef __less_LessTokenizer_h__
#define __less_LessTokenizer_h__

#include <iostream>
#include "Tokenizer.h"

class StylerTokenizer : public Tokenizer {
public:
	StylerTokenizer(istream &in, const char *source) : Tokenizer(in, source) {};
	virtual ~StylerTokenizer();

protected:
	bool readComment();
};

#endif  // __less_LessTokenizer_h__
