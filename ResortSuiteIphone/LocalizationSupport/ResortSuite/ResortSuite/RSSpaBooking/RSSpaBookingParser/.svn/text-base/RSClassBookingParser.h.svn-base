//
//  RSClassBookingParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RSClassBooking.h"
#import "RSFolio.h"


@interface RSClassBookingParser : RSParseBase <NSXMLParserDelegate>
{
    
    NSMutableString *value;
    
    RSClassBooking *classBooking;       
    
    RSSpaFolioItem *spaFolioItemTemp;
    
    Result *result;
}

@property(nonatomic, retain) RSClassBooking *classBooking;

/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;
@end
