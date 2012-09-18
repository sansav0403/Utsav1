    //
//  RSGolfBookingsMainVC.m
//  ResortSuite
//
//  Created by Cybage on 16/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSBookingsMainVC.h"
#import "RSBookingTableView.h"
#import "RSMainViewController.h"
#import "ResortSuiteAppDelegate.h"
#import "Authentication.h"
#import "RSGolfLocationsParser.h"
#import "RSGolfLocations.h"
#import "RSFolio.h"
#import "RSSpaLocationParser.h"
#import "RSSpaLocation.h"
#import "ErrorPopup.h"
#import "RSSpaClassServiceVC.h"
#import "SoapRequests.h"
#import "RSGolfCourseVC.h"
#import "RSBookingTableViewCell.h"
#import "RSSelectedSpaLocation.h"
#import "RSSelectedGolfLocation.h"
#import "RSSpaClassBookingFormVC.h"
#import "RSSpaServiceBookingMainVC.h"
#import "LoginActionSheet.h"
@implementation RSBookingsMainVC

@synthesize golfLocationsParser;
@synthesize spaLocationsParser;
@synthesize emailAddress;
@synthesize password;
@synthesize customerId;
@synthesize customerGUID;
@synthesize isGolfLocation;

@synthesize parserItineraryObj;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    if(!appDelegate.isLoggedIn) 
    {
        [self showLoginPopup];
    }
    else 
    {
        //Fetch Golf and Spa locations both
        [self fetchGolfLocationsRequest];
    }		


    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	self.navigationItem.title = Book_ViewTilte;
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	
	if (appDelegate.bookingLocationsArray) {
		NSLog(@"appDelegate.bookingLocationsArray: %@", appDelegate.bookingLocationsArray);
		if ([appDelegate.bookingLocationsArray count] > 0 && [[appDelegate.bookingLocationsArray objectAtIndex:0] isEqualToString:@"Golf"]) {
			self.isGolfLocation = YES;
		}
		mainFieldArray = [[NSMutableArray alloc] initWithArray:appDelegate.bookingLocationsArray];
	}
	else {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:nil];
	}

    //Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];

}

-(void) viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mainFieldArray removeAllObjects];
	[mainFieldArray release];
	
	[golfLocationsParser release];
	[parserItineraryObj release];

    [super dealloc];
}

#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [mainFieldArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell...
	
	//Store the text content for the cell
	NSString *mainfield = [mainFieldArray objectAtIndex:indexPath.row];
	cell.textLabel.text = mainfield;
	
	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
	
	//Set the accessory view
	[cell setAccessoryViewImage:YES];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	int objectAtIndex = indexPath.row;
	
	if (indexPath.row == 0 && self.isGolfLocation) {
		NSLog(@"Load Golf Locations VC");
		//by default set the selected golflocation be the 1st ob from the array of golf location.
        RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];        
		location.golfLocation = [appDelegate.golfLocationsParser.golfLocationsModel.golfLocations objectAtIndex:0];
                                         
		RSGolfCourseVC *golfCourseVC = [[RSGolfCourseVC alloc] init];
		[self.navigationController pushViewController:golfCourseVC animated:YES];
		[golfCourseVC release];
	}
	else {
		if (self.isGolfLocation) {
			//objectAtIndex is set for getting the Spa locations objects
			objectAtIndex = indexPath.row - 1;
		}
		
		//Storing the selected spa location
		RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
		location.spaLocation = [appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:objectAtIndex];
		///		
		
		//Load respective view controllers depending on the Booking Types (All/Service/Class)
		if ([[[appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:objectAtIndex] bookingType] 
		 isEqualToString:@"All"]) {
            appDelegate.bookingType = ALL;
		 RSSpaClassServiceVC *spaClassServiceVC = [[RSSpaClassServiceVC alloc] initWithViewTitle:[[appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:objectAtIndex] locationName]];
		 [self.navigationController pushViewController:spaClassServiceVC animated:YES];
		 [spaClassServiceVC release];
		 }

		 else if ([[[appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:objectAtIndex] bookingType] 
		 isEqualToString:@"Class"]) {
		 NSLog(@"Load Class VC");			
             appDelegate.bookingType = SINGLE;
             RSSpaClassBookingFormVC * spaClassBookingMainVC = [[RSSpaClassBookingFormVC alloc] initWithViewTitle:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName]];
             [self.navigationController pushViewController:spaClassBookingMainVC animated:YES];
             [spaClassBookingMainVC release];
		 }
		
		 else if ([[[appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:objectAtIndex] bookingType] 
		 isEqualToString:@"Service"]) {
		 NSLog(@"Load Service VC");
             appDelegate.bookingType = SINGLE;
             RSSpaServiceBookingMainVC *spaServiceBookingMainVC = [[RSSpaServiceBookingMainVC alloc] 
                                                                   initWithViewTitle:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName]];
             [self.navigationController pushViewController:spaServiceBookingMainVC animated:YES];
             [spaServiceBookingMainVC release];

		 }
		
	}
}



#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	NSString *responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
	NSLog(@"responseString: %@", responseString);
	
	//If Ws response is of type GolfLocationsResponse
	if ([responseString rangeOfString:@"FetchGolfLocationsResponse"].length > 0) {
		 if (self.golfLocationsParser) {
             self.golfLocationsParser = nil;
		 }
		 golfLocationsParser = [[RSGolfLocationsParser alloc] init];
		 golfLocationsParser.delegate = self;
			
		 [golfLocationsParser parse:dataFromWS];	
	 }
	//If Ws response is of type SpaLocationsResponse
	if ([responseString rangeOfString:@"FetchSpaLocationsResponse"].length > 0) {
		if (self.spaLocationsParser) {           
            self.spaLocationsParser = nil;
		}
		spaLocationsParser = [[RSSpaLocationParser alloc] init];
		spaLocationsParser.delegate = self;
		
		[spaLocationsParser parse:dataFromWS];	
	}
	//If Ws response is of type AuthCustomer
	 else if ([responseString rangeOfString:@"AuthCustomerResponse"].length > 0){
		 if (self.parserItineraryObj) {
             self.parserItineraryObj = nil;
		 }
		 parserItineraryObj = [[RSMyItineraryParser alloc] init];
		 parserItineraryObj.delegate = self;
		 [parserItineraryObj parse:dataFromWS];
	 }
	[responseString release];

}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}	
	else if ([parserModelData isKindOfClass:[RSGolfLocations class]]) {
		//If the data received is of type RSGolfLocations
		[self golfBookingsDataReceived:parserModelData];
		
		//Create the Spa locations request
		[self fetchSpaLocationsRequest];
	}
	else if ([parserModelData isKindOfClass:[RSSpaLocations class]]) {
		//If the data received is of type RSSpaLocations
		[self spaBookingsDataReceived:parserModelData];

        //stop animating when all parsing is done
        if([appDelegate.activityIndicator.activity isAnimating]) {
            [appDelegate.activityIndicator.activity stopAnimating];
            [appDelegate.activityIndicator.view removeFromSuperview];
        }

        if([appDelegate.bookingLocationsArray count] ==0)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NoBookingTitle
                                                                 message:NoBookingMessage
                                                                delegate:nil
                                                       cancelButtonTitle:POPUP_Button_Ok
                                                       otherButtonTitles:nil];
            
            [errorAlert show];
            [errorAlert release];	
            NSLog(@"We are currently not accepting mobile reservation at this time.");
        }
	}
	else if ([parserModelData isKindOfClass:[AuthCustomer class]]){
		//If the data received is of type AuthCustomer
		[self authenticationSuccess:parserModelData];
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}


-(void) authenticationSuccess:(id) parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = NO;
	appDelegate.myItineraryParser.authCustomer = (AuthCustomer *) parserModelData;
	
	if (appDelegate.myItineraryParser.authCustomer.authResult.resultValue == SUCCESS) {
		if(appDelegate.connectedToInternet)	{
			appDelegate.isLoggedIn = YES;
		}
		[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self.navigationController.visibleViewController];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		// saving a email address and password
		[prefs setObject:self.emailAddress forKey:EmailAddressKey];
		[prefs setObject:self.password forKey:PasswordKey];
		[prefs setObject:appDelegate.myItineraryParser.authCustomer.customerId forKey:CustomerIdKey];
		[prefs setObject:appDelegate.myItineraryParser.authCustomer.customerGUID forKey:CustomerGUIDKey];
		[prefs setObject:appDelegate.myItineraryParser.authCustomer.authorizationId forKey:AuthorizationIdKey];
		
		[prefs setBool:appDelegate.isLoggedIn forKey:LoggedInKey];
		
		[prefs synchronize];	
					
		self.customerId = [prefs stringForKey:CustomerIdKey];
		self.customerGUID = [prefs stringForKey:CustomerGUIDKey];
		
		//Create the Golf Locations Request
		[self fetchGolfLocationsRequest];

	}
}


-(void) golfBookingsDataReceived:(id) parserModelData
{
//	self.navigationController.navigationBar.userInteractionEnabled = YES;
	appDelegate.golfLocationsParser.golfLocationsModel = (RSGolfLocations *) parserModelData;
	
	if(appDelegate.connectedToInternet)	{
		appDelegate.isLoggedIn = YES;
	}
		
	if ([appDelegate.golfLocationsParser.golfLocationsModel.golfLocations count] > 0) {
		//Add "Golf" as static label in an array if Golf locations are available 
		if (mainFieldArray) {
			[mainFieldArray removeAllObjects];
			[mainFieldArray release];
		}
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:@"Golf", nil];

		self.isGolfLocation = YES;  //set is golf location if data is recieved
		[mainTableView reloadData];
	}	
}

-(void) spaBookingsDataReceived:(id) parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	appDelegate.spaLocationsParser.rsSpaLocations = (RSSpaLocations *) parserModelData;
	
	if(appDelegate.connectedToInternet)	{
		appDelegate.isLoggedIn = YES;
	}
    
    //If Golf web services are not availble then mainFieldArray should be recreated
    if(!self.isGolfLocation)
    {
        if (mainFieldArray) {
            [mainFieldArray removeAllObjects];
            [mainFieldArray release];
        }
        mainFieldArray = [[NSMutableArray alloc] initWithCapacity:0];
    }

	if ([self.spaLocationsParser.rsSpaLocations.spaLocations count] > 0) {
		//Add Spa locations list into an array
		for (int locationIndex =0; locationIndex < [self.spaLocationsParser.rsSpaLocations.spaLocations count]; locationIndex++) {
			[mainFieldArray addObject:[[appDelegate.spaLocationsParser.rsSpaLocations.spaLocations objectAtIndex:locationIndex] locationName]];
		}	
	}
	
    NSMutableArray *bookingLocations = [[NSMutableArray alloc] initWithArray:mainFieldArray];
	appDelegate.bookingLocationsArray = bookingLocations;
    [bookingLocations release];

	[mainTableView reloadData];
}

#pragma mark Load the Bookings Main View with details
-(void) loadBookingsMainView
{
	RSBookingsMainVC *bookingsMainVC = [[RSBookingsMainVC alloc] init];
	[self.navigationController pushViewController:bookingsMainVC animated:YES];
	[bookingsMainVC release];
}


#pragma mark Alerts

-(void) showLoginPopup
{
    isLoginPopupAppeared = TRUE;
 
    
    LoginOptions = [[LoginActionSheet alloc]initWithNibName:@"LoginActionSheet" bundle:[NSBundle mainBundle]];
    
    loginNavigation = [[UINavigationController alloc]initWithRootViewController:LoginOptions];
    [loginNavigation.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [LoginOptions setTitle:loginOption_screen_title];
    [LoginOptions setDelegate:self];
    
    //[self.tabBarController.view addSubview:LoginOptions.view];
    [self.tabBarController presentModalViewController:loginNavigation animated:YES];
    [loginNavigation release];
    [LoginOptions release];
}

-(void) showLogoutAlert //caled from the main controller
{
	signoutAlert = [[UIAlertView alloc] initWithTitle:POPUP_Sign_Out
									   message:POPUP_Sign_Out_Text
									  delegate:self
							 cancelButtonTitle:POPUP_Button_Cancel 
							 otherButtonTitles:POPUP_Button_Ok, nil];
	[signoutAlert show];
	[signoutAlert release];    
}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	
	Result *resultError = (Result *) parserModelData;
	
	if (appDelegate.connectedToInternet) {
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
        
        if(!appDelegate.isLoggedIn) {
        appDelegate.tabBarController.selectedIndex = 0; 
        }
	}

}

#pragma mark Fetch Authenticate Customer if the OK button clicked.

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	isLoginPopupAppeared = FALSE;
    
	// Clicked the OK button
	if (buttonIndex != [alertView cancelButtonIndex]) {
		if ([alertView isKindOfClass:[Authentication class]]) {
			//get the input from the user and pass the parameters to the function			
            [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
			[appDelegate.activityIndicator.activity startAnimating];
			
			self.emailAddress = popup.txtFieldPMSFolioId.text;
			self.password = popup.txtFieldGuestPin.text;
			
			[self authenticateCustomer:self.emailAddress Password:self.password];
			
		}
	}
	else if (buttonIndex == [alertView cancelButtonIndex]) {
		//Assign the last tab bar selected index to the current index
		appDelegate.tabBarController.selectedIndex = appDelegate.prevSelectedIndex;		
	}
}

#pragma mark - LoginView Delegate Methods


-(void)ActionSheet:(LoginActionSheet *)actionSheet buttonSelectedAtindex:(int)buttonIndex
{
    NSLog(@"button hit at index: %d",buttonIndex);
    switch (buttonIndex) {
        case signIn:
        {
            //remove the login navigation bar that was added om the tabbarcontroller
            [loginNavigation dismissModalViewControllerAnimated:YES];
            
            NSLog(@"username is %@",actionSheet.txtFieldPMSFolioId.text);
            NSLog(@"password is %@",actionSheet.txtFieldGuestPin.text);
            //get the input from the user and pass the parameters to the function			
            
            [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
            [appDelegate.activityIndicator.activity startAnimating];

            //---------********************************************--------------------------
            //authentication flow are same in the hotel and club App.
            self.emailAddress = actionSheet.txtFieldPMSFolioId.text;
            self.password = actionSheet.txtFieldGuestPin.text;			
            [self authenticateCustomer:self.emailAddress  Password:self.password];			
            
            self.navigationController.navigationBar.userInteractionEnabled = NO;
        }
            break;
        case forgotPassword:
        {
            //Assign the last tab bar selected index to the current index on Sign Out cancel button
            appDelegate.tabBarController.selectedIndex = appDelegate.prevSelectedIndex;
        }
            break;
        case newUser:
        {
            //Assign the last tab bar selected index to the current index on Sign Out cancel button
            appDelegate.tabBarController.selectedIndex = appDelegate.prevSelectedIndex;
        }
            break;
        case cancel:
        {
            //Assign the last tab bar selected index to the current index on Sign Out cancel button
            appDelegate.tabBarController.selectedIndex = appDelegate.prevSelectedIndex;
            [loginNavigation dismissModalViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}




- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // created a new thread to to release action sheet after waiting some time.
    
    [self performSelector:@selector(waitActionSheet) withObject:nil afterDelay:2];
}

-(void)waitActionSheet
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];

    
    [self performSelectorOnMainThread:@selector(releaseActionSheet) withObject:nil waitUntilDone:NO];
    
   [pool release];
}
-(void)releaseActionSheet
{
    [LoginOptions.view removeFromSuperview];
    [LoginOptions release];
}


#pragma mark method for creating Authentication soap request
-(void) authenticateCustomer:(NSString *) EmailAddress Password:(NSString *) Password
{
	//Auth Customer request
	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:AuthCustomerRequest>"
                             "<Source>IPHONE</Source>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "</rsap:AuthCustomerRequest>",EmailAddress, Password];
	
	[self fetchDataForRequestWithBody:requestBody];
	self.navigationController.navigationBar.userInteractionEnabled = NO;
}

#pragma mark Common method for creating soap request and make a connection with WS 
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}

#pragma mark method for creating soap requests
-(void) fetchGolfLocationsRequest
{
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	[self fetchDataForRequestWithBody:@"<rsap:FetchGolfLocationsRequest></rsap:FetchGolfLocationsRequest>"];
	self.navigationController.navigationBar.userInteractionEnabled = NO;
}

-(void) fetchSpaLocationsRequest
{
	[self fetchDataForRequestWithBody:@"<rsap:FetchSpaLocationsRequest></rsap:FetchSpaLocationsRequest>"];
	self.navigationController.navigationBar.userInteractionEnabled = NO;
}


@end
