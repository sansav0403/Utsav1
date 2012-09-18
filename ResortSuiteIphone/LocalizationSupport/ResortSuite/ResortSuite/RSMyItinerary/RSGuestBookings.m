//
//  GuestBookings.m
//  ResortSuite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGuestBookings.h"


@implementation RSGuestBookings

@synthesize folios;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code
		folios = [[NSMutableArray alloc] init];
    }
	
    return self;
}


-(void) dealloc
{	
	[folios removeAllObjects];
	[folios release];
	
	[super dealloc];
}


@end
