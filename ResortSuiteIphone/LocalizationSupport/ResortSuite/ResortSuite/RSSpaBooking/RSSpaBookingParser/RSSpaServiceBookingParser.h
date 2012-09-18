//
//  RSSpaServiceBookingParser.h
//  ResortSuite
//
//  Created by Cybage on 17/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSpaServiceBooking.h"
#import "RSFolio.h"

@interface RSSpaServiceBookingParser :RSParseBase <NSXMLParserDelegate>
{
	NSMutableString *value;
    
    RSSpaServiceBooking *serviceBooking;       
    Result *result;
}

@property(nonatomic, retain)  RSSpaServiceBooking *serviceBooking;

@end
