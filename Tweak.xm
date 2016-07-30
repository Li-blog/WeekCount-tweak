#import <UIKit/UIKit.h>
#import "headers/NCDefaultDateLabel.h"

%hook SBFLockScreenDateView


- (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {
	%orig(@"WeekCount", arg2);
}

%end

%hook NCDefaultDateLabel

- (void)update {
	%orig;
	self.text = @"WeekCount";
}

%end