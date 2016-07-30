#import <UIKit/UIKit.h>

%hook SpringBoard

- (void)applicationDidFinishLaunching: (id)application {
	%orig;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"TEST" message: nil delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
	NSLog(@"WC:TEST");
}

%end