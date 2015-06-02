//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date;
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date;

@optional

- (BOOL)calendar:(JTCalendar *)calendar canSelectDate:(NSDate *)date;
- (UIColor *)calendarDayCircleIndicatorColor:(JTCalendar *)calendar date:(NSDate *)date;
- (UIColor *)calendarDotColor:(JTCalendar *)calendar date:(NSDate *)date;

- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end
