//
//  DateFormatting.m
//  ResortSuite
//
//  Created by Cybage on 10/08/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "DateFormatting.h"


@implementation DateFormatting


#pragma mark Date formatting functions
+(NSString *)stringFromDate:(NSDate *)date
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSLog(@"[dateFormatter stringFromDate:date]: %@",[dateFormatter stringFromDate:date]);
	return [dateFormatter stringFromDate:date];
}

+(NSString *) addDaysToCurrentDate:(int) days
{	
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];

	NSDate *startDate = [currentDate addTimeInterval:60*60*24*days];
	return [dateFormatter stringFromDate:startDate];
}

@end
