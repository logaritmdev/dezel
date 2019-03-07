#import <objc/runtime.h>
#import <Foundation/Foundation.h>

/**
 * @function objc_callMethod
 * @since 0.1.0
 * @hidden
 */
void objc_callMethod(SEL sel, IMP imp, id object, id arg);

/**
 * @function setPropertyForKeyByName
 * @since 0.1.0
 * @hidden
 */
BOOL setPropertyForKey(NSObject *object, NSString *key, id value);

/**
 * @function getPropertyForKey
 * @since 0.1.0
 * @hidden
 */
id getPropertyForKey(NSObject *object, NSString *key);
