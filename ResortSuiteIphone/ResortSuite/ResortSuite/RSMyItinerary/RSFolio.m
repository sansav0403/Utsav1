//
//  RSFolio.m
//  ResortSuite
//
//  Created by Cybage on 30/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSFolio.h"



@implementation Result

@synthesize resultValue;
@synthesize resultText;
@synthesize ErrorID;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code
		
    }
	
    return self;
}

-(void) dealloc
{	
	[resultText release];
	
	[super dealloc];
}

@end



@implementation Customer

@synthesize customerId;
@synthesize salutation;
@synthesize firstName;
@synthesize lastName;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
		
    }
	
    return self;
}


-(void) dealloc
{	
	[firstName release];
	[lastName release];
	
	[super dealloc];
}


@end


@implementation RSFolio

@synthesize appType;
@synthesize appFolioId;

@synthesize location;
@synthesize customer;
@synthesize startDate;
@synthesize finishDate;
@synthesize formatedStartDate;
@synthesize formatedFinishDate;


@synthesize details;
@synthesize netAmount;
@synthesize grossAmount;




- (id) init
{
    if ((self = [super init])) {
        // instantiation code
    }
	
    return self;
}

-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"formatedStartDate = %@",self.formatedStartDate];
    return desc;
}
-(void) dealloc
{
	[location release];
	[customer release];
	[startDate release];
	[finishDate release];
	[details release];
	[netAmount release];
	[grossAmount release];
	[formatedStartDate release];
	[formatedFinishDate release];
	[super dealloc];
}

@end


@implementation HotelFolio

@synthesize groupFolioId;
@synthesize numAdults;
@synthesize numYouth;
@synthesize numChildren;
@synthesize totalGuests;

@synthesize roomNumber;
@synthesize roomType;
@synthesize rateType;
@synthesize rateDescription;
@synthesize deposit;
@synthesize balanceDue;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
    }
	
    return self;
}
-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"roomNumber = %@, room type = %@ formatedStartDate = %@",self.roomNumber,self.roomType,self.formatedStartDate];
    return desc;
}
-(void) dealloc
{	
	[roomNumber release];
	[roomType release];
	[rateType release];
	[rateDescription release];
	[deposit release];
	[balanceDue release];
	
	[super dealloc];
}


@end


@implementation SpaFolio

@synthesize room;
@synthesize staff;
@synthesize spaDescription;
@synthesize clientInstruction;
- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
    }
	
    return self;
}

-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"staff = %@, room = %@ formated date = %@",self.staff,self.room,self.formatedStartDate];
    return desc;
}
-(void) dealloc
{	
	[room release];
	[staff release];
	[spaDescription release];
    [clientInstruction release];
	[super dealloc];
}


@end
