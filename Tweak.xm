#import <UIKit/UIKit.h>

%hook SBFLockScreenDateView


- (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {
	%orig(@"WeekCount", arg2);
}

%end
