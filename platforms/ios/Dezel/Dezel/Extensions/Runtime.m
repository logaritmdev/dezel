#import "Runtime.h"

void
objc_callMethod(SEL sel, IMP imp, id object, id arg)
{
	void (*fn)(id, SEL, id) = (void(*)(id, SEL, id))imp;
	fn(object, sel, arg);
}

BOOL
setPropertyForKey(NSObject *object, NSString *key, id value)
{
	@try {
		[object setValue:value forKey:key];
	} @catch (NSException *exception) {
		return NO;
	}

	return YES;
}

id
getPropertyForKey(NSObject *object, NSString *key)
{
	@try {
		return [object valueForKey:key];
	} @catch (NSException *exception) {
	}

	return nil;
}
