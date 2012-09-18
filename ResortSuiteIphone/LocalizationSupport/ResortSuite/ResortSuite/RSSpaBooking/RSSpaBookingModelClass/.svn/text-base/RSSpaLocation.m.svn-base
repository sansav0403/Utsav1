//
//  RSSpaLocation.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
#import "RSSpaLocation.h"

@implementation RSSpaLocations

@synthesize spaLocations;
@synthesize spaLocationResult;


-(id)init
{
    self = [super init];
    if (self)
    {
        spaLocations = [[NSMutableArray alloc]init];
        spaLocationResult = [[Result alloc]init];
    }
    return self;
}
-(void)dealloc
{
    [spaLocations removeAllObjects];
    [spaLocations release];
    [spaLocationResult release];
    [super dealloc];
}
@end




@implementation RSSpaLocation

@synthesize locationName;

@synthesize locationID;

@synthesize location;
@synthesize imageUrl;

@synthesize allowGender;
@synthesize allowStaff;
@synthesize allowOverBook;

@synthesize bookingType;

@synthesize mondayStart;
@synthesize mondayEnd;

@synthesize tuesdayStart;
@synthesize tuesdayEnd;

@synthesize wednesdayStart;
@synthesize wednesdayEnd;

@synthesize thrusdayStart;
@synthesize thrusdayEnd;

@synthesize fridayStart;
@synthesize fridayEnd;

@synthesize saturdayStart;
@synthesize saturdayEnd;

@synthesize sundayStart;
@synthesize sundayEnd;

-(id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

-(void)dealloc
{
    [locationName release];
    
    [location release];

    [imageUrl release];
    
    [bookingType release];
    
    [mondayStart release];
    [mondayEnd release];
    
    [tuesdayStart release];
    [tuesdayEnd release];
    
    [wednesdayStart release];
    [wednesdayEnd release];
    
    [thrusdayStart release];
    [thrusdayEnd release];
    
    [fridayStart release];
    [fridayEnd release];
    
    [saturdayStart release];
    [saturdayEnd release];
    
    [sundayStart release];
    [sundayEnd release];

    [super dealloc];
}

@end
