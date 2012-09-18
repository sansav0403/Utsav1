//
//  RSSpaAvailibility.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaAvailibility.h"
@implementation RSSpaAvailibilties

@synthesize spaAvailibilities;
@synthesize spaAvailibilityResult;


-(id)init
{
    self = [super init];
    if (self)
    {
        spaAvailibilities = [[NSMutableArray alloc]init];
        spaAvailibilityResult = [[Result alloc]init];
    }
    return self;
}
-(void)dealloc
{
    [spaAvailibilities removeAllObjects];
    [spaAvailibilities release];
    [spaAvailibilityResult release];
    [super dealloc];
}
@end

@implementation RSSpaAvailibility

@synthesize startTime;
@synthesize availibilityID;
@synthesize spaStaffID; 


-(id)init
{
    self = [super init];
    if (self)
    {
        startTime = nil;
    }
    return self;
}

-(void)dealloc
{
    [startTime release];
    [super dealloc];
}
@end
