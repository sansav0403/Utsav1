//
//  ErrorPopup.h
//  ResortSuite
//
//  Created by Cybage on 28/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *custom uialertview to display the user defined message or messages send by server
  
 ================================================================================
 */
#import <Foundation/Foundation.h>

@class ResortSuiteAppDelegate;

@interface ErrorPopup : UIView {

	ResortSuiteAppDelegate *appDelegate;
}

/*!
 @method		sharedInstance
 @brief			Singleton instance of ErrorPopup class
 @details		....
 @param			nil
 @return		ErrorPopup class object
 */
+(ErrorPopup *)sharedInstance;


/*!
 @method		initWithTitle
 @brief			Initialization of the alert
 @details		It takes the title as input and shows the alert with the title
 @param			NSString title
 @return		void
 */ 
- (void) initWithTitle:(NSString *) title;

/*!
 @method		initWithErrorId
 @brief			Initialization of the alert
 @details		It takes the ErrorId as input and shows the alert with the title
 @param			int ErrorId
 @return		void
 */ 
- (void)initWithErrorId:(int)errorId;
@end
