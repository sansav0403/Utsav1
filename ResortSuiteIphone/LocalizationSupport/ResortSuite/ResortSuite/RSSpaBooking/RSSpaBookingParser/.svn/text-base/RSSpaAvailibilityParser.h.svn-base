//
//  RSSpaAvailibilityParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSFolio;
@class RSParseBase;
@class RSSpaAvailibilties;
@class RSSpaAvailibility;

@interface RSSpaAvailibilityParser : RSParseBase <NSXMLParserDelegate>

{
    NSMutableString *value;
    
    RSSpaAvailibility * spaAvailibility;
    
    Result *result;

    
    RSSpaAvailibilties *rsSpaAvailibilties;
}



@property(nonatomic, retain) RSSpaAvailibilties * rsSpaAvailibilties;

/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;

@end
