#ifndef TokenizerStream_h
#define TokenizerStream_h

#include <string>
#include <iostream>

namespace Dezel {
namespace Style {

using std::string;

class TokenizerStream {

private:

	string input;
	
	size_t length = 0;
	size_t offset = 0;
	size_t lower = 0;
	size_t upper = 0;

	char get(size_t offset) {
		return offset >= this->lower && offset <= this->upper ? this->input[offset] : '\0';
	}

protected:

	size_t getLowerBound(const string &input);
	size_t getUpperBound(const string &input);

public:

	TokenizerStream(const string &input);

	size_t getOffset() const {
		return this->offset;
	}

	size_t getLength() const {
		return this->length;
	}

	char read() {
		return this->get(this->offset++);
	}

	void read(string &into) {
		into.append(1, this->read());
	}

	char peek(size_t offset = 0) {
		return this->get(this->offset + offset);
	}

	void next(size_t offset = 1) {
		this->offset += offset;
	}

	void back(size_t offset = 1) {
		this->offset -= offset;
	}

	string substring(size_t lower, size_t upper) const {
		return this->input.substr(lower, upper - lower);
	}

	string substring(size_t length) const {
		return this->input.substr(this->offset, length);
	}

	void substring(size_t lower, size_t upper, string &into) const {
		into.append(this->substring(lower, upper));
	}

	void substring(size_t length, string &into) const {
		into.append(this->substring(length));
	}

	bool next(char c) {

		size_t offset = this->offset;

		for (;
			offset <= this->upper && this->get(offset) != c;
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
			offset > this->lower && this->get(offset) != c;
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
			offset <= this->upper && this->get(offset) != c;
			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		index = offset - this->offset;

		return true;
	}

	template<bool predicate(char)> string read() {

		size_t lower = this->offset;
		size_t upper = this->offset;

		for (;

			upper <= this->upper && predicate(
				this->get(upper)
			);

			upper++
		);

		this->offset = upper;

		return this->substring(lower, upper);
	}

	template<bool predicate(char)> void read(string &into) {
		into.append(this->read<predicate>());
	}

	template<bool predicate(char)> bool peek(size_t offset = 0) {
		return predicate(
			this->peek(offset)
		);
	}

	template<bool predicate(char)> bool next() {

		size_t offset = this->offset;

		for (;

			offset <= this->upper && predicate(
				this->get(offset)
			) == false;

			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	template<bool predicate(char)> bool prev() {

		size_t offset = this->offset;

		for (;

			offset > this->lower && predicate(
				this->get(offset)
			) == false;

			offset--
		);

		if (offset < this->lower) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	template<bool predicate(char)> bool skip() {

		size_t offset = this->offset;

		for (;

			offset <= this->upper && predicate(
				this->get(offset)
			);

			offset++
		);

		if (offset > this->upper) {
			return false;
		}

		this->offset = offset;

		return true;
	}

	void transform(size_t offset, size_t& col, size_t& row);
};

}
}

#endif
