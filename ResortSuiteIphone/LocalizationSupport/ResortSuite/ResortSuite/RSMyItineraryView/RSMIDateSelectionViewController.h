//
//  RSMIDateSelectionViewController.h
//  ResortSuite
//
//  Created by Cybage on 17/08/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request to view all the event
 * in all future bookings
 *or the event in the selected date range
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
@class RSTableView;
@class ResortSuiteAppDelegate;

enum TableSection {
	AllFurtherBookings,
	SelectDates,
	NoOfSections
};

@interface RSMIDateSelectionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>{
	NSMutableArray              *mainFieldArray;
	RSTableView                 *mainTableView;
	ResortSuiteAppDelegate      *appDelegate;
    
    RSMyItineraryParser         *parserItineraryObj;    //itinerary parser obj
    NSString                    *responseString;
}
@property (nonatomic,copy) NSString *responseString;
@property (nonatomic,retain) RSMyItineraryParser *parserItineraryObj;
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
