//
//  RSGolfConfirmationView.h
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display the confirmation view for golf booking
 * give the brief info about the service to be booked
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSSpaLocation.h"


@class RSGolfRatesParser;
@class RSGolfBookingParser;
@class RSGolfRates;

@interface RSGolfConfirmationView : RSConfirmationBaseClass < UINavigationControllerDelegate,RSParserHandlerDelegate,
RSConnectionHandlerDelegate > {
    
    ResortSuiteAppDelegate *appDelegate;
    
    RSGolfRatesParser *rateParser;
    RSGolfBookingParser *golfBookingParser;
    
    RSGolfRates *golfRate;
    
    NSString *TimeOfBooking;
    NSString *selectedCourseId;
    NSString *selectedPlayers;
    
    NSString *timeString;
    NSString *dateString;
}

@property(nonatomic, copy) NSString *TimeOfBooking;
@property(nonatomic, copy) NSString *selectedCourseId;
@property(nonatomic, copy) NSString *selectedPlayers;

@property(nonatomic, copy) NSString *timeString;
@property(nonatomic, copy) NSString *dateString;

@property(nonatomic, retain) RSGolfRates *golfRate;

/*!
 @method		initWithSelectedTime
 @brief			init With Selected Time for selected course ID and number of players
 @details		
 @param			NSString
 @return		id
 */
-(id)initWithSelectedTime:(NSString *)dateTime andSelectedCourseID:(NSString *)courseId andSelectedPlayer:(NSString *)player;
/*!
 @method		fetchDataForRequestWithBody
 @brief			fetch Data For Request With Soap Body
 @details		
 @param			NSString
 @return		id
 */
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
/*!
 @method		showErrorMessage
 @brief			show Error Message
 @details		
 @param			id
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;
/*!
 @method		drawBookButton
 @brief			draw Book Button on the view
 @details		
 @param			
 @return		void
 */
-(void)drawBookButton;
/*!
 @method		createMainBodyLabelArray
 @brief			create Main Body Label to display the confirmnation details
 @details		
 @param			
 @return		void
 */
-(void)createMainBodyLabelArray;
/*!
 @method		createGolfBooking
 @brief			create Golf Booking once the user confirms the information
 @details		
 @param			
 @return		void
 */
-(void)createGolfBooking;

@end
