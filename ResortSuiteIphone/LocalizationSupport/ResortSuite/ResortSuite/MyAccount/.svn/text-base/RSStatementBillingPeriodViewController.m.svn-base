//
//  RSStatementBillingPeriodViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSStatementBillingPeriodViewController.h"
#import "RSTableView.h"
#import "MapViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMainViewController.h"

#import "RSStatementOptionViewController.h"
#import "RSPreviousBillingPeriodsViewController.h"

#import "RSProfile.h"
#import "ResortSuiteAppDelegate.h"
#import "RSClubStatementParser.h"
#import "RSClubBillingHistoryParser.h"
#import "RSClubStatement.h"
#import "ErrorPopup.h"

@implementation RSStatementBillingPeriodViewController

@synthesize responseString;
@synthesize clubStatementParser;
@synthesize clubBillingHistoryParser;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyAccount_HI controller:self];
	
	self.navigationItem.title = BillingPeriod_ViewTilte;

	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	[ResortSuiteAppDelegate setContactUsIcon:YES];

	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:BillingPeriod_Current,BillingPeriod_Last,BillingPeriod_Previous,nil];

	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	//---------------ADDING SignIn/Out BUTTON-----------------
	UIBarButtonItem *modalButton;

	UIButton *signInOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	if (appDelegate.isLoggedIn) {
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignOutBtn] forState:UIControlStateNormal];
	}
	else {
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignInBtn] forState:UIControlStateNormal];
	}
	
	signInOutButton.frame = CGRectMake(270, 15, 30, 30);
	[signInOutButton addTarget:self action:@selector(signInOutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	
	modalButton = [[UIBarButtonItem alloc] initWithCustomView:signInOutButton];
	if ( !([viewController isKindOfClass:[MapViewController class]]) && [ResortSuiteAppDelegate getContactUsIcon])
	{
		[viewController.navigationItem setRightBarButtonItem:modalButton animated:YES];
	}
	
	[modalButton release];
}

-(void)signInOutButtonAction:(id)sender
{
	if (appDelegate.isLoggedIn) {
		
		[appDelegate.mainVC showLogoutAlert];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	
	[appDelegate.activityIndicator.activity stopAnimating];
	[appDelegate.activityIndicator.view removeFromSuperview];	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [mainFieldArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
		case CurrentSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Current_Icon];
			break;
		case LastSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Last_Icon];
			break;
		case PreviousSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Previous_Icon];
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

    //Adding selected mask image to the selected row.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [RSTableViewCell DoMaskingOnSelectedCellImage:cell];

	appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];

	NSString *soapMessage =@"";
#if defined(CLUB_VERSION)
	//Clicked previous
	if(indexPath.section == PreviousSection)
	{
		 soapMessage = 
		 [NSString stringWithFormat:
		 @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rsap=\"http://www.resortsuite.com/RSAPP\">"
		 "<soapenv:Header>"
		 "<o:Security soapenv:mustUnderstand=\"1\" xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
		 "<o:UsernameToken>"
		 "<o:Username>resortsuite</o:Username>"
		 "<o:Password>resortsuite</o:Password>"
		 "</o:UsernameToken>"
		 "</o:Security>"
		 "</soapenv:Header>"
		 "<soapenv:Body>"
		 "<rsap:FetchClubBillingHistoryRequest>"
          "<Source>IPHONE</Source>"
		 "<CustomerId>%@</CustomerId>"
		 "<CustomerGUID>%@</CustomerGUID>"
		 "<EmailAddress>%@</EmailAddress>"
		 "<Password>%@</Password>"
		 "<AccountId>%@</AccountId>"
		 "</rsap:FetchClubBillingHistoryRequest>"
		 "</soapenv:Body>"
		 "</soapenv:Envelope>",
		 appDelegate.mainVC.customerId, 
		 appDelegate.mainVC.customerGUID,
		 appDelegate.mainVC.emailAddress, 
		 appDelegate.mainVC.password, [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId]];	 
	}
	else {
		
		NSString *billDate =@"";
		
		if(indexPath.section == CurrentSection)
		{
			billDate = @"current";
		}
		else if(indexPath.section == LastSection)
		{
			billDate = @"last";
		}
		
		soapMessage = 
		[NSString stringWithFormat:
		 @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rsap=\"http://www.resortsuite.com/RSAPP\">"
		 "<soapenv:Header>"
		 "<o:Security soapenv:mustUnderstand=\"1\" xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
		 "<o:UsernameToken>"
		 "<o:Username>resortsuite</o:Username>"
		 "<o:Password>resortsuite</o:Password>"
		 "</o:UsernameToken>"
		 "</o:Security>"
		 "</soapenv:Header>"
		 "<soapenv:Body>"
		 "<rsap:FetchClubStatementRequest>"
         "<Source>IPHONE</Source>"
		 "<CustomerId>%@</CustomerId>"
		 "<CustomerGUID>%@</CustomerGUID>"
		 "<EmailAddress>%@</EmailAddress>"
		 "<Password>%@</Password>"
		 "<AccountId>%@</AccountId>"
		 "<BillDate>%@</BillDate>"                  //billing date to decide time of account detials
		 "</rsap:FetchClubStatementRequest>"
		 "</soapenv:Body>"
		 "</soapenv:Envelope>",
		 appDelegate.mainVC.customerId, 
		 appDelegate.mainVC.customerGUID,
		 appDelegate.mainVC.emailAddress, 
		 appDelegate.mainVC.password,
		 [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId],
		 billDate];
	}
#endif	

	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapMessage];
}

-(void)responseReceived:(NSMutableData *)dataFromWS
{
	if (self.responseString) {
		//[self.responseString release];	
        self.responseString = nil;
	}
	responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    DLog(@"responseString =%@", responseString);
	if ([self.responseString rangeOfString:@"FetchClubBillingHistoryResponse"].length > 0) {
		if (self.clubBillingHistoryParser) {
			[clubBillingHistoryParser release];    //[self.clubBillingHistoryParser release];
		}
		clubBillingHistoryParser = [[RSClubBillingHistoryParser alloc] init];
		clubBillingHistoryParser.delegate = self;
		[clubBillingHistoryParser parse:dataFromWS];
	}
	else {		
		if (self.clubStatementParser) {
			[clubStatementParser release]; //[self.clubStatementParser release];
		}
		clubStatementParser = [[RSClubStatementParser alloc] init];
		clubStatementParser.delegate = self;
		[clubStatementParser parse:dataFromWS];
	}
}


#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if ([parserModelData isKindOfClass:[Result class]]) {
		appDelegate.myAccParser.errorResult = (Result *) parserModelData;
		
		if (appDelegate.connectedToInternet) {
			NSString *errorMessage = [NSString stringWithFormat:@"%@", appDelegate.myAccParser.errorResult.resultText];
			
			ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
			[errorPopup initWithTitle:errorMessage];
		}
		
	}
	else if ([parserModelData isKindOfClass:[RSClubStatement class]]) {
		
		appDelegate.clubStatementParser.clubStatement = (RSClubStatement *) parserModelData;
	
		RSStatementOptionViewController *mRSStatementOptionViewController = [[RSStatementOptionViewController alloc] init];
		[self.navigationController pushViewController:mRSStatementOptionViewController animated:YES];
		[mRSStatementOptionViewController release];	
		
	}
	else if ([parserModelData isKindOfClass:[RSClubBillingHistory class]]) {
		appDelegate.clubBillingHistoryParser.clubBillingHistory = (RSClubBillingHistory *) parserModelData;
		
		RSPreviousBillingPeriodsViewController *mRSPreviousBillingPeriodsViewController = [[RSPreviousBillingPeriodsViewController alloc] init];
		[self.navigationController pushViewController:mRSPreviousBillingPeriodsViewController animated:YES];
		[mRSPreviousBillingPeriodsViewController release];	
		
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[mainTableView release];
	[mainFieldArray removeAllObjects];
	[mainFieldArray release];
	
	[responseString release];
	[clubStatementParser release];
	[clubBillingHistoryParser release];
	
    [super dealloc];
}


@end

