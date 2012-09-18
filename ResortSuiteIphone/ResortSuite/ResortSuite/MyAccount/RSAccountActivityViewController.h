//
//  RSAccountActivityViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *view controller to display the Activity under a particular account
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"

@class ResortSuiteAppDelegate;
@class RSTableView,RSMainViewController;

enum ActivitySection {
	ProfileSection,
	StatementSection
};

@interface RSAccountActivityViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIAlertViewDelegate>{
    
	NSMutableArray              * mainFieldArray;
	RSTableView                 * mainTableView;
	RSMainViewController        * mainVC;
	ResortSuiteAppDelegate      *appDelegate;
}


/*!
 @method		stringFromDate
 @brief			Convert date into the string
 @details		Create a string object from a given date
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDate:(NSDate *)date;

/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

@end


