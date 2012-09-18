//
//  RSListAccountsViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *view controller to display the list of all the account of the user
 *if the account count is greater than zero.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>

@class RSTableView,RSMainViewController;
@class ResortSuiteAppDelegate;

@interface RSListAccountsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,
UINavigationControllerDelegate>{
    
	NSMutableArray          * mainFieldArray;
	RSTableView             * mainTableView;
	RSMainViewController    * mainVC;
	
	RSClubStatementParser   * clubStatementParser;
	
	ResortSuiteAppDelegate  *appDelegate;
}

@property (nonatomic, retain) RSClubStatementParser* clubStatementParser;

@end


