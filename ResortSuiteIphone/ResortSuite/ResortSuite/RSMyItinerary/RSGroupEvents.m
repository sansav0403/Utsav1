//
//  GroupEvents.m
//  ResortSuite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGroupEvents.h"

@implementation GroupEvent

@synthesize PMSFolioGroupEventId;
@synthesize location;
@synthesize startTime;
@synthesize endTime;
@synthesize eventCategory;
@synthesize eventName;
@synthesize eventDesc;	

@synthesize formatedEndTime;
@synthesize formatedStartTime;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
    }
	
    return self;
}


-(void) dealloc
{	
	[location release];
	[startTime release];
	[endTime release];
	[eventCategory release];
	[eventName release];
	[eventDesc release]; 	
	
	[formatedEndTime release];
	[formatedStartTime release];
	
	[super dealloc];
}


@end


@implementation RSGroupEvents

@synthesize groupEventsArr;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
		groupEventsArr = [[NSMutableArray alloc] init];
    }
	
    return self;
}


-(void) dealloc
{	
	[groupEventsArr removeAllObjects];
	[groupEventsArr release];
	
	[super dealloc];
}


@end
