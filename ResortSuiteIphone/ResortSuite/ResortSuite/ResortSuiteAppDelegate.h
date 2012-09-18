//
//  ResortSuiteAppDelegate.h
//  ResortSuite
//
//  Created by Cybage on 26/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMyItineraryParser.h"
#import "RSMyItineraryModel.h"
#import "Reachability.h"

#import "RSMyAccountParser.h"
#import "RSClubStatementParser.h"
#import "RSClubBillingHistoryParser.h"
#import "Loading.h"

#import "EndPointConfiguration.h"
//Enumaration for tab bar buttons
enum TabBarTags {
	HOME_TAB,
	MY_HOTEL_CLUB_TAB,
	#if !defined CLUB_VERSION_TWO_MYACCOUNT   		//Condition for Club Version with 2 buttons (Static, My Account)
		MY_ITINERARY_TAB,						//Removing the My Itinerary Tab from Tab Bar		
    #endif
    #if !defined HOTEL_VERSION_TWO_BUTTONS
	MY_GROUP_ACCOUNT_TAB,
    #endif
	BOOKINGS_TAB
};



@class RSMainViewController;
@class RSBookingsMainVC;
@class RSGolfLocationsParser;
@class RSSpaLocationParser;


@interface ResortSuiteAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,endPointConfigurationDelegate> {

	RSMyItineraryParser                 *myItineraryParser;
	Reachability                        *internetReachable;
	BOOL                                isLoggedIn;					//Set YES after successful login 
	BOOL                                isContactUsEnable;				//Set YES when Contact us button needed to be enabled
	RSMainViewController                *mainVC;
	int                                 currentAccountID;

	Loading                             *activityIndicator;
	
	//#if defined(HOTEL_VERSION)
		NSString                        *pmsFolioId;
		NSString                        *guestPin;
	//#elif defined(CLUB_VERSION)
		NSString                        *emailAddress;
		NSString                        *password;
	//#endif	
	
	RSMyAccountParser                   *myAccParser;
	
	RSClubStatementParser               *clubStatementParser;
	RSClubBillingHistoryParser          *clubBillingHistoryParser;
	
	int                                 prevSelectedIndex;
	int                                 presentSelectedTab; //to keep keep track of the selected tab
	//Bookings
	RSBookingsMainVC                    *bookingsMainVC;
	RSGolfLocationsParser               *golfLocationsParser;	
	NSMutableArray                      *bookingLocationsArray;
	
	RSSpaLocationParser                 *spaLocationsParser;
    
    int                                 bookingType;
    
    EndPointConfiguration *endPointConfiguration;   //one time intialization in app did become active
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) RSMyItineraryParser *myItineraryParser;
@property (nonatomic) BOOL isLoggedIn;
@property (nonatomic) int currentAccountID;
@property (nonatomic) int prevSelectedIndex;
@property (nonatomic) int presentSelectedTab;   //to keep keep track of the selected tab

@property (nonatomic) BOOL isContactUsEnable;
@property (nonatomic, getter=isConnectedToInternet) BOOL connectedToInternet;
@property (nonatomic,retain) RSMainViewController *mainVC;

@property (nonatomic,retain) Loading *activityIndicator;

@property (nonatomic, retain) RSMyAccountParser *myAccParser;
@property (nonatomic, retain) RSClubStatementParser *clubStatementParser;
@property (nonatomic, retain) RSClubBillingHistoryParser *clubBillingHistoryParser;


//#if defined(HOTEL_VERSION)
	@property (nonatomic,retain) NSString *pmsFolioId;
	@property (nonatomic,retain) NSString *guestPin;
//#elif defined(CLUB_VERSION)
	@property (nonatomic,retain) NSString *emailAddress;
	@property (nonatomic,retain) NSString *password;
//#endif

//@property (nonatomic,retain) RSBookingsMainVC *bookingsMainVC;
@property (nonatomic, retain) RSGolfLocationsParser *golfLocationsParser;
@property (nonatomic, retain) RSSpaLocationParser *spaLocationsParser;

@property (nonatomic, retain) NSMutableArray *bookingLocationsArray;

@property (nonatomic, assign)  int bookingType;
@property (nonatomic, assign) EndPointConfiguration *endPointConfiguration;//so that to acces from mainvc,//assign as single instance throughout the application.
/*!
 @method		setCurrentScreenImage
 @brief			Set background image with overlay for header image
 @details		This is a class method / +method
 @param			(NSString*) imageName, (UIViewController*) currentController
 @return		void
 */
+(void) setCurrentScreenImage:(NSString*) imageName controller:(UIViewController*) currentController;
/*!
 @method		setCurrentScreenImageWithWhiteOverlay
 @brief			Set background image with white overlay
 @details		This is a class method / +method
 @param			(NSString*) imageName, (UIViewController*) currentController
 @return		void
 */
+(void) setBackGroundImageForController:(UIViewController*) currentController;
/*!
 @method		setCurrentScreenImageWithWhiteOverlay
 @brief			Set background image with white overlay
 @details		This is a class method / +method
 @param			(NSString*) imageName, (UIViewController*) currentController
 @return		void
 */
+(void) setCurrentScreenImageWithWhiteOverlay:(NSString*) imageName controller:(UIViewController*) currentController;

/*!
 @method		setContactUsIcon
 @brief			Set app delegate flag to set contactUsIcon flag
 @details		This is a class method / +method
 @param			(BOOL) isEnable;
 @return		void
 */
+(void) setContactUsIcon:(BOOL) isEnable;

/*!
 @method		getContactUsIcon
 @brief			Get app delegate flag value of contactUsIcon flag
 @details		This is a class method / +method
 @param			-
 @return		BOOL
 */
+(BOOL) getContactUsIcon;

/*!
 @method		changeNavigationBarTitleFormat
 @brief			Change the title format of navigation bar
 @details		This is a class method / +method. Using this function we can chnage the format for the title of navigation bar, using this function we can show large title using this function
 @param			(UIViewController*) currentController, (NSString*)title, (CGFloat*)size
 @return		(void)
 */
+(void) changeNavigationBarTitleFormat:(UIViewController*) currentController text:(NSString*)title fontSize:(CGFloat*)size;

/*!
 @method		getStoredValuesFromKeychain
 @brief			Get the stored values from the keychain
 @details		--
 @param			nil
 @return		(void)
 */
-(void) getStoredValuesFromKeychain;

/*!
 @method		loadStaticControllerOnTabBar
 @brief			Loads the static controller on the tab bar with the parameters provided
 @details		--
 @param			UITabBarController tabBarController,int index, NSString title,NSString icon, NSString projectTree;
 @return		(void)
 */
-(void) loadStaticControllerOnTabBar:(UITabBarController *) tabBarController 
							forIndex:(int) atIndex 
						   withTitle:(NSString *) title
							withIcon:(NSString *) icon 
					 withProjectTree:(NSString *) projectTree;
/*!
 @method		createnavControllerWithRootController
 @brief			Creates the navigation controller and initialize with rootViewController
 @details		remove the object at the tag index in the tabController array and inserts the new navController
 @param			tabTitle, TabImage, tag
 @return		(void)
 */
-(void)createNavControllerWithRootController:(UIViewController *)viewController withTabTitle:(NSString *)tabTitle
                                TabImageName:(NSString *)TabImage tabTag:(int)tag;

/*!
 @method		releaseAllParserObjects
 @brief			releaseAllParserObjects
 @details		
 @param			
 @return		(void)
 */
+(void) releaseAllParserObjects;

+(void) allocateAllParserObjects;

@end
