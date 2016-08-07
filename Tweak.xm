#import <UIKit/UIKit.h>
#import "headers/WCSemester.h"
#import "headers/SBFLockScreenDateView.h"

NSString *getWeekStr(int weekInt) {
	NSDateFormatter *fm = [[NSDateFormatter alloc] init];
	[fm setDateFormat:@"yyyyMMdd"];
	NSDate *date1 = [fm dateFromString:@"20160627"];
	WCSemester *sem = [[WCSemester alloc] initWithStartDate:date1 duration:11 weekStartAt:1];
	NSInteger week = [sem weekNo:[NSDate date]];
	if (week == -1) { return @""; }
	else { return [NSString stringWithFormat:@"第 %ld 周 ", (long)week + weekInt]; }
}


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
