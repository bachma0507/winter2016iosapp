#import <Foundation/Foundation.h>

@interface Alerts : NSObject
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSDate *updated;
@end