#import <UIKit/UIKit.h>
#import "headers/WCSemester.h"
#import "headers/SBFLockScreenDateView.h"
#import "headers/WCPreferencesManager.h"

NSString *getWeekStr(int weekInt) {
	NSDate *startDate = [WCPreferencesManager sharedManager].startDate;
	NSInteger dur = [WCPreferencesManager sharedManager].duration;
	NSInteger startDay = [[WCPreferencesManager sharedManager].weekStartDay isEqualToString:@"Monday"] ? 1 : 0;
	WCSemester *sem = [[WCSemester alloc] initWithStartDate:startDate duration:dur weekStartAt:startDay];
	NSInteger week = [sem weekNo:[NSDate date]];
	if (week == -1) { return @""; }
	else {
		NSString *display = [WCPreferencesManager sharedManager].displayFormat;
		display = [display stringByReplacingOccurrencesOfString:@"\%W" withString:[NSString stringWithFormat:@"%ld", (long)week + weekInt]];
		return [display stringByAppendingString:@" "];
	}
}

%group LockScreen
	%hook SBFLockScreenDateView

	- (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {
		NSString *ori = [self _dateText];
		NSString *weekStr = getWeekStr(0);
		NSString *lastWeekStr = getWeekStr(-1);
		ori = [ori stringByReplacingOccurrencesOfString:weekStr withString:@""];
		ori = [ori stringByReplacingOccurrencesOfString:lastWeekStr withString:@""];
		NSString *totalStr = [weekStr stringByAppendingString:ori];
		%orig(totalStr, arg2);
	}

	%end
%end

%group NotificationCenter
	%hook SBTodayTableHeaderView

	- (_Bool)showsLunarDate {
		return true;
	}

	- (id)lunarDateHeaderString {
		NSString *ori = %orig;
		NSString *weekStr = getWeekStr(0);
		return [weekStr stringByAppendingString:ori];
	}

	%end
%end

%ctor {
	if ([WCPreferencesManager sharedManager].lockScreenEnabled) {
		%init(LockScreen);
	}
	if ([WCPreferencesManager sharedManager].nCEnabled) {
		%init(NotificationCenter);
	}
}
