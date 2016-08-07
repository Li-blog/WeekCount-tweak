#import <UIKit/UIKit.h>

@interface WCSemester : NSObject {
    NSDate *startDate;
    NSCalendar *calendar;
    NSInteger duration;
    NSInteger weekStartDay;
}

- (id)initWithStartDate: (NSDate *)date duration: (NSInteger)dur weekStartAt: (NSInteger)startDay;
- (NSDate *)firstDayOfWeek: (NSDate *)date;
- (NSInteger)daysIntervalFrom: (NSDate *)date1 to: (NSDate *)date2;
- (NSInteger)weekNo: (NSDate *)date;

@end
