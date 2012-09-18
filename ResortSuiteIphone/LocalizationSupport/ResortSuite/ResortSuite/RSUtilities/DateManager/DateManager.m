//
//  DateManager.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/22/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "DateManager.h"
//#import "RSConstant.h"

@implementation DateManager

#pragma mark Date formatting functions
+(NSString *)stringFromDate:(NSDate *)date
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:yyyy_MM_ddFormat];
	DLog(@"[dateFormatter stringFromDate:date]: %@",[dateFormatter stringFromDate:date]);
	return [dateFormatter stringFromDate:date];
}

+(NSString *) addDaysToCurrentDate:(int) days
{	
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:yyyy_MM_ddFormat];
    
	NSDate *startDate = [currentDate dateByAddingTimeInterval:60*60*24*days];
	return [dateFormatter stringFromDate:startDate];
}

+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)DateFormat
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    //to avoid 12 or 24 hr format issue
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
	[dateFormatter setDateFormat:DateFormat];
    //return null when device is set in 24 hr format
	DLog(@"[dateFormatter stringFromDate:date]: %@",[dateFormatter stringFromDate:date]);
	return [dateFormatter stringFromDate:date]; //auto released object
}

+ (NSDate *)dateFromString:(NSString *)stringDate withDateFormat:(NSString *)DateFormat
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
	[dateFormatter setDateFormat:DateFormat];		
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;        //auto released object
}

+ (NSString *)convertStandardDateFormateStringFromServerResponseString:(NSString *)responsedString withTime:(BOOL)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
    [dateFormatter setDateFormat:kServerRespondedDateTimeFormat];		
	NSDate *ConvertedDate = [dateFormatter dateFromString:responsedString];
    
    if(time)
	{
		[dateFormatter setDateFormat:EEEE_MMMM_d_yyyy_hh_mm_aFormat];  
	}
	else
	{
		[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];  
	}
    
	NSString *convertedString = [dateFormatter stringFromDate:ConvertedDate]; 
    
    return convertedString;
}

+ (NSString *)convertResponseStringFromStandardDateFormateString:(NSString *)standardString withTime:(BOOL)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
    // get date object with current date format
    NSString *currentdateFormat = (time)?EEEE_MMMM_d_yyyy_hh_mm_aFormat:EEEE_MMMM_d_yyyyFormat;
    [dateFormatter setDateFormat:currentdateFormat];
    NSDate *convertedDate = [dateFormatter dateFromString:standardString];
    
    //convert into server responded date format
    NSString *serverRespondesdateformat = (time)?kServerRespondedDateTimeFormat: kServerRespondedDateFormat;
    [dateFormatter setDateFormat:serverRespondesdateformat];
	NSString *convertedString = [dateFormatter stringFromDate:convertedDate]; 
    
    return convertedString;
}

+ (NSString *)convertIntoResponseStringFromSpecificFormatString:(NSString *)standardString dateFormatStyle:(NSString*)dateFormatStyle withTime:(BOOL)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
  	[dateFormatter setDateFormat:dateFormatStyle];  
    
    NSDate *ConvertedDate = [dateFormatter dateFromString:standardString];
    //convert into server responded date format
    NSString *serverRespondesdateformat = (time)?kServerRespondedDateTimeFormat: kServerRespondedDateFormat;
    [dateFormatter setDateFormat:serverRespondesdateformat];
    
	NSString *convertedString = [dateFormatter stringFromDate:ConvertedDate]; 
    
    return convertedString;
}

+ (NSString *)stringFromServerResponseString:(NSString *)responsedString requiredFormat:(NSString *)requiredFormat withTime:(BOOL)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
    NSString *serverRespondesdateformat = (time)?kServerRespondedDateTimeFormat: kServerRespondedDateFormat;
    
    [dateFormatter setDateFormat:serverRespondesdateformat];		
	NSDate *ConvertedDate = [dateFormatter dateFromString:responsedString];
    
    [dateFormatter setDateFormat:requiredFormat];  
    
	NSString *convertedString = [dateFormatter stringFromDate:ConvertedDate]; 
    
    return convertedString;
}

+ (NSString *)convertTimeIntoStandardFormat:(NSString *)timeString currentTimeFormat:(NSString*)currentTimeFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
  	[dateFormatter setDateFormat:currentTimeFormat];  
    
    NSDate *ConvertedTime = [dateFormatter dateFromString:timeString];
    
    [dateFormatter setDateFormat:kServerRespondedTimeFormat];
    
	NSString *convertedTimeString = [dateFormatter stringFromDate:ConvertedTime]; 
    
    return convertedTimeString;
}

@end
