//
//  RSSpaClassDescVC.h
//  ResortSuite
//
//  Created by Cybage on 03/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Child class of RSConfirmationBaseClass to implement the comman function in the confirmation view.
 * Create the dynamic description taking only the space it rewuires on the screen.
 * All the label adjust them self according the label text length.
 * describes the selected Class details
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaClass.h"

@class ResortSuiteAppDelegate;

@interface RSSpaClassDescVC : RSConfirmationBaseClass {

	RSSpaClass *selectedClass;
	UIButton *bookButton;
	ResortSuiteAppDelegate *appDelegate;
}

@property (nonatomic, retain) RSSpaClass *selectedClass;
/*
 @method        initWithSelectedClass
 @brief			initialize object With Selected spa Class
 @details		
 @param			(RSSpaClass *)selClass
 @return        (id)
 */
-(id)initWithSelectedClass:(RSSpaClass *)selClass;
/*
 @method        getDateTimeFromString
 @brief			get date or time from date string based on the requiured format
 @details		
 @param			(NSString *) dateString
 @return        (NSString *)
 */
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *) dateOrTime;

@end
