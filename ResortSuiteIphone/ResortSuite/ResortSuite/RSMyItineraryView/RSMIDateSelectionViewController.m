    //
//  RSMIDateSelectionViewController.m
//  ResortSuite
//
//  Created by Cybage on 17/08/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIDateSelectionViewController.h"
#import "RSTableView.h"
#import "ResortSuiteAppDelegate.h"
#import "RSDateSelectionViewController.h"
#import "DateFormatting.h"
#import "RSMainViewController.h"
#import "MapViewController.h"
#import "RSMIMainScreenViewController.h"
#import "ErrorPopup.h"
#import "SoapRequests.h"

@implementation RSMIDateSelectionViewController
@synthesize responseString;
@synthesize parserItineraryObj;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[ResortSuiteAppDelegate setCurrentScreenImage:MyItinerary_HI controller:self];
	self.navigationItem.title = SelectDuration_viewTitle;
	
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = item;
	[item release];
	
	//if (self.navigationController.delegate == nil) {  //always set it for flow through button or through tab
		[self.navigationController setDelegate:self];
	//}
	//List view titles
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:AllFutureBooking_CellTitle,SpecificDate_CellTitle,nil];
	
	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];   
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self];	
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
    [self.navigationController setDelegate:nil];
}


- (void)dealloc {
     NSLog(@"RSMIDateSelectionViewController released--------");
	[mainFieldArray removeAllObjects];
	[mainFieldArray release];
	//
    [parserItineraryObj release];
    [super dealloc];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	//---------------ADDING SignIn/Out BUTTON-----------------
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}

-(void)signInOutButtonAction:(id)sender
{
	if (appDelegate.isLoggedIn) {
		
		[appDelegate.mainVC showLogoutAlert];
	}
}


//Load the My Itinerary view with details   //called from mainVC
-(void) loadMyItineraryView
{
    RSMIMainScreenViewController*mRSMIMainScreenViewController = [[RSMIMainScreenViewController alloc] init];
    [self.navigationController pushViewController:mRSMIMainScreenViewController animated:YES];
    [mRSMIMainScreenViewController release];	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return NoOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    RSTableViewCell *cell = (RSTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

	// Configure the cell...
	
	//Store the text content for the cell
	NSString *mainfield = [mainFieldArray objectAtIndex:indexPath.section];
	
	//Create a lable to display the content in the cell
	cell.cellLable.text = mainfield;
	
	//Create a image thumbnail which will come under each cell

    switch (indexPath.section)
	{
		case AllFurtherBookings:
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByDate_Icon];
			break;
            
		case SelectDates:
			cell.cellImageView.image = [UIImage imageNamed:MyItinerary_Icon];
			break;
		default:
			break;
	}
	//Use to do masking of cell image
	[cell DoMaskingOnCellImage];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

//------------------------------
    if(indexPath.section == AllFurtherBookings)
	{
		if (appDelegate.connectedToInternet) {            
            [self.view addSubview:appDelegate.activityIndicator.view];
            [appDelegate.activityIndicator.activity startAnimating];
            
            NSDate *currentDate = [NSDate date];
            NSString *startDate = [DateFormatting stringFromDate:currentDate];
            
            NSString *endDate = @"";        //no date is added currntly
            
#if defined (CLUB_VERSION)
            [self fetchGuestItineraryForClub:startDate EndDate:endDate];
#endif
#if defined (HOTEL_VERSION)                       
            //USE EMAIL ADD  AND PASSWORD HERE in palce of floioId and pin
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [self fetchGuestItineraryForHotel:startDate EndDate:endDate withFolioId:[prefs valueForKey:EmailAddressKey] GuestPin:[prefs valueForKey:PasswordKey]];
#endif
	
		}
		else {
			[appDelegate.mainVC showOfflineAlert];
		}
//-----------------------------

	}
	if(indexPath.section == SelectDates)
	{
		RSDateSelectionViewController *dateSelectionVC = [[RSDateSelectionViewController alloc] init];
		[self.navigationController pushViewController:dateSelectionVC animated:YES];
		dateSelectionVC.navigationItem.title = SelectDates_ViewTitle;
		
		[dateSelectionVC release];
	}  
}

-(void) fetchGuestItineraryForHotel: (NSString *) startdate EndDate:(NSString *) enddate withFolioId:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin
{ 
    NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchGuestItineraryRequest>"
                             "<Source>IPHONE</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "<StartDate>%@</StartDate>"
							 "<EndDate>%@</EndDate>"
							 "</rsap:FetchGuestItineraryRequest>",
							 appDelegate.mainVC.customerId,         //check the values here
							 appDelegate.mainVC.customerGUID,
							 appDelegate.mainVC.emailAddress, 
							 appDelegate.mainVC.password,
							 startdate, enddate];	
	[self fetchDataForRequestWithBody:requestBody];
}

-(void) fetchGuestItineraryForClub: (NSString *) startdate EndDate:(NSString *) enddate //similar function for hotel app alsofor itinerary
{
	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchGuestItineraryRequest>"
                             "<Source>IPHONE</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "<StartDate>%@</StartDate>"
							 "<EndDate>%@</EndDate>"
							 "</rsap:FetchGuestItineraryRequest>",
                             appDelegate.mainVC.customerId,         //check the values here
							 appDelegate.mainVC.customerGUID,
							 appDelegate.mainVC.emailAddress, 
							 appDelegate.mainVC.password,
							 startdate, enddate];	
    
	[self fetchDataForRequestWithBody:requestBody];
}
#pragma mark Common method for creating soap request
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
    
    NSLog(@" request body: %@",soapString);
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	if (self.responseString) {		
        self.responseString = nil;
	}
	responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    NSLog(@"responseString ===== \n%@",responseString);

	 if ([self.responseString rangeOfString:@"FetchGuestItineraryResponse"].length > 0) {
		if (self.parserItineraryObj) {
            self.parserItineraryObj = nil;
		}
		parserItineraryObj = [[RSMyItineraryParser alloc] init];    //class also used to authenticate user 
		parserItineraryObj.delegate = self;
		[parserItineraryObj parse:dataFromWS];
	}
    [responseString release];
    responseString = nil;
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}
	
	if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[RSMyItineraryModel class]]) {
		[self guestItineraryDataReceived:parserModelData];
	}	
    	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];

			if (appDelegate.isLoggedIn) {
				[errorPopup initWithTitle:POPUP_No_Bookings];
			}					
		else {
			[errorPopup initWithTitle:@"Fault"];
		}
	}	
}
-(void) guestItineraryDataReceived:(id)parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	
	appDelegate.myItineraryParser.guestItinerary = (RSMyItineraryModel *) parserModelData;
	
	if (appDelegate.myItineraryParser.guestItinerary.result.resultValue == SUCCESS &&
        [appDelegate.myItineraryParser.guestItinerary.guestBookings.folios count] > 0) {
		if(appDelegate.connectedToInternet)	{
			appDelegate.isLoggedIn = YES;
		}
        
/* if data is recieved push the MIMainScreen*/
        [self loadMyItineraryView]; //for both button //tab flow no need to check for buttons
	}
    else {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:POPUP_Error
                                   message:POPUP_Booking_Unavailable
                                   delegate:nil
                                   cancelButtonTitle:POPUP_Button_Ok
                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
        
    }

}
#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    appDelegate.myItineraryParser.errorResult = (Result *) parserModelData;
    
    if (appDelegate.connectedToInternet) {
        NSString *errorMessage = [NSString stringWithFormat:@"%@", appDelegate.myItineraryParser.errorResult.resultText];
        
        ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
        [errorPopup initWithTitle:errorMessage];
            appDelegate.tabBarController.selectedIndex = 0; 
    }
}
@end
