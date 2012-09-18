//
//  RSGolfTeeTime.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfTeeTimes.h"


@implementation RSGolfTeeTime

@synthesize dateTime;
@synthesize slotsAvailable;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
	}
	
    return self;
}


-(void) dealloc
{	
	[super dealloc];
}

@end



@implementation RSGolfTeeTimes

@synthesize golfTeeTimeResult;
@synthesize golfTeeTimes;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code			
		golfTeeTimes = [[NSMutableArray alloc] init];
	}
	
    return self;
}


-(void) dealloc
{	
	[golfTeeTimeResult release];
	
	[golfTeeTimes removeAllObjects];
	[golfTeeTimes release];
	
	[super dealloc];
}

@end