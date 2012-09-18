//
//  RSClubAccounts.m
//  ResortSuite
//
//  Created by Cybage on 06/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSClubAccounts.h"

@implementation Person

@synthesize salutation;
@synthesize	firstName;
@synthesize lastName;	


-(void) dealloc
{	
	[salutation release];
	[firstName release];
	[lastName release];
	
	[super dealloc];
}

@end


@implementation Address

@synthesize addressLine1;
@synthesize	addressLine2;
@synthesize city;
@synthesize province;
@synthesize	country;
@synthesize postalCode;


-(void) dealloc
{	
	[addressLine1 release];
	[addressLine2 release];
	[city release];
	[province release];
	[country release];
	[postalCode release];
	
	[super dealloc];
}

@end

@implementation Billing

@synthesize frequency;
@synthesize	nextBillDate;


-(void) dealloc
{	
	[frequency release];
	[nextBillDate release];
	
	[super dealloc];
}

@end


@implementation Member

@synthesize	VIPLevel;

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) dealloc
{	
	[VIPLevel release];
	
	[super dealloc];
}

@end

@implementation MemberShip

@synthesize name;
@synthesize	status;
@synthesize effectiveDate;
@synthesize expiryDate;	


-(void) dealloc
{	
	[name release];
	[status release];
	[effectiveDate release];
	[expiryDate release];
 	
	[super dealloc];
}

@end

@implementation AccCustomer

@synthesize customerId;
@synthesize	customerGUID;
@synthesize address;
@synthesize emailAddress;
@synthesize	phoneNumber;
@synthesize customerCode;
@synthesize VIPLevel;


-(void) dealloc
{	
	[customerId release];
	[customerGUID release];
	[address release];
	[emailAddress release];
	[phoneNumber release];
	[customerCode release];
	[VIPLevel release];
	
	[super dealloc];
}

@end

@implementation Account

@synthesize accountId;
@synthesize	classType; 
@synthesize statementCustomerName;
@synthesize billing;
@synthesize	members; //Member
@synthesize memberShips;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
		members = [[NSMutableArray alloc] init];
		memberShips = [[NSMutableArray alloc] init];
	}
	
    return self;
}


-(void) dealloc
{	
	[accountId release];
	[classType release]; 
	[statementCustomerName release];
	[billing release];
	
	[members removeAllObjects];
	[members release];
	[memberShips removeAllObjects];
	[memberShips release];
	
	[super dealloc];
}

@end


@implementation RSClubAccounts

@synthesize clubResult;
@synthesize	accCustomer;
@synthesize accounts;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
		accounts = [[NSMutableArray alloc] init];
	}
	
    return self;
}


-(void) dealloc
{	
	[clubResult release];
	[accCustomer release];
	
	[accounts removeAllObjects];
	[accounts release];
	
	[super dealloc];
}

@end

