//
//  RSPreviousBillingPeriodsViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSPreviousBillingPeriodsViewController.h"
#import "RSTableView.h"
#import "MapViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMainViewController.h"

#import "RSStatementOptionViewController.h"
#import "RSChargeObject.h"
#import "RSClubStatementParser.h"
#import "RSProfile.h"

#import "RSClubStatementParser.h"
#import "RSClubBillingHistoryParser.h"
#import "ErrorPopup.h"

@implementation RSPreviousBillingPeriodsViewController

@synthesize clubStatementParser;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyAccount_HI controller:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:PreviousBilling_ViewTilte fontSize:nil];

	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	[ResortSuiteAppDelegate setContactUsIcon:YES];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] init];
	
	appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];

    NSLog(@"previous bill count = %d",[appDelegate.clubBillingHistoryParser.clubBillingHistory.billingPeriods count]);
	for(int billingPeriodIndex=0; billingPeriodIndex < [appDelegate.clubBillingHistoryParser.clubBillingHistory.billingPeriods count]; billingPeriodIndex++)
	{
		[mainFieldArray addObject:[[appDelegate.clubBillingHistoryParser.clubBillingHistory.billingPeriods objectAtIndex:billingPeriodIndex] billDate] ];
	}

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
	UIButton *signInOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	if (appDelegate.isLoggedIn) {
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignOutBtn] forState:UIControlStateNormal];
	}
	else {
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignInBtn] forState:UIControlStateNormal];
	}
	
	signInOutButton.frame = CGRectMake(270, 15, 30, 30);
	[signInOutButton addTarget:self action:@selector(signInOutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:signInOutButton];
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

	//Store the text content for the cell (No Thumbnails)
	[cell.cellLable setFrame:CGRectMake(15, 25, 300, 20)];

	//Create a lable to display the content in the cell
	cell.cellLable.text = mainfield;

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

	[self.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
	
	NSString* soapMessage;
	
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
	 "<CustomerId>%@</CustomerId>"
	 "<CustomerGUID>%@</CustomerGUID>"
	 "<EmailAddress>%@</EmailAddress>"
	 "<Password>%@</Password>"
	 "<AccountId>%@</AccountId>"
	 "<BillDate>%@</BillDate>"
	 "</rsap:FetchClubStatementRequest>"
	 "</soapenv:Body>"
	 "</soapenv:Envelope>",
	 appDelegate.myAccParser.clubAccounts.accCustomer.customerId, 
	 appDelegate.myAccParser.clubAccounts.accCustomer.customerGUID,
	 appDelegate.myAccParser.clubAccounts.accCustomer.emailAddress, 
	 appDelegate.password,
	 [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId],
	 [[appDelegate.clubBillingHistoryParser.clubBillingHistory.billingPeriods objectAtIndex:indexPath.section] billDate]];

	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapMessage];
}


-(void)responseReceived:(NSMutableData *)dataFromWS
{
	if (self.clubStatementParser) {
		//[self.clubStatementParser release];
        self.clubStatementParser = nil;
	}
	clubStatementParser = [[RSClubStatementParser alloc] init];
	clubStatementParser.delegate = self;
	[clubStatementParser parse:dataFromWS];
}


#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if ([parserModelData isKindOfClass:[Result class]]) {
		appDelegate.clubBillingHistoryParser.errorResult = (Result *) parserModelData;
		
		if (appDelegate.connectedToInternet) {
			NSString *errorMessage = [NSString stringWithFormat:@"%@", appDelegate.clubBillingHistoryParser.errorResult.resultText];
			
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
}


#pragma mark date Functions
-(NSString *)stringFromDate:(NSDate *)date
{
 	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"MMMM d, yyyy"];
	
	return [dateFormatter stringFromDate:date];
}

-(NSString *)stringFromDateWithoutYear:(NSDate *)date
{
 	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"MMMM d"];
	
	return [dateFormatter stringFromDate:date];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"MMMM d, yyyy"];  
	
	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return date;
}

-(NSString *)dateRange:(NSString *)firstDate endDate:(NSString *)lastDate
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];  
	NSDate* date = (NSDate*)[dateFormatter dateFromString:firstDate];

	[dateFormatter setDateFormat:@"MMMM d"];
	
	NSString* firstPart = [NSString stringWithFormat:@"From %@ to ",[dateFormatter stringFromDate:date]];
	
	[dateFormatter release];
	
	return [NSString stringWithFormat:@"%@ %@",firstPart,[self stringFromDate:[self stringToDate:lastDate]]];
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
	
    [super dealloc];
}


@end

