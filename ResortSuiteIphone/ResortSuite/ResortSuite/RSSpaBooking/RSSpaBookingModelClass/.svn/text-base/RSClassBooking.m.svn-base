//
//  RSClassBooking.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSClassBooking.h"


@implementation RSSpaFolioItem

@synthesize spaFolioItemId;
@synthesize bookStartTime;

-(id)init
{
    self = [super init];
    if (self)
    {
        bookStartTime = nil;
    }
    return self;
}

-(void)dealloc
{
    [bookStartTime release];
    [super dealloc];
}
@end


@implementation RSClassBooking

@synthesize classBookingResult;
@synthesize spaFolioItem;


-(id)init
{
    self = [super init];
    if (self)
    {
        classBookingResult = [[Result alloc]init];
        spaFolioItem = nil;
    }
    return self;
}

-(void)dealloc
{
    [classBookingResult release];
    [spaFolioItem release];
    [super dealloc];
}
@end
