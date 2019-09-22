#include "TokenizerStream.h"

namespace View::Style {

using std::string;

TokenizerStream::TokenizerStream(const string &input) : input(input) {
	this->length = input.size();
	this->offset = 0;
}

char
TokenizerStream::at(size_t offset)
{
	return offset < this->length ? this->input[offset] : '\0';
}

char
TokenizerStream::read()
{
	return this->at(this->offset++);
}

char
TokenizerStream::peek(size_t offset)
{
	return this->at(this->offset + offset);
}

void
TokenizerStream::next(size_t offset)
{
	this->offset += offset;
}

void
TokenizerStream::back(size_t offset)
{
	this->offset -= offset;
}

string
TokenizerStream::substring(size_t length)
{
	return this->input.substr(this->offset, length);
}

string
TokenizerStream::substring(size_t offset, size_t length)
{
	return this->input.substr(offset, length);
}

}
