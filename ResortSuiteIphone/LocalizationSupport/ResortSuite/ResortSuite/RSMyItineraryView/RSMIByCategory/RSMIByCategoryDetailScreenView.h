//
//  RSMGByCategoryDetailScreenView.h
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to display the event for a particular category.
 
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSMGByDateCustomCell.h"
#import "RSGroupEventDescViewController.h"
#import "customAccesoryButton.h"

@interface RSMIByCategoryDetailScreenView : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	NSArray *GroupEvents;
	UITableView *tableView;
	
	NSSortDescriptor* sortDescriptor;
	NSArray *sortDescriptors;
	NSArray* sortedGroupEventObjectArray;
	
	NSMutableArray *dateKeyArray;
	NSArray *sortedDateKeyArray;
	NSMutableDictionary *dateDictionary;
}
@property (nonatomic, retain) NSArray *GroupEvents;

/*!
 @method		initWithArray
 @brief			Initialize array of group events
 @details		-
 @param			(NSMutableArray *)GroupEventsArray;
 @return		id
 */
-(id)initWithArray:(NSMutableArray *)GroupEventsArray;

/*!
 @method		setCellDataForCell
 @brief			Set the value of the objects used in custom cell
 @details		-
 @param			(RSMGByDateCustomCell *)cell, (NSIndexPath *)indexPath;
 @return		void
 */
-(void)setCellDataForCell:(RSMGByDateCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath;

/*!
 @method		resetDataIn
 @brief			Initialize all objects of cutom cell with null value
 @details		-
 @param			(RSMGByDateCustomCell *)cell;
 @return		void
 */
-(void)resetDataIn:(RSMGByDateCustomCell *)cell;

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
