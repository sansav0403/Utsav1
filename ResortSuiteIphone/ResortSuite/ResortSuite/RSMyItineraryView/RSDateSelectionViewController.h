//
//  RSDateSelectionViewController.h
//  ResortSuite
//
//  Created by Cybage on 17/08/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to allow user to select a date range for view the Itinerary in the selected reange
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class ResortSuiteAppDelegate;
@class RSBookingTableView;

enum DatesSection {
	StartDateSection,
	EndDateSection,
	NoOfDatesSections
};

@interface RSDateSelectionViewController : UIViewController<RSParserHandlerDelegate,RSConnectionHandlerDelegate> {

	IBOutlet RSBookingTableView         *dateTable;
	IBOutlet UIDatePicker               *datePicker;
	IBOutlet UIButton                   *doneButton;
    
	int                                 currentSelectedRowIndex;
	UILabel                             *startDateLabel, *endDateLabel;
	NSDate                              *startDate, *endDate;
	ResortSuiteAppDelegate              *appDelegate;
    
    RSMyItineraryParser                 *parserItineraryObj;    //itinerary parser obj
    NSString                            *responseString;
    ////---------
    NSIndexPath                         *pathForfirstCell;
}
@property (nonatomic,copy) NSString *responseString;
@property (nonatomic,retain) RSMyItineraryParser *parserItineraryObj;

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

@property (nonatomic, retain) NSIndexPath *pathForfirstCell;

/*!
 @method		drawDoneButton
 @brief			Set Draw button in the view
 @details		....
 @param			-
 @return		void
 */
-(void)drawDoneButton;

/*!
 @method		doneButtonAction
 @brief			Depending on the date selected from the picker, the action is performed on click of Done
 @details		....
 @param			id sender
 @return		IBAction
 */
-(IBAction) doneButtonAction:(id)sender;
/*!
 @method		loadMyItineraryView
 @brief			Navigate the view to My Itineray controller
 @details		-
 @param			-
 @return		void
 */
-(void) loadMyItineraryView;
-(void) guestItineraryDataReceived:(id)parserModelData;
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
-(void) fetchGuestItineraryForClub: (NSString *) startdate EndDate:(NSString *) enddate;
-(void) fetchGuestItineraryForHotel: (NSString *) startdate EndDate:(NSString *) enddate withFolioId:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin;
-(void) showErrorMessage:(id)parserModelData;
@end
