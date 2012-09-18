//
//  RSSpaBookingParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSSpaAvailibility.h"
#import "RSSpaLocation.h"
#import "RSSpaService.h"

//#import "RSFolio.h"


@interface RSSpaLocationParser : RSParseBase <NSXMLParserDelegate>
{
    NSMutableString *value;
    
    RSSpaLocation *spaLocation;
    
    Result *result;
    
    RSSpaLocations *rsSpaLocations;
}

@property(nonatomic, retain) RSSpaLocations *rsSpaLocations; 
/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;

@end
