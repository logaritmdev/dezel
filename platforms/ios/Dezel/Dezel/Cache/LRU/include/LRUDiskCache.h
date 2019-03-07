#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUDiskCache : NSObject
- (instancetype)initWithName:(NSString *)name;
- (nullable NSData *)dataForKey:(NSString *)key;
- (void)setData:(NSData *)data forKey:(NSString *)key;
- (void)removeDataForKey:(NSString *)key;
- (void)removeAllData;
- (BOOL)containsDataForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
