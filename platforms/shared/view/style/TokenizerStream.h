#ifndef TokenizerStream_h
#define TokenizerStream_h

#include <string>
#include <iostream>

namespace View::Style {

#define PREDICATE template<bool predicate(char)>

using std::string;
using std::min;

class TokenizerStream {

private:

	string input;
	size_t length = 0;
	size_t offset = 0;
	size_t lower = 0;
	size_t upper = 0;

	char at(size_t offset) {
		return offset >= this->lower && offset <= this->upper ? this->input[offset] : '\0';
	}

protected:
	size_t getLowerBound(const string &input);
	size_t getUpperBound(const string &input);

public:

	TokenizerStream(const string &input);

	size_t getOffset() {
		return this->offset;
	}

	size_t getLength() {
		return this->length;
	}

	char read() {
		return this->at(this->offset++);
	}

	void read(string &into) {
		into.append(1, this->read());
	}

	char peek(size_t offset = 0) {
		return this->at(this->offset + offset);
	}

	void next(size_t offset = 1) {
		this->offset += offset;
	}

	void back(size_t offset = 1) {
		this->offset -= offset;
	}

	string substring(size_t lower, size_t upper) {
		return this->input.substr(lower, upper - lower);
	}

	string substring(size_t length) {
		return this->input.substr(this->offset, length);
	}

	void substring(size_t lower, size_t upper, string &into) {
		into.append(this->substring(lower, upper));
	}

	void substring(size_t length, string &into) {
		into.append(this->substring(length));
	}

	bool next(char c) {

		size_t offset = this->offset;

		for (;
			offset <= this->upper && this->at(offset) != c;
			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	bool prev(char c) {

		size_t offset = this->offset;

		for (;
			offset > this->lower && this->at(offset) != c;
			offset--
		);

		if (offset < this->lower) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	bool find(char c, size_t &index) {

		size_t offset = this->offset;

		for (;
			offset <= this->upper && this->at(offset) != c;
			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		index = offset - this->offset;

		return true;
	}

	PREDICATE string read() {

		size_t lower = this->offset;
		size_t upper = this->offset;

		for (;

			upper <= this->upper && predicate(
				this->at(upper)
			);

			upper++
		);

		this->offset = upper;

		return this->substring(lower, upper);
	}

	PREDICATE void read(string &into) {
		into.append(this->read<predicate>());
	}

	PREDICATE bool peek(size_t offset = 0) {
		return predicate(
			this->peek(offset)
		);
	}

	PREDICATE bool next() {

		size_t offset = this->offset;

		for (;

			offset <= this->upper && predicate(
				this->at(offset)
			) == false;

			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	PREDICATE bool prev() {

		size_t offset = this->offset;

		for (;

			offset > this->lower && predicate(
				this->at(offset)
			) == false;

			offset--
		);

		if (offset < this->lower) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	PREDICATE bool skip() {

		size_t offset = this->offset;

		for (;

			offset <= this->upper && predicate(
				this->at(offset)
			);

			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		this->offset = offset;

		return true;
	}
};

}

#endif
