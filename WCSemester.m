#import "headers/WCSemester.h"

@implementation WCSemester

- (id)initWithStartDate: (NSDate *)date duration: (NSInteger)dur weekStartAt: (NSInteger)startDay {
    if (self = [super init]) {
        startDate = date;
        duration = dur;
        weekStartDay = startDay;
        if (weekStartDay == 0) {
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        } else {
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
        }
    }
    return self;
}

- (NSDate *)firstDayOfWeek: (NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    return [calendar dateFromComponents:comp];
}

- (NSInteger)daysIntervalFrom: (NSDate *)date1 to: (NSDate *)date2 {
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay fromDate:date1 toDate:date2 options:0];
    return comp.day;
}

- (NSInteger)weekNo: (NSDate *)date {
    NSDate *firstDayOfStartWeek = [self firstDayOfWeek: startDate];
    NSDate *firstDayOfGivenWeek = [self firstDayOfWeek: date];
    NSInteger days = [self daysIntervalFrom:firstDayOfStartWeek to:firstDayOfGivenWeek];
    NSInteger weeks = days / 7 + 1;
    if (weeks > duration || weeks < 1) { return -1; }
    return weeks;
}


@end
