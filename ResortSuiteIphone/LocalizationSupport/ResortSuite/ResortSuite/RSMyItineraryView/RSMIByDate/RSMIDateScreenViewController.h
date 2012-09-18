//
//  RSMIDateScreenViewController.h
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *this class has the resposibility to create the dictionary to segregate the event
 * based on the date
 *also displays all the date for which their exists one or more events
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSTableView.h"

@interface RSMIDateScreenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableArray *dateKeyArray;
	NSArray *sortedDateKeyArray;
	NSMutableDictionary *dateDictionary;
	RSTableView * mainTableView;
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
