#import <Preferences/Preferences.h>

@interface WeekCountPBListController: PSListController {
}
@end

@implementation WeekCountPBListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"WeekCountPB" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
