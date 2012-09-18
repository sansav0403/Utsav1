//
//  RSSpaServicesTableViewController.h
//  ResortSuite
//
//  Created by Cybage on 9/27/11.
//  Copyright 2011 Resort Suite. All rights reserved.
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

@interface RSSpaServicesTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UINavigationControllerDelegate>{
    
    NSArray *tableColumnTitles;
    
    UITableView *serviceTable;
    NSArray *spaServiceArray;    
   
    UIButton *selectButton;
    ResortSuiteAppDelegate *appDelegate;
}

@property(nonatomic, retain) NSArray *spaServiceArray;

/*
 @method		initWithSpaServiceArray
 @brief         initailize the view  
 @details		initailize the view with service array 
 @param			void
 @return		(void)
 */
-(id)initWithSpaServiceArray:(NSArray *)spaServices;

/*
@method         createTitleLabel
@brief			create Title Label 
@details		create Title Label 
@param			NSString
@return         (void)
*/
-(void)createTitleLabelWithTitle:(NSString *)title;

/*
 @method         drawTableColumnTitleWithTitleArray
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
 @method        createServiceTable
 @brief			create Service Table
 @details		create Service Table at Ycord
 @param			float
 @return        (void)
 */
-(void)createServiceTable:(CGFloat)coordinateY;
/*!
 @method		AddSelectButtonWithTag
 @brief		    Add Select Button with tag
 @details		....
 @param			int
 @return		void
 */ 
-(void)AddSelectButtonWithTag:(int)rowinfo;

@end
