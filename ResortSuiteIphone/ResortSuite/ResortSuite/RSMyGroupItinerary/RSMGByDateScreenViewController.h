//
//  RSMGByDateScreenViewController.h
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSMGByDateScreenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

	NSMutableArray *dateKeyArray;
	NSArray *sortedDateKeyArray;
	NSMutableDictionary *dateDictionary;
	RSTableView * mainTableView;
	NSArray *GroupEventArray;
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
