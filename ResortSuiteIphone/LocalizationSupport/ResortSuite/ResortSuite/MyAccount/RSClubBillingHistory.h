//
//  RSClubBillingHistory.h
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillingPeriod : NSObject
{
	NSString *billDate;
	NSString *periodStartDate;
	NSString *frequency;
	NSString *paymentLeniency;
	NSString *balance;
	NSString *folioDue;
	NSString *payment;
	NSString *lateFeeApplied;
	NSString *lateFee;
	NSString *balanceDue;
}

@property (nonatomic, copy) NSString *billDate;
@property (nonatomic, copy) NSString *periodStartDate;
@property (nonatomic, copy) NSString *frequency;
@property (nonatomic, copy) NSString *paymentLeniency;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *folioDue;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *lateFeeApplied;
@property (nonatomic, copy) NSString *lateFee;
@property (nonatomic, copy) NSString *balanceDue;

@end


@interface RSClubBillingHistory : NSObject {

	Result *clubBillingResult;	
	NSString *accountId;
	NSMutableArray *billingPeriods;			//BillingPeriod
}
@property (nonatomic, retain) Result *clubBillingResult;	
@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSMutableArray *billingPeriods;	

@end