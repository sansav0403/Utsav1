//
//  RSByDateDetailScreenViewController.h
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to display the event for a particular date.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSMIDateScreenCustomCell.h"

@interface RSByDateDetailScreenViewController :UIViewController <UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *folios;
	UITableView *tableView;
	
	NSSortDescriptor* sortDescriptor;
	NSArray *sortDescriptors;
	NSArray* sortedFolioObjectArray;
//	NSMutableArray *folioKeyArray;
//	NSMutableDictionary *folioDictionary;
//	NSArray *sortedDateKeyArray;
}

@property (nonatomic, retain) NSArray *folios;

/*!
 @method		initWithArray
 @brief			Initialize array of group events
 @details		-
 @param			(NSMutableArray *)folioArray;
 @return		id
 */
- (id)initWithArray:(NSMutableArray *)folioArray;

/*!
 @method		setCellDataForCell
 @brief			Set the value of the objects used in custom cell
 @details		-
 @param			(RSMIDateScreenCustomCell *)cell, (NSIndexPath *)indexPath;
 @return		void
 */
-(void)setCellDataForCell:(RSMIDateScreenCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath;

/*!
 @method		resetDataIn
 @brief			Initialize all objects of cutom cell with null value
 @details		-
 @param			(RSMGByDateCustomCell *)cell;
 @return		void
 */
-(void) resetDataIn:(RSMIDateScreenCustomCell *)cell;
@end
