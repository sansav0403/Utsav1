//
//  RSMainViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 The first view that appears lauch of the application.
 *checks if the user is logged in
 *manages all the downl;oad for itinerary,account and group events
 *displays three button to give user quick access.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSMainScreenButton.h"
    #if !defined HOTEL_VERSION_TWO_BUTTONS
    #import "RSMGDateSelectionViewController.h"
    #endif
//changes for login screen
#import "LoginActionSheet.h"
#import "LogoutScreen.h"
@class ResortSuiteAppDelegate;
@class RSTableView;
@class Authentication;
@class RSMyAccountParser;
@class RSClubBillingHistoryParser;
@class DisplaySplashScreenViewController;

@class RSListViewNode;
@class RSListViewController;
@class RSMIDateSelectionViewController; //to be defined in both hotel and club app

//Enumaration for tab bar buttons
enum MainScreenButtons {
	MainScreen_Button1,
	
	#if !defined CLUB_VERSION_TWO_MYACCOUNT			//Condition for Club Version with 2 buttons (Static, My Account)
		MainScreen_Button2,							//Removing the My Itinerary button from Main Screen
	#endif
	
	#if !defined HOTEL_VERSION_TWO_BUTTONS			//Condition for Hotel Version with 2 buttons (Static, My Itinerary)
		MainScreen_Button3,							//Removing the My Group button from Main Screen
	#endif
	
	MainScreen_NoButtons,
};
//remove uiaction sheet delegate
@interface RSMainViewController : UIViewController <RSParserHandlerDelegate,RSConnectionHandlerDelegate
,UINavigationControllerDelegate,UIActionSheetDelegate,LogoutViewDelegate,LoginViewDelegate> {
	NSMutableArray* mainFieldArray;
	RSMainScreenButton* mainViewButttons[MainScreen_NoButtons];
	Authentication *popup;  //to be removed iwth custom actionsheet
    LoginActionSheet *LoginOptions;
	ResortSuiteAppDelegate *appDelegate;
    UINavigationController *loginNavigation;    // to present the login screen with navigationController



	RSMyItineraryModel *myGuestItinerary;
	RSMyItineraryParser *parserItineraryObj;
	
	BOOL isMyItinerary;						//Set YES for My Itineary section
	UIAlertView *offlineAlert;
	UIAlertView *signoutAlert;
	
	BOOL isRefresh;							//Set YES when Refresh button is clicked
    BOOL IsFromMIDateSelection;             // check if the guestitinerary is from date selection view
	BOOL IsFromMGDateSelection;	
	NSString *responseString;
	NSString *documentDirPath;
	
//	for hotel only remove
		NSString *folioid;
		NSString *guestpin;

//---------********************************************--------------------------
    //authentication flow are same in the hotel and club App.    
    NSString *emailAddress;
    NSString *password;
    NSString *customerId;
    NSString *customerGUID;
    NSString *startDate;
    NSString *endDate;
//---------********************************************--------------------------
	
	RSMyAccountParser *parserMyAccObj;
	
	BOOL isClubMyItinerary;					//Set YES for My Itinery section for Club
	BOOL isClubMyAccount;					//Set YES for My Account section for Club
	BOOL isMyHotelOrClub;					//Set YES for My Hotel OR My Club button
	
	DisplaySplashScreenViewController *splashVC;
	BOOL shouldLoadMyAccountView;	
	BOOL shouldLoadIntinerayView;
	
	BOOL isSignIn;
}

@property (nonatomic,retain) RSMyItineraryParser *parserItineraryObj ;
@property (nonatomic) BOOL isMyItinerary;
@property (nonatomic) BOOL isRefresh;
@property (nonatomic,copy) NSString *responseString;
@property (nonatomic,copy) NSString *documentDirPath;

    //for hotel only remove
	@property (nonatomic,retain) NSString *folioid;
	@property (nonatomic,retain) NSString *guestpin;

//---------********************************************--------------------------
//authentication flow are same in the hotel and club App. 
@property (nonatomic,copy) NSString *emailAddress;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *customerId;
@property (nonatomic,copy) NSString *customerGUID;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,copy) NSString *authorizationId;
@property (nonatomic,retain) RSMyAccountParser *parserMyAccObj;
//---------********************************************--------------------------
@property (nonatomic) BOOL isClubMyItinerary;
@property (nonatomic) BOOL isClubMyAccount;
@property (nonatomic) BOOL isMyHotelOrClub;

@property (nonatomic, retain) IBOutlet DisplaySplashScreenViewController *splashVC;

@property (nonatomic) BOOL isSignIn;


/*!
 @method		CallNextController
 @brief			Do event handling on top 3 buttons
 @details		It wil navigate the view to the desired controller
 @param			(id) button;
 @return		IBAction
 */
-(IBAction) CallNextController:(id) button;

/*!
 @method		firstButtonHandler
 @brief			Main page first button event handling
 @details		Loads the view with static button with the project tree specified
 @param			nil
 @return		void
 */
-(void) firstButtonHandler;

/*!
 @method		secondButtonHandler
 @brief			Main page second button event handling
 @details		
 @param			nil
 @return		void
 */
-(void) secondButtonHandler;

/*!
 @method		thirdButtonHandler
 @brief			Main page third button event handling
 @details		
 @param			nil
 @return		void
 */
-(void) thirdButtonHandler;

/*!
 @method		loadMyItineraryView
 @brief			Navigate the view to My Itineray controller
 @details		-
 @param			-
 @return		void
 */
-(void) loadMyItineraryView;

/*!
 @method		loadMyGroupView
 @brief			Navigate the view to My Group itinerary controller
 @details		-
 @param			-
 @return		void
 */
-(void) loadMyGroupView;

/*!
 @method		loadMyAccountView
 @brief			Navigate the view to My Account controller
 @details		-
 @param			-
 @return		void
 */
-(void) loadMyAccountView;


/*!
 @method		getItinerary
 @brief			Fetch the itinerary for Hotel
 @details		--
 @param			NSString PMSFolioId, NSString GuestPin
 @return		void
 */
-(void) getItinerary:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin;

/*!
 @method		authenticateCustomer
 @brief			Authentication for the customer
 @details		Customer authentication for getting itinerary for Club
 @param			NSString EmailAddress, NSString Password
 @return		void
 */
-(void) authenticateCustomer:(NSString *) EmailAddress Password:(NSString *) Password;

/*!
 @method		signInOutButtonAction
 @brief			Shows the diffrent alerts on Sign In or Sign Out buttons
 @details		--
 @param			id dender
 @return		void
 */
-(void)signInOutButtonAction:(id)sender;

/*!
 @method		showLoginPopup
 @brief			Shows the login popup 
 @details		--
 @param			nil
 @return		void
 */
-(void) showLoginPopup;

/*!
 @method		showOfflineAlert
 @brief			Shows the alert when there is no network
 @details		--
 @param			nil
 @return		void
 */
-(void) showOfflineAlert;

/*!
 @method		createMenuButtons
 @brief			Create 3 Menu Buttons for HOTEL as well CLUB versions
 @details		--
 @param			nil
 @return		void
 */
-(void) createMenuButtons;

#if defined(CLUB_VERSION)
/*!
 @method		fetchClubAccountsRequest
 @brief			Fetched Club Accounts details by sending the soap request
 @details		--
 @param			nil
 @return		void
 */
-(void) fetchClubAccountsRequest;
#endif
/*!
 @method		loadDateViewCotroller
 @brief			Loads the Date Selection View for Club My Itinerry
 @details		--
 @param			nil
 @return		void
 */
-(void) loadDateViewCotroller;


/*!
 @method		createFirstListViewNode
 @brief			It will create a root node for the list view controller
 @details		--
 @param			NSString treeName
 @return		RSListViewNode obj
*/ 
-(RSListViewNode *)createFirstListViewNode:(NSString*) treeName;

#if defined(CLUB_VERSION)
/*!
 @method		fetchGuestItineraryForClub
 @brief			Fetches the Guest Intinerary for CLUB version
 @details		--
 @param			startdate, enddate
 @return		void
 */ 
//-(void) fetchGuestItineraryForClub: (NSString *) startdate EndDate:(NSString *) enddate;
#endif	

/*!
 @method		showLogoutAlert
 @brief			Called when the logout button clicked
 @details		Shows an alert view to ask user whether to sign out
 @param			nil
 @return		void
 */ 
-(void) showLogoutAlert;


/*!
 @method		showUpdatedLoginButton
 @brief			Changing the right bar item's image depending on the user signed in or out
 @details		--
 @param			BOOL whether set when Signed In and UIViewController viewController
 @return		void
 */ 
-(void) showUpdatedLoginButton:(BOOL) isSignedIn onController:(UIViewController *) viewController;

/*!
 @method		fetchDataForRequestWithBody
 @brief			Method to fetch data from server
 @details		It takes request body string as parameter and generate the soap request
 @param			NSString request body
 @return		void
 */ 
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;

/*!
 @method		showErrorMessage
 @brief			Show Error Message if WS returns the error with the Result model class object
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) showErrorMessage:(id)parserModelData;

/*!
 @method		guestItineraryDataReceived
 @brief			Processes the data received of type Guest Itinerary
 @details		--
 @param			id parserModelData
 @return		void
 */ 
//-(void) guestItineraryDataReceived:(id)parserModelData;

//---------********************************************--------------------------
//authentication flow are same in the hotel and club App.

/*!
 @method		authenticationSuccess
 @brief			Processes the data received of type Customer Authentication
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) authenticationSuccess:(id) parserModelData;

#if defined(CLUB_VERSION)

/*!
 @method		clubAccountsDataReceived
 @brief			Processes the data received of type Customer Accounts
 @details		--
 @param			id parserModelData
 @return		void
 */ 
-(void) clubAccountsDataReceived:(id) parserModelData;
#endif
//-------------********************--------------------------------
/*!
 @method		writeToFile
 @brief			Method writes the content at the specified file location in Doc Directory 
 @details		--
 @param			NSString filePath, NSString fileContent
 @return		void
 */ 
-(void) writeToFile:(NSString *) filePath contents:(NSString *) fileContent;

#if defined(HOTEL_VERSION)

/*!
 @method		loadMyGroupDateSelectionView
 @brief			load MY Group date selection view
 @details		--
 @param			
 @return		void
 */
-(void)loadMyGroupDateSelectionView; 
-(void)removeSplashScreen;
#endif
@end
