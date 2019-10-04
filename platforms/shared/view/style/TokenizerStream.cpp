#include "TokenizerStream.h"

namespace Dezel {
namespace Style {

using std::string;

TokenizerStream::TokenizerStream(const string &input) : input(input) {
	this->length = static_cast<unsigned>(input.size());
	this->lower = this->getLowerBound(input);
	this->upper = this->getUpperBound(input);
}

unsigned
TokenizerStream::getLowerBound(const string &input)
{
	return static_cast<unsigned>(0);
}

unsigned
TokenizerStream::getUpperBound(const string &input)
{
	return static_cast<unsigned>(input.size());
}

}
}
