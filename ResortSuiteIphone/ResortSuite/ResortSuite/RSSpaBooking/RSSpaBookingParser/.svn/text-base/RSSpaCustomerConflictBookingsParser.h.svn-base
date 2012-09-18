//
//  RSSpaCustomerConflictBookingsParser.h
//  ResortSuite
//
//  Created by Cybage on 12/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RSSpaCustomerConflictingBookings;
@class RSSpaBooking;

@interface RSSpaCustomerConflictBookingsParser : RSParseBase <NSXMLParserDelegate> {
	RSSpaCustomerConflictingBookings *spaCustConflictBookingsModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSSpaBooking *spaBooking;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSSpaCustomerConflictingBookings *spaCustConflictBookingsModel;

@end
