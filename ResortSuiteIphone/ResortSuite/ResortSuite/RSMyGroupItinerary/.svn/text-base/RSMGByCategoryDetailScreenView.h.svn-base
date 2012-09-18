//
//  RSMGByCategoryDetailScreenView.h
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMGByDateCustomCell.h"
#import "RSGroupEventDescViewController.h"
#import "customAccesoryButton.h"

@interface RSMGByCategoryDetailScreenView : UIViewController <UITableViewDelegate,UITableViewDataSource>{

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
 @brief			Initialization of the Group Events Array
 @details		It assigns the parameter to the class member and returns class object
 @param			NSMutableArray GroupEventsArray;
 @return		id
 */
-(id)initWithArray:(NSMutableArray *)GroupEventsArray;

/*!
 @method		setCellDataForCell
 @brief			Sets the data for cell after formatting
 @details		--
 @param			RSMGByDateCustomCell cell, NSIndexPath indexPath
 @return		void
 */
-(void)setCellDataForCell:(RSMGByDateCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath;

/*!
 @method		resetDataIn
 @brief			Resets the data for cell
 @details		--
 @param			RSMGByDateCustomCell cell
 @return		void
 */
-(void)resetDataIn:(RSMGByDateCustomCell *)cell;


/*!
 @method		stringFromDate
 @brief			Gets the date as paramater and converts to the string
 @details		--
 @param			NSDate date
 @return		NSString
 */
-(NSString *)stringFromDate:(NSDate *)date;

/*!
 @method		stringToDate
 @brief			Gets the string as parameter and converts to the date
 @details		--
 @param			NSString stringDate;
 @return		NSDate
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

@end
