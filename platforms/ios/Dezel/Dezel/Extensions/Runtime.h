#import <objc/runtime.h>
#import <Foundation/Foundation.h>

/**
 * @function objc_callMethod
 * @since 0.1.0
 * @hidden
 */
void objc_callMethod(SEL sel, IMP imp, id object, id arg);

/**
 * @function objc_getMethods
 * @since 0.1.0
 * @hidden
 */
Method* objc_getMethods(Class cls, unsigned int* length);
