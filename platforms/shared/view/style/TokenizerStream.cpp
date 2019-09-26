#include "TokenizerStream.h"

namespace View::Style {

using std::string;

TokenizerStream::TokenizerStream(const string &input) : input(input) {
	this->length = input.size();
	this->lower = this->getLowerBound(input);
	this->upper = this->getUpperBound(input);
}

size_t
TokenizerStream::getLowerBound(const string &input)
{
	return 0;
}

size_t
TokenizerStream::getUpperBound(const string &input)
{
	return input.size();
}

}
