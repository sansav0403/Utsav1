//
//  RSPlayerSelectionVC.h
//  ResortSuite
//
//  Created by Cybage on 10/11/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display a picker view to allow the user to select no of players
 * 
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSBookingTableView.h"

@interface RSPlayerSelectionVC : UIViewController<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate> {
    
    UIButton *selectBtn;
	
	ResortSuiteAppDelegate *appDelegate; 
	
	NSMutableArray *mainFieldArray, *subFieldArray;
    
    RSBookingTableView *mainTableView;
    
    NSArray *NoPlayersArray;
    
    UIPickerView   *PlayerPickerView;
}
/*!
 @method		addControlsToView
 @brief			add UI Controls To View
 @details		
 @param			
 @return		void
 */
-(void) addControlsToView;
/*!
 @method		selectNoOfPlayer
 @brief			select No Of Player from picker View
 @details		
 @param			id
 @return		void
 */
-(void)selectNoOfPlayer:(id) sender;
@end
