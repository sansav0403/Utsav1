//
//  RSMyItineraryModel.m
//  ResortSuite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMyItineraryModel.h"

@implementation RSMyItineraryModel

@synthesize PMSFolioId;
@synthesize result;
@synthesize guestBookings;
@synthesize groupEvents;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
	}
	
    return self;
}


-(void) dealloc
{	
	[result release];
	[guestBookings release];
	[groupEvents release];
	
	[super dealloc];
}


@end
