//
//  RSSpaAvailableTimes.h
//  ResortSuite
//
//  Created by Cybage on 17/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
Displays the Time Slot available for booking.
* On selection of a available time the view is pushed to the confirmation view
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSBookingTableViewCell.h"

@class RSSpaService, RSBookingTableView;

@interface RSSpaAvailableTimes : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    ResortSuiteAppDelegate *appDelegate;
    
    RSBookingTableView *mainTableView;
    
    UILabel *instructionLabel;
    
	NSArray *availableTimes;
	RSSpaService *spaServiceSelected;
	NSString *selectedStaffName;
	NSString *selectedStaffGender;	
}

@property(nonatomic, retain)  NSArray *availableTimes;
@property(nonatomic, retain)  RSSpaService *spaServiceSelected;
@property(nonatomic, retain)  NSString *selectedStaffName;
@property(nonatomic, retain)  NSString *selectedStaffGender;	

/*!
 @method		initWithAvailableTimes
 @brief		    int the 
 @details		....
 @param			int
 @return		void
 */
-(id) initWithAvailableTimes:(NSArray *)times forSelectedSpaService:(RSSpaService *)spaService
		   WithSelectedStaff:(NSString *)staffName andGender:(NSString *)staffGender;

@end