#ifndef TokenList_h
#define TokenList_h

#include "Token.h"

#include <vector>

namespace Dezel {
namespace Style {

class TokenList {

private:

	const Token* head;
	const Token* tail;
	const Token* curr;

	const Token& getEndToken() const {
		static Token token(kTokenTypeEnd);
		return token;
	}

public:

	TokenList(const Token* head, const Token* tail);

	void prevToken() {
		if (this->curr > this->head) {
			this->curr--;
		}
	}

	void nextToken() {
		if (this->curr < this->tail) {
			this->curr++;
		}
	}

	bool hasPrevToken() const {
		return this->curr > this->head;
	}

	bool hasNextToken() const {
		return this->curr < this->tail;
	}

	const Token& getCurrToken() const {
		return *(this->curr);
	}

	const TokenType getCurrTokenType() const {
		return this->curr->getType();
	}

	const string& getCurrTokenName() const {
		return this->curr->getName();
	}

	const string& getCurrTokenUnit() const {
		return this->curr->getUnit();
	}

	const TokenType getNextTokenType(size_t offset = 1) const  {
		return this->peek(offset).getType();
	}

	const string& getNextTokenName(size_t offset = 1) const  {
		return this->peek(offset).getName();
	}

	const string& getNextTokenUnit(size_t offset = 1) const {
		return this->peek(offset).getUnit();
	}

	const Token& peek(size_t offset = 0, bool spaces = true) const;

	void skipSpace() {
		while (
			this->curr->getType() == kTokenTypeSpace ||
			this->curr->getType() == kTokenTypeLinebreak) {
			this->curr++;
		}
	}
};

}
}

#endif
