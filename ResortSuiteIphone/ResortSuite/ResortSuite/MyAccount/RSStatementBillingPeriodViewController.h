//
//  RSStatementBillingPeriodViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 * view controller which tablularly displays the billing info of the user for a account.
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class RSTableView,RSMainViewController;
@class ResortSuiteAppDelegate;
@class RSClubStatementParser;
@class RSClubBillingHistoryParser;

enum BillingPeriodSection {
	CurrentSection,
	LastSection,
	PreviousSection
};

@interface RSStatementBillingPeriodViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,
										UINavigationControllerDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>{
	NSMutableArray* mainFieldArray;
	RSTableView* mainTableView;
	RSMainViewController* mainVC;
	
	ResortSuiteAppDelegate *appDelegate;
	NSString *responseString;
				
	RSClubStatementParser *clubStatementParser;
	RSClubBillingHistoryParser *clubBillingHistoryParser;
}

@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) RSClubStatementParser *clubStatementParser;
@property (nonatomic, retain) RSClubBillingHistoryParser *clubBillingHistoryParser;

@end


