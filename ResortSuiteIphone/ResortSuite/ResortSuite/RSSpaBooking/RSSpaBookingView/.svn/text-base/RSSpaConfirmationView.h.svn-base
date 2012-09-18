//
//  RSSpaConfirmationView.h
//  ResortSuite
//
//  Created by Cybage on 9/20/11.
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
#import "RSSpaService.h"
#import "RSConfirmationBaseClass.h"
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSSpaCustConflictingBookingsVC.h"

@class ResortSuiteAppDelegate;
@class RSSpaServiceBookingParser;

@interface RSSpaConfirmationView : RSConfirmationBaseClass <RSParserHandlerDelegate,RSConnectionHandlerDelegate>

{
    //NSDate *bookingDate;
	NSString                        *selectedDateAndTime;
    RSSpaService                    *bookedService;
    NSArray                         *spaAvailibilities;
    
    NSString                        *prefGender;
    NSString                        *prefStaffName;
	NSString                        *bookingTime;
    
	ResortSuiteAppDelegate          *appDelegate;
	RSSpaServiceBookingParser       *spaServiceBookingParser;
    RSSpaCustConflictingBookingsVC  *spaCustConflictingBookingsVC;
}

//@property(nonatomic, retain) NSDate *bookingDate;
@property(nonatomic, retain) NSString *selectedDateAndTime;
@property(nonatomic, retain) RSSpaService *bookedService;

@property(nonatomic, retain) NSArray *spaAvailibilities;

@property(nonatomic, copy) NSString *prefGender;

@property(nonatomic, copy) NSString *prefStaffName;

@property(nonatomic, retain) RSSpaServiceBookingParser *spaServiceBookingParser;

-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService ;      //date should contain date + time
/*!
 @method		initWithSpaAvailibilityArray
 @brief		    init object with spa availibility array for selected service with selected staff and staff gender
 @details		....
 @param			NSArray,RSSpaService,NSString
 @return		id
 */ 
-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService
                WithSelectedStaff:(NSString *)staffName andGender:(NSString *)selectedStaffgender;
/*!
 @method		displayBookingConfirmation
 @brief		    display Booking Confirmation
 @details		....
 @param			-
 @return		void
 */ 
-(void)displayBookingConfirmation;
/*!
 @method		drawBookButton
 @brief		    draw Book Button
 @details		....
 @param			-
 @return		void
 */ 
-(void)drawBookButton;
/*!
 @method		displayBookingOption
 @brief		    display Booking Option wth messages
 @details		....
 @param			-
 @return		void
 */ 
-(void)displayBookingOption;
/*!
 @method		dateFromString
 @brief		    generate date object from date string
 @details		....
 @param			-
 @return		void
 */ 
-(NSDate *)dateFromString:(NSString *)stringDate;
/*!
 @method		createSpaBooking
 @brief		    create Spa Booking on he user confirmation
 @details		....
 @param			-
 @return		void
 */ 
-(void)createSpaBooking;

/*!
 @method		updateBookingTime
 @brief		    update next booking time with respect to current booking
 @details		....
 @param			-
 @return		void
*/ 
-(void) updateBookingTime;

@end
