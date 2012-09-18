//
//  RSSpaStaffSeletionVC.h
//  ResortSuite
//
//  Created by Cybage on 11/10/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
Displays the Gender and the name of the staff in UIPickerView.

 ================================================================================
 */

#import <UIKit/UIKit.h>

enum StaffPickerType {
	PrefStaffGenderPicker = 3,
	PrefStaffPicker
};

@class ResortSuiteAppDelegate, RSBookingTableView;

@interface RSSpaStaffSeletionVC : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate>{
	UIPickerView *prefStaffPicker;
	ResortSuiteAppDelegate *appDelegate;
	RSBookingTableView *mainTableView;
	NSMutableArray *mainFieldArray, *subFieldArray, *prefStaffGenders;
	NSArray *prefStaffNames;
	int pickerType;
	UIButton *searchButton;
}

@property (nonatomic, retain) NSArray *prefStaffNames;

/*!
 @method		initWithSection
 @brief			Initialization for type of picker like Gender or Names picker
 @details		....
 @param			int section, array of pref staff genders or names
 @return		RSSpaStaffSeletionVC class object
 */
-(id) initWithSection:(int) section prefStaffs:(NSArray *) prefstaffs;

/*!
 @method		addControlsToView
 @brief			Add UI controls to the view
 @details		....
 @param			nil
 @return		void
 */
-(void) addControlsToView;

@end
