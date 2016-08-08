#import <objc/runtime.h>

@interface WCPreferencesManager : NSObject

@property (nonatomic, assign, readonly) NSDate *startDate;
@property (nonatomic, assign, readonly) NSString *startDateStr;
@property (nonatomic, assign, readonly) NSInteger duration;
@property (nonatomic, assign, readonly) NSString *weekStartDay;
@property (nonatomic, assign, readonly) BOOL lockScreenEnabled;
@property (nonatomic, assign, readonly) BOOL nCEnabled;
+ (instancetype)sharedManager;

@end