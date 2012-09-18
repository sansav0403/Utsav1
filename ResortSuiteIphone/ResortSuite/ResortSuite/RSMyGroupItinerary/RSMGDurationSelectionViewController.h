//
//  RSDateSelectionViewController.h
//  ResortSuite
//
//  Created by Cybage on 17/08/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
@class ResortSuiteAppDelegate;
@class RSBookingTableView;

enum MGDatesSection {
	MGStartDateSection,
	MGEndDateSection,
	MGNoOfDatesSections
};

@interface RSMGDurationSelectionViewController : UIViewController<RSParserHandlerDelegate,RSConnectionHandlerDelegate> {

	IBOutlet RSBookingTableView         *dateTable;
	IBOutlet UIDatePicker               *datePicker;
	IBOutlet UIButton                   *doneButton;
    
	int                                 currentSelectedRowIndex;
	UILabel                             *startDateLabel, *endDateLabel;
	NSDate                              *startDate, *endDate;
	ResortSuiteAppDelegate              *appDelegate;
   
    NSIndexPath                         *pathForfirstCell;
    NSString                            *responseString;
    RSMyItineraryParser                 *parserItineraryObj;
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
//
-(void) loadMyGroupView;
-(void) fetchGroupItineraryForHotel: (NSString *) startdate EndDate:(NSString *) enddate withFolioId:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin;

-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
-(void) guestItineraryDataReceived:(id)parserModelData;
-(void) showErrorMessage:(id)parserModelData;
@end
