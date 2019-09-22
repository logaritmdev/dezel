#ifndef TokenizerStream_h
#define TokenizerStream_h

#include <string>

namespace View::Style {

using std::string;
using std::min;

/**
 * @class TokenizerStream
 * @since 0.7.0
 */
class TokenizerStream {

private:

	string input;
	size_t length;
	size_t offset;

	char at(size_t index);

public:

	TokenizerStream(const string &input);

	char read();
	char peek(size_t offset = 0);
	void next(size_t offset = 1);
	void back(size_t offset = 1);

	string substring(size_t length);
	string substring(size_t offset, size_t length);

	size_t getOffset() {
		return this->offset;
	}

	size_t getLength() {
		return this->length;
	}

};

}

#endif
