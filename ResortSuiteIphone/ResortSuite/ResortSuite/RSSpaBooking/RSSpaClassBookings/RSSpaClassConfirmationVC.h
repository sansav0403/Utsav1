//
//  RSSpaClassConfirmationVC.h
//  ResortSuite
//
//  Created by Cybage on 10/14/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Child class of RSConfirmationBaseClass to implement the comman function in the confirmation view.
 * Create the dynamic description taking only the space it rewuires on the screen.
 * All the label adjust them self according the label text length.
 * check for conflict using the RSSpaCustConflictingBookingsVC class.
 *create booking if no conflict
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSConfirmationBaseClass.h"
#import "RSClassBookingParser.h"
#import "RSSpaClass.h"
#import "RSSpaCustConflictingBookingsVC.h"
@interface RSSpaClassConfirmationVC : RSConfirmationBaseClass <RSConnectionHandlerDelegate,RSParserHandlerDelegate>{
    
	RSSpaClass *selectedClass;
	UIButton *bookButton;
	ResortSuiteAppDelegate *appDelegate;
    
    RSClassBookingParser *classBookingParser;
    RSSpaCustConflictingBookingsVC *spaCustConflictingBookingsVC;
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
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *)dateOrTime;
/*
 @method        createClassBooking
 @brief			create class booking on confirmation
 @details		
 @param			
 @return        (void)
 */
-(void)createClassBooking;
/*
 @method        fetchDataForRequestWithBody
 @brief			fetch Data For Request With soap Body
 @details		
 @param			(NSString *) bodyString
 @return        (void)
 */
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
@end
