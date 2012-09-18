//
//  RSDateSelectionViewController.m
//  ResortSuite
//
//  Created by Cybage on 17/08/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMGDurationSelectionViewController.h"
#import "RSMainViewController.h"
#import "ErrorPopup.h"
#import "RSMIMainScreenViewController.h"
#import "ResortSuiteAppDelegate.h"

#import "RSBookingTableView.h"
#import "RSBookingTableViewCell.h"
//
#import "ErrorPopup.h"
#import "SoapRequests.h"
#import "RSMGMainScreenController.h"

@implementation RSMGDurationSelectionViewController
@synthesize startDate;
@synthesize endDate;
//
@synthesize pathForfirstCell;
@synthesize responseString;
@synthesize parserItineraryObj;

#define TABLE_DATE_OFFSET_Y         5

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Initialization code
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = item;
	[item release];
	
	//Table initialization
	dateTable.rowHeight = 30;
	dateTable.backgroundColor = [UIColor clearColor];

	//Date Picker initialization
	datePicker.datePickerMode = UIDatePickerModeDate;
	datePicker.hidden = NO;
	datePicker.date = [NSDate date];
	
	//Action on Date Picker
	[datePicker addTarget:self
	               action:@selector(changeDateInTableCell:)
	     forControlEvents:UIControlEventValueChanged];
	
	//Date lable initialization
	startDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, (dateTable.frame.origin.y + TABLE_DATE_OFFSET_Y), 220, 40)];
	startDateLabel.textAlignment = UITextAlignmentRight;
	startDateLabel.opaque = YES;
	startDateLabel.backgroundColor = [UIColor clearColor];
	startDateLabel.font = [UIFont systemFontOfSize:14];
	startDateLabel.text = @"";
	[self.view addSubview:startDateLabel];
	[startDateLabel release];
	
	endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, (dateTable.frame.origin.y + dateTable.rowHeight + TABLE_DATE_OFFSET_Y), 220, 40)];
	endDateLabel.textAlignment = UITextAlignmentRight;
	endDateLabel.opaque = YES;
	endDateLabel.backgroundColor = [UIColor clearColor];
	endDateLabel.font = [UIFont systemFontOfSize:14];
	endDateLabel.text = @"";
	[self.view addSubview:endDateLabel];	
	[endDateLabel release];
	
	startDate = [[NSDate alloc] init];
	endDate = [[NSDate alloc] init];
    
    [self drawDoneButton];
    currentSelectedRowIndex = MGStartDateSection; //should be selected by default
}

-(void)drawDoneButton
{
    // add booking button note new y is already calculated
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Done_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Done_button];
	
	[doneButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[doneButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
    
    doneButton.enabled = NO;

}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
	[appDelegate.activityIndicator.activity stopAnimating];
	[appDelegate.activityIndicator.view removeFromSuperview];
	self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)dealloc {
    DLog(@"RSMGDurationSelectionViewController released--------");
	[startDate release];
    [endDate release];
    //
    [pathForfirstCell release];
    //
    [parserItineraryObj release];
    [super dealloc];
}


-(IBAction) doneButtonAction:(id)sender
{	
	//Call the WS if End Date is greater than Start Date, otherwise show an alert
    if (! [startDateLabel.text isEqualToString:@""] && ! [endDateLabel.text isEqualToString:@""]) 
	{
		switch ([self.startDate compare:self.endDate]) {
			case NSOrderedAscending:{
				appDelegate.mainVC.isClubMyItinerary = YES;
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
						
				[self.navigationController.view addSubview:appDelegate.activityIndicator.view];
                [appDelegate.activityIndicator.activity startAnimating];

#if defined (HOTEL_VERSION)
                
        //USE EMAIL ADD  AND PASSWORD HERE in place of folioID and PIN in hotel
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [self fetchGroupItineraryForHotel:[dateFormatter stringFromDate:startDate] EndDate:[dateFormatter stringFromDate:endDate] withFolioId:[prefs valueForKey:EmailAddressKey] GuestPin:[prefs valueForKey:PasswordKey]];


#endif
				
				[dateFormatter release];
			}
				break;
				
			case NSOrderedSame:
				
			case NSOrderedDescending:{
				ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
				[errorPopup initWithTitle:POPUP_Start_End_Date];
			}			
				break;
		}	
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return MGNoOfDatesSections;
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

	//Create a lable to display the content in the cell
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	if (indexPath.row == MGStartDateSection) {		
		cell.textLabel.text = DurationSelection_Start;	
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterFullStyle;
        self.startDate = datePicker.date;
		startDateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
        [dateFormatter release];
        
	}
	else {		
		cell.textLabel.text = DurationSelection_Ends;
	}
	
    //Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
    
    //set the start date/1st row selected by default.
    if (indexPath.row == 0) {
        UIImageView *BackgroundImageView = [[UIImageView alloc] init];
        BackgroundImageView.image = [UIImage imageNamed:top_arrow_image];
        cell.backgroundView = BackgroundImageView;
        [BackgroundImageView release];
        self.pathForfirstCell = indexPath;
    }
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    RSBookingTableViewCell *cell  = (RSBookingTableViewCell *)[tableView cellForRowAtIndexPath:self.pathForfirstCell];
    UIImageView *BackgroundImageView = [[UIImageView alloc] init];
    BackgroundImageView.image = [UIImage imageNamed:@"top_no_arrow_white.png"];
    cell.backgroundView = BackgroundImageView;
    [BackgroundImageView release];
    
	if (indexPath.row == MGStartDateSection) {
		currentSelectedRowIndex = MGStartDateSection;

	}
	else if (indexPath.row == MGEndDateSection) {
		currentSelectedRowIndex = MGEndDateSection;
	}
    
    if (! [startDateLabel.text isEqualToString:@""] && ! [endDateLabel.text isEqualToString:@""]) 
    {
        doneButton.enabled = YES;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - event method of picker view
- (void)changeDateInTableCell:(id)sender{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateStyle = NSDateFormatterFullStyle;
	
	//Set the labels on selection of the date from the picker
	if (currentSelectedRowIndex == MGStartDateSection) {	
		self.startDate = datePicker.date;
		startDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:datePicker.date]];
	}
	else if (currentSelectedRowIndex == MGEndDateSection) {	
		self.endDate = datePicker.date;
		endDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:datePicker.date]];
	}	
	[dateFormatter release];
    
    if (! [startDateLabel.text isEqualToString:@""] && ! [endDateLabel.text isEqualToString:@""]) 
    {
        doneButton.enabled = YES;
    }

}	
//------------------------------------------------------------------------------------------------
-(void) loadMyGroupView
{
    RSMGMainScreenController*mRSMGMainScreenViewController = [[RSMGMainScreenController alloc] init];
    [self.navigationController pushViewController:mRSMGMainScreenViewController animated:YES];
    [mRSMGMainScreenViewController release];	
}

-(void) fetchGroupItineraryForHotel: (NSString *) startdate EndDate:(NSString *) enddate withFolioId:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin
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
							 appDelegate.mainVC.customerId, 
							 appDelegate.mainVC.customerGUID,
							 appDelegate.mainVC.emailAddress, 
							 appDelegate.mainVC.password,
							 startdate, enddate];
    [self fetchDataForRequestWithBody:requestBody];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
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
    
    DLog(@" request body: %@",soapString);
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	if (self.responseString) {		
        self.responseString = nil;
	}
	responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    DLog(@"responseString ===== \n%@",responseString);
    
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
		if (appDelegate.tabBarController.selectedIndex == 2 || appDelegate.mainVC.isClubMyItinerary) {
			if (appDelegate.isLoggedIn) {
				[errorPopup initWithTitle:POPUP_No_Bookings];
			}					
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
        [self loadMyGroupView]; //for both button //tab flow no need to check for buttons
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
