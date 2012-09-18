//
//  RSDailySpaClassesParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSpaClass.h"

@interface RSDailySpaClassesParser : RSParseBase <NSXMLParserDelegate>
{
    NSMutableString *value;
    
    RSSpaClass *spaClass;
    
    Result *result;
    
    RSDailySpaClasses *rsDailySpaClasses;
}

@property(nonatomic, retain)  RSDailySpaClasses *rsDailySpaClasses; 

/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;


@end


