//
//  RSSpaCustConflictingBookingsVC.h
//  ResortSuite
//
//  Created by Cybage on 13/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
Create the soap  object to hit the webservice to check if there exits a conflict.
* Notifies the notification center about the soap response.
* Registered object then can take action as required.

 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class RSSpaCustomerConflictBookingsParser;
@class ResortSuiteAppDelegate;

@interface RSSpaCustConflictingBookingsVC : UIViewController <RSParserHandlerDelegate,RSConnectionHandlerDelegate>
{
	RSSpaCustomerConflictBookingsParser     *spaCustomerConflictBookingsParser;
	ResortSuiteAppDelegate                  *appDelegate;
}

@property (nonatomic, retain) RSSpaCustomerConflictBookingsParser *spaCustomerConflictBookingsParser;
 

/*!
 @method		loadSpaCustomerConflictingBookingView
 @brief			Sends notifications depending on the response received
 @details		...
 @param			(id) parserModelData which decides if there are conflicts, 
				if YES then alert the User, otherwise call to Create Booking web service
 @return		void
 */
-(void) loadSpaCustomerConflictingBookingView:(id) parserModelData;


/*!
 @method		checkForSpaCustomerConflicts
 @brief			This function checks for the Spa conflicts exists or not
 @details		isSecondField describes whether to add second column or not
 @param			(id) spaServiceOrClass is of type RSSpaService OR RSSpaClass, NSString dateTime
 @return		void
 */
-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime;

@end
