#import "Runtime.h"

void
objc_callMethod(SEL sel, IMP imp, id object, id arg)
{
	void (*fn)(id, SEL, id) = (void(*)(id, SEL, id))imp;
	fn(object, sel, arg);
}

Method*
objc_getMethods(Class cls, unsigned int* length)
{
	unsigned int ccount;
	unsigned int icount;

	Method* cms = class_copyMethodList(cls, &ccount);
	Method* ims = class_copyMethodList(object_getClass(cls), &icount);
	Method* all = malloc(sizeof(Method) * (ccount + icount));

	unsigned int index = 0;

	for (unsigned int i = 0; i < ccount; i++) {
		all[index++] = cms[i];
	}

	for (unsigned int i = 0; i < icount; i++) {
		all[index++] = ims[i];
	}

	(*length) = index;

	return all;
}
