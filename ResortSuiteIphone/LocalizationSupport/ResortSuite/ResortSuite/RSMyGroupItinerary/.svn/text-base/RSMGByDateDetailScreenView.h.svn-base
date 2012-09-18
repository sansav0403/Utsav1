//
//  RSMGByDateDetailScreenView.h
//  ResortSuite
//
//  Created by Cybages on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import"RSMGByDateCustomCell.h"

@interface RSMGByDateDetailScreenView : UIViewController <UITableViewDelegate,UITableViewDataSource> {

	NSArray *GroupEvents;
	UITableView *tableView;
	
	NSSortDescriptor* sortDescriptor;
	NSArray *sortDescriptors;
	NSArray* sortedGroupEventObjectArray;
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

@end
