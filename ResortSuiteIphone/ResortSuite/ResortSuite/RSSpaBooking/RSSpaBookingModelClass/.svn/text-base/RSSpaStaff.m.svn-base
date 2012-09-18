//
//  RSSpaStaff.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaStaff.h"

@implementation RSSpaStaffs

@synthesize spaStaffs;
@synthesize spaStaffResult;

-(id)init
{
    self = [super init];
    if (self)
    {
        spaStaffs = [[NSMutableArray alloc]init];
        spaStaffResult = [[Result alloc]init];
    }
    return self;
}
-(void)dealloc
{
    [spaStaffs removeAllObjects];
    [spaStaffs release];
    [spaStaffResult release];
     [super dealloc];
}

@end

@implementation RSSpaStaff

@synthesize spaStaffID;
@synthesize spaStaffName;
@synthesize gender;

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
    [spaStaffName release];
    [gender release];
    [super dealloc];
}
@end
