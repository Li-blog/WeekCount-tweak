#import "headers/WCPreferencesManager.h"

@interface WCPreferencesManager (Private)

- (void)_preferencesChanged;

@end

static void preferencesChanged() {
    CFPreferencesAppSynchronize(CFSTR("com.wangjinli.weekcountpb"));
    [[WCPreferencesManager sharedManager] _preferencesChanged];
}

@implementation WCPreferencesManager

+ (void)load {
	[self sharedManager];
}

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

-(id)init {
	if ((self = [super init])) {
	    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
		                                NULL,
		                                (CFNotificationCallback)preferencesChanged,
		                                CFSTR("com.wangjinli.weekcountpb/prefsChanged"),
		                                NULL,
		                                CFNotificationSuspensionBehaviorDeliverImmediately);
	    [self _preferencesChanged];
	}
	return self;
}

-(void)_preferencesChanged {
	CFStringRef appID = CFSTR("com.wangjinli.weekcountpb");
	CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (!keyList) {
		[self attemptSettingFallbackPrefs];
		return;
	}
	NSDictionary *preferences = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
	CFRelease(keyList);
	if (!preferences) {
		[self attemptSettingFallbackPrefs];
	}

	_startDateStr = preferences[@"StartDateStr"] ? preferences[@"StartDateStr"] : @"19700101";
	_duration = preferences[@"Duration"] ? [(NSNumber*)preferences[@"Duration"] intValue] : 18;
	_weekStartDay = preferences[@"WeekStartDay"] ? preferences[@"WeekStartDay"] : @"Monday";
	_lockScreenEnabled = preferences[@"LockScreenEnabled"] ? [(NSNumber*)preferences[@"LockScreenEnabled"] boolValue] : YES;
	_nCEnabled = preferences[@"NCEnabled"] ? [(NSNumber*)preferences[@"NCEnabled"] boolValue] : YES;
	_displayFormat = preferences[@"DisplayFormat"] ? preferences[@"DisplayFormat"] : @"Week \%W";

	[self parseDate];
}

-(void)parseDate {
	NSDateFormatter *fm = [[NSDateFormatter alloc] init];
	[fm setDateFormat:@"yyyyMMdd"];
	NSDate *date1 = [fm dateFromString:_startDateStr];
	if (date1 == nil) {
		_startDate = [fm dateFromString:@"19700101"];
	}
	else {
		_startDate = date1;
	}
}

-(void)attemptSettingFallbackPrefs {
	_startDateStr = @"19700101";
	_duration = 18;
	_weekStartDay = @"Monday";
	_lockScreenEnabled = YES;
	_nCEnabled = YES;
	_displayFormat = @"Week \%W";
	[self parseDate];
}

@end