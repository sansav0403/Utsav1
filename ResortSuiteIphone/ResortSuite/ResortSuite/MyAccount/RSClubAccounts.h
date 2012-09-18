//
//  RSClubAccounts.h
//  ResortSuite
//
//  Created by Cybage on 06/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSFolio.h"

@interface Person : NSObject
{
	NSString *salutation;
	NSString *firstName;
	NSString *lastName;		
}

@property (nonatomic, retain) NSString *salutation;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;	

@end


@interface Address : NSObject
{
	
	NSString *addressLine1;
	NSString *addressLine2;
	NSString *city;
	NSString *province;
	NSString *country;
	NSString *postalCode;
}

@property (nonatomic, retain) NSString *addressLine1;
@property (nonatomic, retain) NSString *addressLine2;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *postalCode;

@end

@interface Billing : NSObject
{
	NSString *frequency;
	NSString *nextBillDate;
}

@property (nonatomic, retain) NSString *frequency;
@property (nonatomic, retain) NSString *nextBillDate;

@end

@interface Member : Person
{	
	NSString *VIPLevel;
}
@property (nonatomic, copy) NSString *VIPLevel;

@end


@interface MemberShip : Person
{
	NSString *name;
	NSString *status;
	NSString *effectiveDate;
	NSString *expiryDate;	
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *effectiveDate;
@property (nonatomic, retain) NSString *expiryDate;


@end

@interface AccCustomer : Person {
	
	NSString *customerId;
	NSString *customerGUID;
	Address *address;
	NSString *emailAddress;
	NSString *phoneNumber;
	NSString *customerCode;
	NSString *VIPLevel;
}

@property (nonatomic, retain) NSString *customerId;
@property (nonatomic, retain) NSString *customerGUID;
@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *customerCode;
@property (nonatomic, retain) NSString *VIPLevel;

@end

@interface Account : NSObject
{
	NSString *accountId;
	NSString *classType; 
	NSString *statementCustomerName;
	Billing *billing;
	NSMutableArray *members; //Member
	NSMutableArray *memberShips;
}

@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSString *classType; 
@property (nonatomic, retain) NSString *statementCustomerName;
@property (nonatomic, retain) Billing *billing;
@property (nonatomic, retain) NSMutableArray *members; //Member
@property (nonatomic, retain) NSMutableArray *memberShips;

@end



@interface RSClubAccounts : NSObject {
	
	Result *clubResult;
	AccCustomer *accCustomer;
	NSMutableArray *accounts;  //account
}

@property (nonatomic, retain) Result *clubResult;
@property (nonatomic, retain) AccCustomer *accCustomer;
@property (nonatomic, retain) NSMutableArray *accounts;

@end
