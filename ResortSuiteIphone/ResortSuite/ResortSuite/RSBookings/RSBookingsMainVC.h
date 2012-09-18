//
//  RSGolfBookingsMainVC.h
//  ResortSuite
//
//  Created by Cybage on 16/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 The first view that appears on book tab.
 *checks if the user is logged in
 *dowloads the golf and spa locations and saves them in appdelegate object.
 *displays the list of the available list in the TableView
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "LoginActionSheet.h"
@class RSBookingTableView;
@class ResortSuiteAppDelegate;
@class Authentication;

@class RSGolfLocationsParser;
@class RSGolfLocations;

@class RSSpaLocations;
@class RSSpaLocationParser;


@interface RSBookingsMainVC :  UIViewController<RSParserHandlerDelegate,RSConnectionHandlerDelegate, UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource,LoginViewDelegate>
{
	NSMutableArray              *mainFieldArray;
	RSBookingTableView          *mainTableView;

	ResortSuiteAppDelegate      *appDelegate;
	
	Authentication              *popup;  //to be removed iwth custom actionsheet
    LoginActionSheet            *LoginOptions;
	UIAlertView                 *signoutAlert;
	
	RSGolfLocations             *golfLocations;
	RSGolfLocationsParser       *golfLocationsParser;	
	
	RSSpaLocations              *spaLocations;
	RSSpaLocationParser         *spaLocationsParser;
	
    UINavigationController      *loginNavigation;    // to present the login screen with navigationController
    
	NSString                    *emailAddress;
	NSString                    *password;
	NSString                    *customerId;
	NSString                    *customerGUID;
//#if defined(HOTEL_VERSION)
//    NSString *folioid;
//    NSString *guestpin;
//#endif
	
	RSMyItineraryParser         *parserItineraryObj;
	
	BOOL                        isGolfLocation;		//Set to YES when there are Golf locations > 0
	BOOL                        isLoginPopupAppeared;		//Set to YES when there are Golf locations > 0
}

@property (nonatomic,retain) RSGolfLocationsParser *golfLocationsParser;
@property (nonatomic,retain) RSSpaLocationParser *spaLocationsParser;

@property (nonatomic,retain) NSString *emailAddress;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *customerId;
@property (nonatomic,retain) NSString *customerGUID;

@property (nonatomic,retain) RSMyItineraryParser *parserItineraryObj ;
@property (nonatomic) BOOL isGolfLocation;


/*!
 @method		loadBookingsMainView
 @brief			Navigate the view to Bookings main view controller
 @details		-
 @param			-
 @return		void
 */
-(void) loadBookingsMainView;
/*!
 @method		authenticateCustomer
 @brief			authenticate Customer based upon the email address and password
 @details		--
 @param			(NSString *) EmailAddress,(NSString *) Password
 @return		void
 */ 
-(void) authenticateCustomer:(NSString *) EmailAddress Password:(NSString *) Password;
/*!
 @method		fetchDataForRequestWithBody
 @brief			fetch Data For Request With soap Body
 @details		--
 @param			(NSString *) bodyString
 @return		void
 */ 
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
/*!
 @method		fetchGolfLocationsRequest
 @brief			fetch Golf Locations Request
 @details		create soap body to fetch golf location
 @param			
 @return		void
 */ 
-(void) fetchGolfLocationsRequest;
/*!
 @method		fetchSpaLocationsRequest
 @brief			fetch Spa Locations Request
 @details		--
 @param			
 @return		void
 */ 
-(void) fetchSpaLocationsRequest;
/*!
 @method		authenticationSuccess
 @brief			process the recieved data on successful authentication
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) authenticationSuccess:(id) parserModelData;
/*!
 @method		golfBookingsDataReceived
 @brief			Processes the data received and add static cell in the table if data exists
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) golfBookingsDataReceived:(id) parserModelData;
/*!
 @method		clubAccountsDataReceived
 @brief			Processes the data received and add them to the table
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) spaBookingsDataReceived:(id) parserModelData;
/*!
 @method		showErrorMessage
 @brief			show Error Message
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) showErrorMessage:(id)parserModelData;
/*!
 @method		showLoginPopup
 @brief			show Login Popup
 @details		show Login Popup if the user is not logged in
 @param			id parserModelData
 @return		void
 */ 
-(void) showLoginPopup;

@end
