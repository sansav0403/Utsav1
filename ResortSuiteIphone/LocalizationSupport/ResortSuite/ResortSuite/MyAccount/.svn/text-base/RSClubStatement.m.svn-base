//
//  RSClubStatement.m
//  ResortSuite
//
//  Created by Cybage on 08/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSClubStatement.h"

@implementation FolioPayment

@synthesize ItemId;
@synthesize	type;
@synthesize label;
@synthesize folioDate;
@synthesize folioFormatedDate;
@synthesize amount;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
	}
	
    return self;
}

-(void) dealloc
{	
	[type release];
	[label release];
	[folioDate release];
	[folioFormatedDate release];

	[amount release];
 	
	[super dealloc];
}


@end



@implementation Item

@synthesize itemId;
@synthesize	itemApp;
@synthesize itemFolioId;
@synthesize amount;
@synthesize itemDate;
@synthesize itemFormatedDate;
@synthesize name;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
	}
	
    return self;
}

-(void) dealloc
{
	[itemApp release];
	[amount release];
	[itemDate release];
	[itemFormatedDate release];
	[name release];
	
	[super dealloc];
}

@end


@implementation PostingItem

@synthesize ItemId;
@synthesize items;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
		items = [[NSMutableArray alloc] init];
	}
	
    return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end



@implementation FolioItem

@synthesize ItemId;
@synthesize	name;
@synthesize folioDate;
@synthesize folioFormatedDate;
@synthesize price;
@synthesize	quantity;
@synthesize discount;
@synthesize extPrice;
@synthesize	totalPrice;
@synthesize postingItems;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
		postingItems = [[NSMutableArray alloc] init];
	}
	
    return self;
}

-(void) dealloc
{	
	[name release];
	[folioDate release];
	[folioFormatedDate release];
	
	[price release];
	[quantity release];
	[discount release];
	[extPrice release];
	[totalPrice release];
	
	[postingItems removeAllObjects];
	[postingItems release];
	
	[super dealloc];
}

@end


@implementation StmtBillingPeriod

@synthesize billDate;
@synthesize periodStartDate;
@synthesize paymentDueDate;
@synthesize previousBalance;
@synthesize payments;
@synthesize charges;
@synthesize accountBalance;
@synthesize currentBalance;
@synthesize lateFee;
@synthesize thirtyDayBalance;
@synthesize sixtyDayBalance;
@synthesize ninetyDayBalance;

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
	[paymentDueDate release];
	[previousBalance release];
	[payments release];
	[charges release];
	[accountBalance release];
	[currentBalance release];
	[lateFee release];
	[thirtyDayBalance release];
	[sixtyDayBalance release];
	[ninetyDayBalance release];
	
	[super dealloc];
}

@end

@implementation StatementAccount

@synthesize stmtAccId;
@synthesize	stmtClass;
@synthesize stmtCustName;
@synthesize stmtAccCustomer;
@synthesize	stmtBillingPeriod;
@synthesize folioItems;       
@synthesize folioPayments;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code		
		folioItems = [[NSMutableArray alloc] init];
		folioPayments = [[NSMutableArray alloc] init];
	}
	
    return self;
}

-(void) dealloc
{	
	[stmtAccId release];
	[stmtClass release];
	[stmtCustName release];
	[stmtAccCustomer release];
	[stmtBillingPeriod release];

	[folioItems removeAllObjects];
	[folioItems release];
	
	[folioPayments removeAllObjects];
	[folioPayments release];
	
	[super dealloc];
}

@end


@implementation RSClubStatement

@synthesize	clubStmtResult;
@synthesize stmtAccount;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code				
	}
	
    return self;
}

-(void) dealloc
{	
	[clubStmtResult release];
	[stmtAccount release];
	
	[super dealloc];
}

@end
