//
//  RSMGDateSelectionViewController.h
//  ResortSuite
//
//  Created by Cybage on 12/19/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
@class RSTableView;
@class ResortSuiteAppDelegate;



enum MGTableSection {
    MGAllFurtherBookings,
    MGSelectDates,
    MGNoOfSections
};
@interface RSMGDateSelectionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>{
	NSMutableArray              *mainFieldArray;
	RSTableView                 *mainTableView;

	ResortSuiteAppDelegate      *appDelegate;

    NSString                    *responseString;
    RSMyItineraryParser         *parserItineraryObj;
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
-(void) loadMyGroupView;
-(void) fetchGroupItineraryForHotel: (NSString *) startdate EndDate:(NSString *) enddate withFolioId:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin;

-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
-(void) guestItineraryDataReceived:(id)parserModelData;
-(void) showErrorMessage:(id)parserModelData;

@end
