//
//  RSClubBillingHistory.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSClubBillingHistory.h"

@implementation BillingPeriod

@synthesize billDate;
@synthesize	periodStartDate;
@synthesize frequency;
@synthesize paymentLeniency;
@synthesize	balance;
@synthesize folioDue;
@synthesize payment;
@synthesize lateFeeApplied;
@synthesize	lateFee;
@synthesize balanceDue;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
	}
	
    return self;
}


-(void) dealloc
{	
	[billDate release];
	[periodStartDate release];
	[frequency release];
	[paymentLeniency release];
	[balance release];
	[folioDue release];
	[payment release];
	[lateFeeApplied release];
	[lateFee release];
	[balanceDue release];
	
	[super dealloc];
}

@end


@implementation RSClubBillingHistory

@synthesize clubBillingResult;	
@synthesize	accountId;
@synthesize billingPeriods;	


- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
		billingPeriods = [[NSMutableArray alloc] init];
	}
	
    return self;
}

-(void) dealloc
{	
	[clubBillingResult release];	
	[accountId release];
	
	[billingPeriods removeAllObjects];
	[billingPeriods release];
	
	[super dealloc];
}

@end
