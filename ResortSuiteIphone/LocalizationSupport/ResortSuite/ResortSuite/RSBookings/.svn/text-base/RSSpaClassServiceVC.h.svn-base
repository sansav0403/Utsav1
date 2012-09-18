//
//  RSSpaClassServiceVC.h
//  ResortSuite
//
//  Created by Cybage on 22/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Class to describe the type of booking available with different spa locations
 *this class is visible only when the type of booking is All.
 
 
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSSpaLocation.h"


@class RSBookingTableView;
@class ResortSuiteAppDelegate;

//Describes the section of the table
enum SpaSections {
	ClassSection,
	ServiceSection
};

@interface RSSpaClassServiceVC : UIViewController<UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource>
{
	NSString                    *viewTitle;
	NSMutableArray              *mainFieldArray;
	RSBookingTableView          *mainTableView;
	
	ResortSuiteAppDelegate      *appDelegate;
}

@property(nonatomic,retain) NSString *viewTitle;

/*!
 @method		initWithViewTitle
 @brief			Intitializes the title to set when view loads
 @details		....
 @param			title of the view
 @return		obj of RSSpaClassServiceVC
 */
-(id) initWithViewTitle:(NSString *) viewTitleString;

@end
