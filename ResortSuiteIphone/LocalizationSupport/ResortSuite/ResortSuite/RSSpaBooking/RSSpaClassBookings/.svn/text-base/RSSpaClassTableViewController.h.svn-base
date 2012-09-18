//
//  RSSpaClassTableViewController.h
//  ResortSuite
//
//  Created by Cybage on 03/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Displays the table of all service within the selected category
 * On selection of the accessory button push the service Description view
 * select Button appears only after selection of a service.
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class ResortSuiteAppDelegate;
@class RSSpaCustomerConflictBookingsParser;
@class RSSpaClass;

@interface RSSpaClassTableViewController : UIViewController <UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource>
{
	UITableView *mainTableView;
	UIButton *selectButton;
		
	NSArray *tableColumnTitles;
	NSArray *spaClasses;  
	int selectedSpaClassIndex;  //no use of this variable
	ResortSuiteAppDelegate *appDelegate;
	
	RSSpaCustomerConflictBookingsParser *spaCustomerConflictBookingsParser;
}

@property(nonatomic, retain) NSArray *spaClasses;
@property(nonatomic, retain) RSSpaCustomerConflictBookingsParser *spaCustomerConflictBookingsParser;


-(id)initWithSpaClassArray:(NSArray *)spaClassesArray;

/*
 @method        drawTableColumnTitleWithTitleArray
 @brief			draw Table Column Title
 @details		draw Table Column Title With Title Array
 @param			NSArray
 @return        (void)
 */
-(void)drawTableColumnTitleWithTitleArray:(NSArray *)titleArray AtYCord:(float)ycord;

/*
 @method        drawSeperatorImageAtYCord
 @brief			draw Seperator Image
 @details		draw Seperator Image  at Ycord
 @param			float
 @return        (void)
 */
-(void)drawSeperatorImageAtYCord:(float)ycord ;
/*
 @method        getTimeFromString
 @brief			get Time From String
 @details		
 @param			NSString
 @return        (NSString)
 */
-(NSString *) getTimeFromString:(NSString *) dateString;
/*
 @method        AddSelectButtonWithTag
 @brief			Add Select Button With Tag information storing capability
 @details		
 @param			int
 @return        (void)
 */
-(void)AddSelectButtonWithTag:(int)rowinfo;

@end
