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

	const Token& getEndToken() {
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

	const Token& getCurrentToken() const {
		return *(this->curr);
	}

	const TokenType getCurrentTokenType() const {
		return this->curr->getType();
	}

	const BlockType getCurrentTokenBlockType() const {
		return this->curr->getBlockType();
	}

	const ClassType getCurrentTokenClassType() const {
		return this->curr->getClassType();
	}

	const string& getCurrentTokenName() const {
		return this->curr->getName();
	}

	const string& getCurrentTokenUnit() const {
		return this->curr->getUnit();
	}

	const Token& peek(size_t offset = 0, bool spaces = true);

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
