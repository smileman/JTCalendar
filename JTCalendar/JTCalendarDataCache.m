//
//  JTCalendarDataCache.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarDataCache.h"

#import "JTCalendar.h"

@interface JTCalendarDataCache(){
    NSMutableDictionary *events;
	NSMutableDictionary *borderColors;
    NSDateFormatter *dateFormatter;
};

@end

@implementation JTCalendarDataCache

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    events = [NSMutableDictionary new];
	borderColors = [NSMutableDictionary new];
    return self;
}

- (void)reloadData
{
    [events removeAllObjects];
	[borderColors removeAllObjects];
}

- (BOOL)haveEvent:(NSDate *)date
{
    if(!self.calendarManager.dataSource){
        return NO;
    }
    
    if(!self.calendarManager.calendarAppearance.useCacheSystem){
        return [self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:date];
    }
    
    BOOL haveEvent;
    NSString *key = [dateFormatter stringFromDate:date];
    
    if(events[key] != nil){
        haveEvent = [events[key] boolValue];
    }
    else{
        haveEvent = [self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:date];
        events[key] = [NSNumber numberWithBool:haveEvent];
    }
    
    return haveEvent;
}

- (UIColor *)circleIndicatorColor:(NSDate *)date {
	if(!self.calendarManager.dataSource || ![self.calendarManager.dataSource respondsToSelector:@selector(calendarDayCircleIndicatorColor:date:)]){
		return self.calendarManager.calendarAppearance.dayCircleIndicatorBorderColor;
	}
	
	if(!self.calendarManager.calendarAppearance.useCacheSystem){
		UIColor *borderColor = [self.calendarManager.dataSource calendarDayCircleIndicatorColor:self.calendarManager date:date];
		return borderColor != nil ? borderColor : self.calendarManager.calendarAppearance.dayCircleIndicatorBorderColor;
	}
	
	UIColor *borderColor;
	NSString *key = [dateFormatter stringFromDate:date];
	
	if(borderColors[key] != nil){
		borderColor = borderColors[key];
	}
	else{
		borderColor = [self.calendarManager.dataSource calendarDayCircleIndicatorColor:self.calendarManager date:date];
		if (borderColor != nil) {
			borderColors[key] = borderColor;
		}
	}
	
	return borderColor;
}

@end