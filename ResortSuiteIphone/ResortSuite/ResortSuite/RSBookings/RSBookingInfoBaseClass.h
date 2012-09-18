//
//  RSBookingInfoBaseClass.h
//  ResortSuite
//
//  Created by Cybage on 9/16/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Booking info Base class
*base class to define the basic nature of the information class.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>


@interface RSBookingInfoBaseClass : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *infoArray;         //to store the array of inforamation  like location,courses etc
	UITableView *tableView;
}

@property (nonatomic, retain) NSArray *infoArray;
/*!
 @method		createTableView
 @brief			create Table View in side the view
 @details		
 @param			
 @return		void
 */ 
-(void) createTableView;

@end
