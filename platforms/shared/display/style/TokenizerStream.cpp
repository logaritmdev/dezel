#include "TokenizerStream.h"

namespace Dezel {
namespace Style {

using std::string;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

TokenizerStream::TokenizerStream(const string &input) : input(input) {
	this->length = static_cast<size_t>(input.size());
	this->lower = this->getLowerBound(input);
	this->upper = this->getUpperBound(input);
}

size_t
TokenizerStream::getLowerBound(const string &input)
{
	return static_cast<size_t>(0);
}

size_t
TokenizerStream::getUpperBound(const string &input)
{
	return static_cast<size_t>(input.size());
}

void
TokenizerStream::transform(size_t offset, size_t& col, size_t& row)
{
	size_t c = 0;
	size_t r = 0;

	for (size_t i = this->lower; i <= offset; i++) {

		const char character = this->input[i];

		if (character == '\r' ||
			character == '\n' ||
			character == '\f') {
			r = r + 1;
			c = 0;
			continue;
		}

		c++;
	}

	col = c;
	row = r;
}

}
}
