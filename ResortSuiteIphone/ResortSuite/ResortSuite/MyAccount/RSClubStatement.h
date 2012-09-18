//
//  RSClubStatement.h
//  ResortSuite
//
//  Created by Cybage on 08/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSClubAccounts.h"
#import "RSFolio.h"


@interface FolioPayment : NSObject
{
	int ItemId;
	NSString *type;
	NSString *label;
	NSString *folioDate;
	NSDate* folioFormatedDate;
	NSString *amount;
}

@property (nonatomic) int ItemId;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *folioDate;
@property (nonatomic, retain) NSDate* folioFormatedDate;

@property (nonatomic, retain) NSString *amount;

@end


@interface Item : NSObject
{
	int itemId;
	NSString *itemApp;
	int itemFolioId;
	
	NSString *amount;
	NSString *itemDate;
	NSString *name;

	NSDate* itemFormatedDate;
}
@property (nonatomic) int itemId;
@property (nonatomic, retain) NSString *itemApp;
@property (nonatomic) int itemFolioId;

@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *itemDate;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate* itemFormatedDate;

@end




@interface PostingItem : NSObject
{
	int	ItemId;	
	NSMutableArray *items;				//Item
}

@property (nonatomic) int ItemId;
@property (nonatomic, retain) NSMutableArray *items;

@end


@interface FolioItem : NSObject
{
	int ItemId;
	NSString *name;
	NSString *folioDate;
	NSDate* folioFormatedDate;

	NSString *price;
	NSString *quantity;
	NSString *discount;
	NSString *extPrice;
	NSString *totalPrice;
	
	NSMutableArray *postingItems;	//PostingItem
}
@property (nonatomic) int ItemId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *folioDate;
@property (nonatomic, retain) NSDate* folioFormatedDate;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *extPrice;
@property (nonatomic, retain) NSString *totalPrice;
@property (nonatomic, retain) NSMutableArray *postingItems;

@end



@interface StmtBillingPeriod : NSObject
{
	NSString *billDate;
	NSString *periodStartDate;
	NSString *paymentDueDate;
	NSString *previousBalance;
	NSString *payments;
	NSString *charges;
	NSString *accountBalance;
	NSString *currentBalance;
	NSString *lateFee;
	NSString *thirtyDayBalance;
	NSString *sixtyDayBalance;
	NSString *ninetyDayBalance;
}

@property (nonatomic, retain) NSString *billDate;
@property (nonatomic, retain) NSString *periodStartDate;
@property (nonatomic, retain) NSString *paymentDueDate;
@property (nonatomic, retain) NSString *previousBalance;
@property (nonatomic, retain) NSString *payments;
@property (nonatomic, retain) NSString *charges;
@property (nonatomic, retain) NSString *accountBalance;
@property (nonatomic, retain) NSString *currentBalance;
@property (nonatomic, retain) NSString *lateFee;
@property (nonatomic, retain) NSString *thirtyDayBalance;
@property (nonatomic, retain) NSString *sixtyDayBalance;
@property (nonatomic, retain) NSString *ninetyDayBalance;

@end



@interface StatementAccount : NSObject
{
	NSString *stmtAccId;
	NSString *stmtClass;
	NSString *stmtCustName;
	
	AccCustomer *stmtAccCustomer;
	StmtBillingPeriod *stmtBillingPeriod;
	
	NSMutableArray *folioItems;        //FolioItem	
	NSMutableArray *folioPayments;	   //FolioPayment
}

@property (nonatomic, retain) NSString *stmtAccId;
@property (nonatomic, retain) NSString *stmtClass;
@property (nonatomic, retain) NSString *stmtCustName;

@property (nonatomic, retain) AccCustomer *stmtAccCustomer;
@property (nonatomic, retain) StmtBillingPeriod *stmtBillingPeriod;

@property (nonatomic, retain) NSMutableArray *folioItems;        //FolioItem
@property (nonatomic, retain) NSMutableArray *folioPayments;	 //FolioPayment

@end




@interface RSClubStatement : NSObject {

	Result *clubStmtResult;
	StatementAccount *stmtAccount;
}

@property (nonatomic, retain) Result *clubStmtResult;
@property (nonatomic, retain) StatementAccount *stmtAccount;

@end
