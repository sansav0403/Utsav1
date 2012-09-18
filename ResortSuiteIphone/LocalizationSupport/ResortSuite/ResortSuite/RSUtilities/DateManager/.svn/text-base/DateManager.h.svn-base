//
//  DateManager.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/22/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject
{
    
}

/*!
 @method		stringFromDate
 @brief			Converts the date to NSString with format "yyyy-MM-dd"
 @details		....
 @param			NSDate date
 @return		NSString
 */
+(NSString *) stringFromDate:(NSDate *) date;

/*!
 @method		addDaysToCurrentDate
 @brief			Adds specified days to Current Date and converts it to NSString with format "yyyy-MM-dd"
 @details		....
 @param			int days
 @return		NSString
 */
+(NSString *) addDaysToCurrentDate:(int) days;

/*!
 @method		stringFromDate:withDateFormat
 @brief			Converts the date to NSString with given date format 
 @details		....
 @param			(NSDate *)date, (NSString *)DateFormat
 @return		NSString
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)DateFormat;

/*!
 @method		dateFromString:withDateFormat
 @brief			Converts the String to NSDate with given date format 
 @details		....
 @param			(NSString *)stringDate, (NSString *)DateFormat
 @return		NSDate
 */
+ (NSDate *)dateFromString:(NSString *)stringDate withDateFormat:(NSString *)DateFormat;

/*!
 @method		convertStandardDateFormateStringFromServerResponseString
 @brief			Converts the server responded string into standard(earlier implemented) string date format 
 @details		it hepls to handle date format changes, if formate changes in future also, it will work by just replacing(kServerRespondedDateFormat). 
 @param			(NSString *)responsedString, (BOOL)time
 @return		NSString - converted string as required to do not hamper implementation
 */
+ (NSString *)convertStandardDateFormateStringFromServerResponseString:(NSString *)responsedString withTime:(BOOL)time;

/*!
 @method		convertResponseStringFromStandardDateFormateString
 @brief			Converts the standard(earlier implemented) string into server responded stringdate format 
 @details		it hepls to handle date format changes, if formate changes in future also, it will work by just replacing(kServerRespondedDateFormat). 
 @param			(NSString *)standardString,(BOOL)time
 @return		NSString - converted string as required to do not hamper implementation
 */
+ (NSString *)convertResponseStringFromStandardDateFormateString:(NSString *)standardString withTime:(BOOL)time;

+ (NSString *)convertIntoResponseStringFromSpecificFormatString:(NSString *)standardString dateFormatStyle:(NSString*)dateFormatStyle withTime:(BOOL)time;

+ (NSString *)convertTimeIntoStandardFormat:(NSString *)timeString currentTimeFormat:(NSString*)currentTimeFormat;

/*!
 @method		stringFromServerResponseString
 @brief			Converts server responded string into required string format
 @details		it hepls to handle date format changes, if formate changes in future also, it will work by just replacing(kServerRespondedDateFormat). 
 @param			(NSString *)responsedString,(NSSting*)requiredFormat
 @return		NSString - converted string as required for implementation done
 */
+ (NSString *)stringFromServerResponseString:(NSString *)responsedString requiredFormat:(NSString*)requiredFormat withTime:(BOOL)time; 

@end
