//
//  RSAvailableTeeTimeVC.h
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display the available tee time for the selected time
 * displays the available tee time in table
 * selected tee time is passed to booking action.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSSpaLocation.h"

@class RSBookingTableView;

@interface RSAvailableTeeTimeVC : UIViewController < UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource > {
    
    ResortSuiteAppDelegate *appDelegate;
    
    RSBookingTableView *mainTableView;
    
    UILabel *instructionLabel;
    
     NSArray *AvailableTeeTimeArray;
    
    NSString *selectedCourseId;
    NSString *selectedNoOfPlayers;

}

@property(nonatomic, retain)  NSArray *AvailableTeeTimeArray;
@property(nonatomic, copy)  NSString *selectedCourseId;
@property(nonatomic, copy)  NSString *selectedNoOfPlayers;
/*!
 @method		initWithTeeTimeArray
 @brief			init With TeeTime Array for selected course id and number of player
 @details		
 @param			NSString
 @return		id
 */
-(id)initWithTeeTimeArray:(NSArray *)TeeTime withSelectedCourseId:(NSString *)courseID andNoOfPlayer:(NSString *)players;

@end
