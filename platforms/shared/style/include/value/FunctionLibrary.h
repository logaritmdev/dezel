#ifndef __value_FunctionLibrary_h__
#define __value_FunctionLibrary_h__

#include <cstring>
#include <map>
#include <vector>
#include "Value.h"

typedef struct FuncInfo {
	const char *parameterTypes;

	Value *(*func)(const vector<const Value *> &arguments);
} FuncInfo;

class FunctionLibrary {
private:
	std::map<std::string, FuncInfo *> map;

public:
	const FuncInfo *getFunction(const char *functionName) const;
	void push(string name, const char *parameterTypes, Value *(*func)(const vector<const Value *> &arguments));
	bool checkArguments(const FuncInfo *fi, const vector<const Value *> &arguments) const;
	const char *functionDefToString(const char *functionName, const FuncInfo *fi = NULL) const;
};

#endif  // __value_FunctionLibrary_h__
