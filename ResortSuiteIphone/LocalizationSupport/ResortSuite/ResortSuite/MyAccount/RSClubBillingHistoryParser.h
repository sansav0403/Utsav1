//
//  RSClubBillingHistoryParser.h
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSParseBase.h"
#import "RSClubBillingHistory.h"

@interface RSClubBillingHistoryParser : RSParseBase <NSXMLParserDelegate> {

	NSMutableString *value;
	
	RSClubBillingHistory *clubBillingHistory;
	BOOL isError;
	Result *errorResult;
	
	BillingPeriod *billingPeriod;
}

@property (nonatomic, retain) RSClubBillingHistory *clubBillingHistory;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;

@end

	
	