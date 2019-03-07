#ifndef __VariableMap_h__
#define __VariableMap_h__

#include <map>
#include "TokenList.h"

using std::map;
using std::string;

/**
 * @class VariableMap
 * @since 0.3.0
 */
class VariableMap : public map<string, TokenList> {
public:

	/**
	 * @since 0.3.0
	 */
	const TokenList* getVariable(const string &key) const;

	/**
	 * @since 0.3.0
	 */
	void merge(const VariableMap &map);

	/**
	 * @since 0.3.0
	 */
	void overwrite(const VariableMap &map);

	/**
	 * @since 0.3.0
	 */
	string toString() const;
};

#endif  // __VariableMap_h__
