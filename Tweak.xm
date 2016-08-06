#import <UIKit/UIKit.h>

// %hook SBFLockScreenDateView


// - (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {
// 	%orig(@"WeekCount", arg2);
// }

// %end

%hook SBTodayTableHeaderView

- (_Bool)showsLunarDate {
	return true;
}

- (id)lunarDateHeaderString {
	return @"中文测试";
}

%end