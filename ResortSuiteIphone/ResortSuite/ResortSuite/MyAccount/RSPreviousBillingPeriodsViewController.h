//
//  RSPreviousBillingPeriodsViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 * view controller that give the user the option to check out his 
 *previous billing information.
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class RSTableView,RSMainViewController;

@interface RSPreviousBillingPeriodsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,
UINavigationControllerDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>{
	NSMutableArray              *mainFieldArray;
	RSTableView                 *mainTableView;
	RSMainViewController        *mainVC;
	
	RSClubStatementParser       *clubStatementParser;
	ResortSuiteAppDelegate      *appDelegate;
}

@property (nonatomic, retain) RSClubStatementParser* clubStatementParser;


/*!
 @method		stringFromDate
 @brief			Convert date into the string
 @details		Create a string object from a given date
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDate:(NSDate *)date;
/*!
 @method		stringFromDateWithoutYear
 @brief			Convert date into the string
 @details		Create a string object from a given date
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDateWithoutYear:(NSDate *)date;

/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

/*!
 @method		dateRange
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSString *)dateRange:(NSString *)firstDate endDate:(NSString *)lastDate;

@end


