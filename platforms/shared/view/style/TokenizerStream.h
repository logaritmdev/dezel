#ifndef TokenizerStream_h
#define TokenizerStream_h

#include <string>
#include <iostream>

namespace Dezel {
namespace Style {

using std::string;
using std::min;

class TokenizerStream {

private:

	string input;
	
	unsigned length = 0;
	unsigned offset = 0;
	unsigned lower = 0;
	unsigned upper = 0;

	char get(unsigned offset) {
		return offset >= this->lower && offset <= this->upper ? this->input[offset] : '\0';
	}

protected:

	unsigned getLowerBound(const string &input);
	unsigned getUpperBound(const string &input);

public:

	TokenizerStream(const string &input);

	unsigned getOffset() const {
		return this->offset;
	}

	unsigned getLength() const {
		return this->length;
	}

	char read() {
		return this->get(this->offset++);
	}

	void read(string &into) {
		into.append(1, this->read());
	}

	char peek(unsigned offset = 0) {
		return this->get(this->offset + offset);
	}

	void next(unsigned offset = 1) {
		this->offset += offset;
	}

	void back(unsigned offset = 1) {
		this->offset -= offset;
	}

	string substring(unsigned lower, unsigned upper) const {
		return this->input.substr(lower, upper - lower);
	}

	string substring(unsigned length) const {
		return this->input.substr(this->offset, length);
	}

	void substring(unsigned lower, unsigned upper, string &into) const {
		into.append(this->substring(lower, upper));
	}

	void substring(unsigned length, string &into) const {
		into.append(this->substring(length));
	}

	bool next(char c) {

		unsigned offset = this->offset;

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

		unsigned offset = this->offset;

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

	bool find(char c, unsigned &index) {

		unsigned offset = this->offset;

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

		unsigned lower = this->offset;
		unsigned upper = this->offset;

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

	template<bool predicate(char)> bool peek(unsigned offset = 0) {
		return predicate(
			this->peek(offset)
		);
	}

	template<bool predicate(char)> bool next() {

		unsigned offset = this->offset;

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

		unsigned offset = this->offset;

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

		unsigned offset = this->offset;

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
};

}
}

#endif
