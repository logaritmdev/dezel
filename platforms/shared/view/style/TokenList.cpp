#include "TokenList.h"

namespace Dezel {
namespace Style {

TokenList::TokenList(const Token* head, const Token* tail)
{
	this->head = head;
	this->tail = tail;
	this->curr = head;
}

const Token&
TokenList::peek(unsigned offset, bool spaces) {

	if (spaces || offset == 0) {

		if (this->curr + offset >= this->tail ||
			this->curr + offset <= this->head) {
			return this->getEndToken();
		}

		return *(this->curr + offset);
	}

	unsigned push = 0;

	while (true) {

		if (this->curr + offset + push >= this->tail ||
			this->curr + offset + push <= this->head) {
			return this->getEndToken();
		}

		const auto token = this->curr + offset;

		if (token->getType() == kTokenTypeSpace ||
			token->getType() == kTokenTypeLinebreak) {

			if (offset > 0) {
				push++;
			} else {
				push--;
			}

			continue;
		}

		return *token;
	}

	return this->getEndToken();
}

}
}
