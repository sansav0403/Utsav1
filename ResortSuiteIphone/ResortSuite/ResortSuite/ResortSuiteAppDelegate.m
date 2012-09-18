//
//  ResortSuiteAppDelegate.m
//  ResortSuite
//
//  Created by Cybage on 26/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "ResortSuiteAppDelegate.h"
#import "RSMIMainScreenViewController.h"
#import "RSMainViewController.h"
#import "RSListAccountsViewController.h"
#import "RSListViewNode.h"
#import "RSListViewController.h"
#import "RSNavigationController.h"
#import "RSMIDateSelectionViewController.h"
#import "RSMGDateSelectionViewController.h"
//Booking
#import "RSBookingsMainVC.h"
#import "RSGolfLocationsParser.h"
#import "RSSpaLocationParser.h"

@implementation ResortSuiteAppDelegate


@synthesize window=_window;
@synthesize myItineraryParser;
@synthesize isLoggedIn;
@synthesize currentAccountID;
@synthesize prevSelectedIndex;
@synthesize presentSelectedTab;
@synthesize connectedToInternet;
@synthesize mainVC;
@synthesize isContactUsEnable;
@synthesize activityIndicator;

//#if defined(HOTEL_VERSION)
	@synthesize pmsFolioId;
	@synthesize guestPin;
//#elif defined(CLUB_VERSION)
	@synthesize emailAddress;
	@synthesize password;
//#endif

@synthesize myAccParser;
@synthesize clubStatementParser;
@synthesize clubBillingHistoryParser;
@synthesize golfLocationsParser;
@synthesize spaLocationsParser;
@synthesize bookingLocationsArray;

@synthesize tabBarController=_tabBarController;

@synthesize bookingType;
@synthesize endPointConfiguration;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window

    self.window.rootViewController = self.tabBarController;
	self.tabBarController.delegate = self;
    [self.window makeKeyAndVisible];
	[application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

    endPointConfiguration = [[EndPointConfiguration alloc]init];    //one time intialization/start always in appp did become active
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	

    self.isLoggedIn = [prefs boolForKey:LoggedInKey];
	if (!self.activityIndicator) 
	{
        Loading *loadingActivity = [[Loading alloc] init];
		self.activityIndicator = loadingActivity;
        [loadingActivity release];
	}

	[ResortSuiteAppDelegate releaseAllParserObjects];
	[ResortSuiteAppDelegate allocateAllParserObjects];
    
   //Checking Network Reachability by adding Notification Listener and starting the notifier to check the status.
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(checkNetworkStatus:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];

    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
	
	NetworkStatus status = [internetReachable currentReachabilityStatus];
	
	if(status == NotReachable) {
		self.connectedToInternet = NO;
	} else {
		self.connectedToInternet = YES;
	}
	self.isContactUsEnable = YES;
	self.prevSelectedIndex = 0;
    
	// reload all the image and title of all the screens
    //run a loop through all the veiw controllers and change their
    int tabcontrollerCount = [self.tabBarController.viewControllers count];
    for (int i = 0; i < tabcontrollerCount; i++) {
        switch (i) {
            case HOME_TAB:
                {
                    [[[self.tabBarController viewControllers] objectAtIndex:HOME_TAB] tabBarItem].title = RSHomeTabTitle;
                    [[[self.tabBarController viewControllers] objectAtIndex:HOME_TAB] tabBarItem].image = [UIImage  imageNamed:RSHomeTabIcon];   
                }                
                break;
            case MY_HOTEL_CLUB_TAB:
            {
#if defined(HOTEL_VERSION)
                [[[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB] tabBarItem].title = RSMyHotelTabTitle;
#elif defined(CLUB_VERSION)
                [[[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB] tabBarItem].title = RSMyClubTabTitle;
#endif
                [[[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB] tabBarItem].image = [UIImage  imageNamed:RSHotelTabIcon];
            }                
                break;
                 #if !defined CLUB_VERSION_TWO_MYACCOUNT
            case MY_ITINERARY_TAB:
            {
                #if defined(HOTEL_VERSION)
                [[[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB] tabBarItem].title = RSHotelSelfTabTitle;
                #elif defined(CLUB_VERSION)
                [[[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB] tabBarItem].title = RSClubItineraryTabTitle;
                #endif
                
                [[[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB] tabBarItem].image = [UIImage  imageNamed:RSSelfTabIcon];
                #if defined ALL_VERSIONS_SECOND_STATIC_MYACCOUNT
                    [[[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB] tabBarItem].title = RSStaticTabTitle;
                    [[[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB] tabBarItem].image = [UIImage  imageNamed:RSStaticTabIcon];
                #endif

            }      
                #endif
                break;
                #if !defined HOTEL_VERSION_TWO_BUTTONS
            case MY_GROUP_ACCOUNT_TAB:
            {
#if defined(HOTEL_VERSION)
                #if !defined HOTEL_VERSION_TWO_BUTTONS
                [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].title = RSHotelMyGroupTabTitle;
                #endif
#elif defined(CLUB_VERSION)
                [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].title = RSClubMyAccountTabTitle;
#endif
                [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].image = [UIImage  imageNamed:RSGroupTabIcon];
#if defined (ALL_VERSIONS_SECOND_STATIC)//new flow
                [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].title = RSStaticTabTitle;
               		
                [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].image = [UIImage  imageNamed:RSStaticTabIcon];
#endif
            }        
                #endif
                break;
            case BOOKINGS_TAB:
            {
                [[[self.tabBarController viewControllers] objectAtIndex:BOOKINGS_TAB] tabBarItem].title = RSBookingTabTitle;
                [[[self.tabBarController viewControllers] objectAtIndex:BOOKINGS_TAB] tabBarItem].image = [UIImage  imageNamed:RSBookTabIcon];
            }                
                break;
                
            default:
                break;
        }
    }
    
    return YES;
}

+(void) releaseAllParserObjects
{
    ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];

    if (appDelegate.myItineraryParser) {
        appDelegate.myItineraryParser = nil;
	}
	
	if (appDelegate.myAccParser) {
        appDelegate.myAccParser = nil;
	}
	
	if (appDelegate.clubStatementParser) {
        appDelegate.clubStatementParser = nil;
	}
	
	if (appDelegate.clubBillingHistoryParser) {
        appDelegate.clubBillingHistoryParser = nil;
	}
    
	if (appDelegate.golfLocationsParser) {
        appDelegate.golfLocationsParser = nil;
	}
	
	if (appDelegate.spaLocationsParser) {
        appDelegate.spaLocationsParser = nil;
	}
}


+(void) allocateAllParserObjects
{
    //these parser are allocated here as they are used to get parsed data from appdelegae directly,exits throughtout the application
    ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RSMyItineraryParser * rsMyItineraryParser = [[RSMyItineraryParser alloc] init];
    appDelegate.myItineraryParser = rsMyItineraryParser;
    [rsMyItineraryParser release];
	
    RSMyAccountParser *rsMyAccountParserObj = [[RSMyAccountParser alloc] init]; 
	appDelegate.myAccParser = rsMyAccountParserObj;
    [rsMyAccountParserObj release];
    
	RSClubStatementParser *rsClubStatementParserObj = [[RSClubStatementParser alloc] init];
	appDelegate.clubStatementParser = rsClubStatementParserObj;
	[rsClubStatementParserObj release];
	
	RSClubBillingHistoryParser *rsClubBillingHistoryParserObj = [[RSClubBillingHistoryParser alloc] init];
    appDelegate.clubBillingHistoryParser = rsClubBillingHistoryParserObj;
    [rsClubBillingHistoryParserObj release];
    
	RSGolfLocationsParser *rsGolfLocationsParserObj = [[RSGolfLocationsParser alloc] init];
    appDelegate.golfLocationsParser = rsGolfLocationsParserObj;
    [rsGolfLocationsParserObj release];
	
    RSSpaLocationParser *rsSpaLocationParserObj = [[RSSpaLocationParser alloc] init];
	appDelegate.spaLocationsParser = rsSpaLocationParserObj;
    [rsSpaLocationParserObj release];

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    /*
        get endpoint configuration file
        parse the same and match with the hardcoded vesion in the App
        get the end point url and fetch service from it
     */
    NSLog(@"applicationDidBecomeActive");
    [endPointConfiguration  setDelegate:self];
    [endPointConfiguration setWebConfiguration];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    //clear the prefs if the application is being terminated
    NSLog(@"application terminated----------------------------------");
    self.isLoggedIn = NO;
    //same for hotel and club
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // saving a email address and password
    [prefs setObject:@"" forKey:EmailAddressKey];
    [prefs setObject:@"" forKey:PasswordKey];
    [prefs setObject:@"" forKey:CustomerIdKey];
    [prefs setObject:@"" forKey:CustomerGUIDKey];
    [prefs setObject:@"" forKey:@"StartDate"];
    [prefs setObject:@"" forKey:@"EndDate"];
    [prefs setObject:@"" forKey:AuthorizationIdKey];
    
    [prefs setBool:self.isLoggedIn forKey:LoggedInKey];
    [prefs synchronize];

}

//Set Image of every screen by passing image name as a parameter throuogh each controller
+(void) setCurrentScreenImage:(NSString*) imageName controller:(UIViewController*) currentController
{
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	currentController.navigationItem.backBarButtonItem = item;
	[item release];
	
	UIImageView *imageViewBackgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Height)];
	imageViewBackgroud.image = [UIImage imageNamed:Application_BackgroundScreen];
	[currentController.view addSubview:imageViewBackgroud];
	[imageViewBackgroud release];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(7.5,55, ScreenImageView_Width,HeaderImageHeight)];
	imageView.image = [UIImage imageNamed:imageName];
	[currentController.view addSubview:imageView];
	[imageView release];

	UIImageView *imageViewBackgroudMask = [[UIImageView alloc] initWithFrame:CGRectMake(0,44, Screen_Width, Screen_Height-80)];
	imageViewBackgroudMask.image = [UIImage imageNamed:ScreenBackgroudImageMAsk];
	[currentController.view addSubview:imageViewBackgroudMask];
	[imageViewBackgroudMask release];
}
+(void) setBackGroundImageForController:(UIViewController*) currentController
{
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	currentController.navigationItem.backBarButtonItem = item;
	[item release];
	
	UIImageView *imageViewBackgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Height)];
	imageViewBackgroud.image = [UIImage imageNamed:Application_BackgroundScreen];
	[currentController.view addSubview:imageViewBackgroud];
	[imageViewBackgroud release];
	
    
	UIImageView *imageViewBackgroudMask = [[UIImageView alloc] initWithFrame:CGRectMake(0,44, Screen_Width, Screen_Height-80)];
	imageViewBackgroudMask.image = [UIImage imageNamed:ScreenWhiteOverLay];
	[currentController.view addSubview:imageViewBackgroudMask];
	[imageViewBackgroudMask release];
}
//Set Image of every screen by passing image name as a parameter throuogh each controller
+(void) setCurrentScreenImageWithWhiteOverlay:(NSString*) imageName controller:(UIViewController*) currentController
{
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	currentController.navigationItem.backBarButtonItem = item;
	[item release];
	
	UIImageView *imageViewBackgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Height)];
	imageViewBackgroud.image = [UIImage imageNamed:Application_BackgroundScreen];
	[currentController.view addSubview:imageViewBackgroud];
	[imageViewBackgroud release];

	
	UIImageView *imageViewBackgroudOverLay = [[UIImageView alloc] initWithFrame:CGRectMake(0,NavigationBar_Height, Screen_Width, Screen_Height-80)];
	imageViewBackgroudOverLay.image = [UIImage imageNamed:ScreenWhiteOverLay];
	[currentController.view addSubview:imageViewBackgroudOverLay];
	[imageViewBackgroudOverLay release];
    
}

//Set Contact Us icon on the pages
+(void) setContactUsIcon:(BOOL) isEnable
{
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(isEnable) 
	{
		appDelegate.isContactUsEnable = YES;
	}
	else
	{
		appDelegate.isContactUsEnable = NO;
	}
}

//Get Contact Us icon on the pages
+(BOOL) getContactUsIcon
{
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate.isContactUsEnable;
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
	[myItineraryParser release];
	[mainVC release];
	[activityIndicator release];

	//#if defined(HOTEL_VERSION)
		[pmsFolioId release];
		[guestPin release];
	//#elif defined(CLUB_VERSION)
		[emailAddress release];
		[password release];
	//#endif	
	
	[myAccParser release];
	[clubStatementParser release];
	
	[golfLocationsParser release];
	[spaLocationsParser release];
    
    [clubBillingHistoryParser release];
	[endPointConfiguration release];    
    [super dealloc];
}

#pragma TabBarController Delegate Methods


// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"flow through tab");
	UINavigationController* navCntrl = nil;

	if ([viewController isKindOfClass:[UINavigationController class]] ) {
		navCntrl = (UINavigationController*) viewController;
        // when home tab - reloading the tab for both hotel and club
        if (navCntrl.tabBarItem.tag == HOME_TAB)    //for all scenario or targets
        {
            //----
             [navCntrl popToRootViewControllerAnimated:YES];
            //----
//            RSMainViewController *mainVCNew = [[RSMainViewController alloc]init];
//#if defined(HOTEL_VERSION)
//            mainVCNew.navigationItem.title = Hotel_Application_Title;
//#elif defined(CLUB_VERSION)	
//            mainVCNew.navigationItem.title = Club_Application_Title;
//#endif
//            [self createNavControllerWithRootController:mainVCNew withTabTitle:RSHomeTabTitle TabImageName:RSHomeTabIcon tabTag:HOME_TAB];
//            [mainVCNew release];
            
        }
		//Loads the Static Controller like My Hotel/My Club
		if (navCntrl.tabBarItem.tag == MY_HOTEL_CLUB_TAB) {
			#if defined(HOTEL_VERSION)
			[self loadStaticControllerOnTabBar:tabBarController 
									  forIndex:MY_HOTEL_CLUB_TAB 
									 withTitle:RSMyHotelTabTitle     //tab tile
									  withIcon:RSHotelTabIcon   //tab image
							   withProjectTree:@"ProjectTree"];
			#elif defined(CLUB_VERSION)
			[self loadStaticControllerOnTabBar:tabBarController 
									  forIndex:MY_HOTEL_CLUB_TAB 
									 withTitle:RSMyClubTabTitle 
									  withIcon:RSHotelTabIcon 
							   withProjectTree:@"ProjectTree"];
			#endif	
			
//			mainVC.isMyHotelOrClub = YES;
//			mainVC.isClubMyItinerary = NO;
//			mainVC.isClubMyAccount = NO;			
		}
		else {
//			mainVC.isMyHotelOrClub = NO;
		}

		//Save the last tab bar selected index for further use  //why to use when each tab is to reloaded
//		if (navCntrl.tabBarItem.tag == MY_HOTEL_CLUB_TAB || 
//			navCntrl.tabBarItem.tag == HOME_TAB) {
//			prevSelectedIndex = self.tabBarController.selectedIndex;
//		}		
		
#if defined CLUB_VERSION
		//------------------ Loading list view for multiple Accounts ----- this part may not be needed-as WS is to be hit every time----------------------//
		if([self.myAccParser.clubAccounts.accounts count] > oneAccount && navCntrl.tabBarItem.tag == MY_GROUP_ACCOUNT_TAB)
		{
			UIViewController *listVC = [[RSListAccountsViewController alloc] init];
            
            [self createNavControllerWithRootController:listVC withTabTitle:RSClubMyAccountTabTitle TabImageName:RSGroupTabIcon tabTag:MY_GROUP_ACCOUNT_TAB];
            self.tabBarController.selectedIndex = MY_GROUP_ACCOUNT_TAB;
            [listVC release];
		}		
#endif
        
		//--------------- Check for Two or Three buttons behaviour ----------------------------------//
        
#if defined ALL_VERSIONS_SECOND_STATIC_MYACCOUNT
        if (navCntrl.tabBarItem.tag == MY_ITINERARY_TAB) 
		{
            [self loadStaticControllerOnTabBar:tabBarController 
                                      forIndex:MY_ITINERARY_TAB 
                                     withTitle:RSStaticTabTitle 
                                      withIcon:RSStaticTabIcon 
                               withProjectTree:@"ProjectTreeSecondStatic"];
        }
#endif

        
		#if defined CLUB_VERSION_TWO_MYACCOUNT || defined ALL_VERSIONS_SECOND_STATIC_MYACCOUNT 
		if (navCntrl.tabBarItem.tag == MY_GROUP_ACCOUNT_TAB) 
        #elif defined HOTEL_VERSION_TWO_BUTTONS
        if (navCntrl.tabBarItem.tag == MY_ITINERARY_TAB) 
        #else
            
		if (navCntrl.tabBarItem.tag == MY_ITINERARY_TAB || navCntrl.tabBarItem.tag == MY_GROUP_ACCOUNT_TAB) 
		#endif
		{
			if (self.isLoggedIn == YES)
			{
				[self getStoredValuesFromKeychain];						
				
				#if !defined CLUB_VERSION_TWO_MYACCOUNT
				if(navCntrl.tabBarItem.tag == MY_ITINERARY_TAB)
				{
//					mainVC.isClubMyItinerary = YES;		
//					mainVC.isClubMyAccount = NO;
					if (self.myItineraryParser.guestItinerary)
					{
						#if defined(HOTEL_VERSION)
                        // load the date selection screen instead
                        //call this function to create seperate navigation controller
                        RSMIDateSelectionViewController *MIDateviewCntrl = [[RSMIDateSelectionViewController alloc] init];
                        [self createNavControllerWithRootController:MIDateviewCntrl withTabTitle:RSHotelSelfTabTitle TabImageName:RSSelfTabIcon tabTag:MY_ITINERARY_TAB];
                        self.tabBarController.selectedIndex = MY_ITINERARY_TAB;
                        [MIDateviewCntrl release];

						#elif defined(CLUB_VERSION)
						
						UIViewController *viewCntrl;
						
						if (self.connectedToInternet) {
							//Load Date View Controller if connected to the Internet
							viewCntrl = [[RSMIDateSelectionViewController alloc] init];					
						}
						else {
							//Load My Itinerary View Controller in Offline Mode
							viewCntrl = [[RSMIMainScreenViewController alloc] init];					
						}		
                        
                        [self createNavControllerWithRootController:viewCntrl withTabTitle:RSClubItineraryTabTitle TabImageName:RSSelfTabIcon tabTag:MY_ITINERARY_TAB];
                        self.tabBarController.selectedIndex = MY_ITINERARY_TAB;
                        [viewCntrl release];

						
						#endif
					}
					#if defined(HOTEL_VERSION)
					else
					{
//						[navCntrl.view addSubview:self.activityIndicator.view];
//						[self.activityIndicator.activity startAnimating];
						//[mainVC getItinerary:mainVC.folioid GuestPin:mainVC.guestpin];
                        //dont need to be called as now we will fetch itinerary in the dateselection screen
					}					
					#elif defined(CLUB_VERSION)
					else					
					{
						if (mainVC.customerId && mainVC.customerGUID) { //ie is loged in
							//[mainVC loadDateViewCotroller];   //XX if from, tab reload tab
                           RSMIDateSelectionViewController* viewCntrl = [[RSMIDateSelectionViewController alloc] init];                         
                        [self createNavControllerWithRootController:viewCntrl withTabTitle:RSClubItineraryTabTitle TabImageName:RSSelfTabIcon tabTag:MY_ITINERARY_TAB];
                            self.tabBarController.selectedIndex = MY_ITINERARY_TAB;
                        [viewCntrl release];

						}
						else
						{							
							[navCntrl.view addSubview:self.activityIndicator.view];
							[self.activityIndicator.activity startAnimating];

							[mainVC authenticateCustomer:mainVC.emailAddress Password:mainVC.password];
						}						
					}
					#endif
				}
				else 
				#endif			
				
				#if defined (HOTEL_VERSION) 
					#if defined (ALL_VERSIONS_SECOND_STATIC)
					{
						[self loadStaticControllerOnTabBar:tabBarController 
												  forIndex:MY_GROUP_ACCOUNT_TAB 
												 withTitle:RSStaticTabTitle 
												  withIcon:RSStaticTabIcon 
										   withProjectTree:@"ProjectTreeSecondStatic"];
					}					
					#else 
                {
                    #if !defined HOTEL_VERSION_TWO_BUTTONS  //new flow
					if (self.myItineraryParser.guestItinerary) {    //this need to be checked in the date selection
                        //flow for group(hotel) while logged in     //also remove if else
                        //just show the tab controller it can handle itself the further flow
						//[mainVC loadMyGroupView];

                        RSMGDateSelectionViewController *GRDateviewCntrl = [[RSMGDateSelectionViewController alloc] init];
                        [self createNavControllerWithRootController:GRDateviewCntrl withTabTitle:RSHotelMyGroupTabTitle TabImageName:RSGroupTabIcon tabTag:MY_GROUP_ACCOUNT_TAB];
                        self.tabBarController.selectedIndex = MY_GROUP_ACCOUNT_TAB;
                        [GRDateviewCntrl release];
					}
					else {
//						[navCntrl.view addSubview:self.activityIndicator.view];
//						[self.activityIndicator.activity startAnimating];

						//[mainVC getItinerary:mainVC.folioid GuestPin:mainVC.guestpin];
                        //dont need to be called as now we will fetch itinerary in the dateselection screen
                        RSMGDateSelectionViewController *GRDateviewCntrl = [[RSMGDateSelectionViewController alloc] init];
                        [self createNavControllerWithRootController:GRDateviewCntrl withTabTitle:RSHotelMyGroupTabTitle TabImageName:RSGroupTabIcon tabTag:MY_GROUP_ACCOUNT_TAB];
                        self.tabBarController.selectedIndex = MY_GROUP_ACCOUNT_TAB;
                        [GRDateviewCntrl release];

					}	
					#endif
                }
                #endif
				
				#elif defined(CLUB_VERSION)
				{
					#if defined (ALL_VERSIONS_SECOND_STATIC)
					{
						[self loadStaticControllerOnTabBar:tabBarController 
												  forIndex:MY_GROUP_ACCOUNT_TAB 
												 withTitle:RSStaticTabTitle 
												  withIcon:RSStaticTabIcon 
										   withProjectTree:@"ProjectTreeSecondStatic"];
					}					
					#else					
					

                    [navCntrl.view addSubview:self.activityIndicator.view];
                    [self.activityIndicator.activity startAnimating];
                        //set the present selected tab
                    presentSelectedTab = MY_GROUP_ACCOUNT_TAB;
                    [self.mainVC fetchClubAccountsRequest];
                    #endif
				}
				#endif					
			}
			else    //for not logged in //change:use properties to identify if the mainvc flow is from tab or button
			{
				#if !defined CLUB_VERSION_TWO_MYACCOUNT
				if (navCntrl.tabBarItem.tag == MY_ITINERARY_TAB) 
				{

					presentSelectedTab = MY_ITINERARY_TAB;  //set the selected tab for MY_itinerary// self in hotel
					if(self.connectedToInternet) 
					{
						[self.mainVC showLoginPopup];	
					}
					else
					{
						[self.mainVC showOfflineAlert];
					}
				}	
				else
				#endif
				
				#if defined (ALL_VERSIONS_SECOND_STATIC)				
				{
					[self loadStaticControllerOnTabBar:tabBarController 
											  forIndex:MY_GROUP_ACCOUNT_TAB 
											 withTitle:RSStaticTabTitle 
											  withIcon:RSStaticTabIcon 
									   withProjectTree:@"ProjectTreeSecondStatic"];	
                    
//                    [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].title = @"Static";  //this also not working..find issue with static icon /title
//               		
//                    [[[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB] tabBarItem].image = [UIImage  imageNamed:RSHotelTabIcon];
				}				
				#else				 
				{	//flow for my account // group in hotel
//					mainVC.isMyItinerary = NO;          //should be set only for button from the main screen in maimVC
//					mainVC.isClubMyAccount = YES;
//					mainVC.isClubMyItinerary = NO;
                    #if !defined HOTEL_VERSION_TWO_BUTTONS
					presentSelectedTab = MY_GROUP_ACCOUNT_TAB;  //set the selected tab for group/my account
                    #endif
                    if(self.connectedToInternet) 
					{
						[self.mainVC showLoginPopup];	
					}
					else
					{
						[self.mainVC showOfflineAlert];
					}
				}
				#endif
			}	
		} 
		
		//Bookings Tab for Club target
        if (navCntrl.tabBarItem.tag == BOOKINGS_TAB) {
            
            self.mainVC.isMyHotelOrClub= NO;
            
            NSLog(@"Tab selected BOOKINGS_TAB");

//            if(self.isLoggedIn) {   //not needed as login is handled inthe booking itself
//                //Load the Locations if array has elements
//                if([self.bookingLocationsArray count] > 1)
//                {
//                    UIViewController *bookVC = [[RSBookingsMainVC alloc] init];
//                    [self createNavControllerWithRootController:bookVC withTabTitle:RSBookingTabTitle TabImageName:RSBookTabIcon tabTag:BOOKINGS_TAB];
//                    [bookVC.navigationController.view addSubview:self.activityIndicator.view];
//                    [self.activityIndicator.activity startAnimating];
//
//                    [bookVC release];
//                }
//                else
//                {
//                    [navCntrl.view addSubview:self.activityIndicator.view];
//                    [self.activityIndicator.activity startAnimating];
//                }
//            }             //also change the main xib to remove the bookingmain vc
            
            UIViewController *bookVC = [[RSBookingsMainVC alloc] init];
            [self createNavControllerWithRootController:bookVC withTabTitle:RSBookingTabTitle TabImageName:RSBookTabIcon tabTag:BOOKINGS_TAB];
            [bookVC.navigationController.view addSubview:self.activityIndicator.view];
            [self.activityIndicator.activity startAnimating];
            
            [bookVC release];
        }
		
//		if (!mainVC.isMyHotelOrClub) {
//			[navCntrl popToRootViewControllerAnimated:YES];
//		}
	}
}

//Get the stored values from the keychain
-(void) getStoredValuesFromKeychain
{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	#if defined(HOTEL_VERSION)
		mainVC.folioid = [prefs stringForKey:@"FolioId"];
		mainVC.guestpin = [prefs stringForKey:@"GuestPin"];
	#elif defined(CLUB_VERSION)

	#endif
    //-----comman for both hotel and club--------
    mainVC.emailAddress = [prefs stringForKey:EmailAddressKey];
    mainVC.password = [prefs stringForKey:PasswordKey];				
    
    mainVC.customerId = [prefs stringForKey:CustomerIdKey];
    mainVC.customerGUID = [prefs stringForKey:CustomerGUIDKey];
    mainVC.startDate = [prefs stringForKey:@"StartDate"];
    mainVC.endDate = [prefs stringForKey:@"EndDate"];
}

-(void) loadStaticControllerOnTabBar:(UITabBarController *) tabBarController 
							forIndex:(int) atIndex 
						   withTitle:(NSString *) title
							withIcon:(NSString *) icon 
					 withProjectTree:(NSString *) projectTree 
{
	//read the infoplist in to the node;
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:projectTree ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
	RSListViewNode* node = [[RSListViewNode alloc]initWithTitle:[dictionary objectForKey:Plist_Title_Key]
													HeaderImage:[dictionary objectForKey:Plist_Header_Image_Key] 
													  IConImage:[dictionary objectForKey:Plist_Thumbnail_Image_Key]
													  NodeArray:[dictionary objectForKey:Plist_DictionaryArray_Key]];
	
	RSListViewController *firstListController = [[RSListViewController alloc]initViewWithNode:node];
	
    [self createNavControllerWithRootController:firstListController withTabTitle:title TabImageName:icon tabTag:atIndex];
    //self.tabBarController.selectedIndex = atIndex;//check
    [dictionary release];
    [node release];
 
    [firstListController release];
}

#pragma mark Internet Reachability
- (void) checkNetworkStatus:(NSNotification *)notice
{
	// called after network status changes
	
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	switch (internetStatus)
	
	{
		case NotReachable:
		{
			DLog(@"The internet is down.");
			self.connectedToInternet = NO;
			break;
			
		}
		case ReachableViaWiFi:
		{
			DLog(@"The internet is working via WIFI.");
			self.connectedToInternet = YES;
			break;
			
		}
		case ReachableViaWWAN:
		{
			DLog(@"The internet is working via WWAN.");
			self.connectedToInternet = YES;
			break;
			
		}
	}
}

+(void) changeNavigationBarTitleFormat:(UIViewController*)currentController text:(NSString*)title fontSize:(CGFloat*)size;
{
	CGRect frame = CGRectMake(0, 0, Screen_Height - 80, NavigationBar_Height); 
	UILabel *label = [[UILabel alloc] initWithFrame:frame]; 
	label.backgroundColor = [UIColor clearColor]; 
	
	label.font = [UIFont boldSystemFontOfSize:18.0]; 
	label.numberOfLines = 2;
	
	label.textAlignment = UITextAlignmentCenter; 
	label.textColor = [UIColor whiteColor]; 
	label.text = title;
	currentController.navigationItem.titleView = label; 
	[label release];
	
}

-(void)createNavControllerWithRootController:(UIViewController *)viewController withTabTitle:(NSString *)tabTitle
                                TabImageName:(NSString *)TabImage tabTag:(int)tag
{
    RSNavigationController* navController = [[RSNavigationController alloc] initWithRootViewController:viewController];
    [navController setTitle:tabTitle tabBarItemImage:TabImage tabBarItemTag:tag];
    
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithArray:self.tabBarController.viewControllers];
    [tabArray removeObjectAtIndex:tag];
    
    [tabArray insertObject:navController atIndex:tag];
//    [tabArray replaceObjectAtIndex:tag withObject:navController];
    self.tabBarController.viewControllers = tabArray;
    
    
    [tabArray removeAllObjects];
    [tabArray release];
    
   
    [navController release];
    
    navController = nil;
}


#pragma mark - endpoint configuration delegate method
-(void)endPointConfigurationDone
{
    [endPointConfiguration setDelegate:nil];
    [self performSelector:@selector(removeScreen) withObject:nil afterDelay:3.0];
   
}

- (void)removeScreen
{
     [mainVC removeSplashScreen];
}
@end
