//
//  RSSpaBooking.m
//  ResortSuite
//
//  Created by Cybage on 12/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaCustomerConflictingBookings.h"

@implementation RSSpaBooking

@synthesize itemName;
@synthesize startTime;
@synthesize endTime;
@synthesize location;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
	}
	
    return self;
}


-(void) dealloc
{	
	[itemName release];
	[startTime release];
	[endTime release];
	[location release];
	
	[super dealloc];
}


@end


@implementation RSSpaCustomerConflictingBookings

@synthesize spaBookingResult;
@synthesize spaBookings;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
		spaBookings = [[NSMutableArray alloc] init];
	}
	
    return self;
}


-(void) dealloc
{	
	[spaBookingResult release];
	
	[spaBookings removeAllObjects];
	[spaBookings release];
	
	[super dealloc];
}

@end
