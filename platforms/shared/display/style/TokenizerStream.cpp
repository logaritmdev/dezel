#include "TokenizerStream.h"

namespace Dezel {
namespace Style {

using std::string;

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

}
}
