//
//  JTCalendarDataCache.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@class JTCalendar;

@interface JTCalendarDataCache : NSObject

@property (weak, nonatomic) JTCalendar *calendarManager;

- (void)reloadData;
- (BOOL)haveEvent:(NSDate *)date;
- (UIColor *)circleIndicatorColor:(NSDate *)date;
- (UIColor *)dotColor:(NSDate *)date;

@end
