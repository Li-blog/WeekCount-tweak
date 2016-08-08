#import <Preferences/Preferences.h>
#import "NSConcreteNotification.h"

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
- (void)_returnKeyPressed:(NSConcreteNotification *)notification {
	[self.view endEditing:YES];
	//[super _returnKeyPressed:notification];
}
@end

// vim:ft=objc
