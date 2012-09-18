//
//  RSStatementOptionViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSStatementOptionViewController.h"
#import "RSTableView.h"
#import "MapViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMainViewController.h"

#import "RSChargeAndPaymentViewController.h"
#import "RSChargeObject.h"
#import "RSClubStatementParser.h"
#import "RSSummaryPage.h"
#import "ResortSuiteAppDelegate.h"

@implementation RSStatementOptionViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyAccount_HI controller:self];
	
	self.navigationItem.title = StatementOptions_ViewTilte;

	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	[ResortSuiteAppDelegate setContactUsIcon:YES];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:Club_Summary,Club_Charges,Club_Payments,nil];

	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
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
}

-(void) dateSorting:(NSArray *) folioObject
{
	NSArray *folioArray = [[NSArray	alloc]initWithArray:folioObject];
	//sorting Entried by Date
	if (sortDescriptor) {
		[sortDescriptor release];
	}
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ItemId" ascending:YES] ;
	
	sortDescriptors = [NSArray arrayWithObject:sortDescriptor];       //autorelease   
	sortedGroupEventObjectArray = [[NSArray alloc]initWithArray:[folioArray sortedArrayUsingDescriptors:sortDescriptors] ];
	
	//create a dictionry by date(day)
	dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	
	if (dateDictionary) {
		[dateDictionary removeAllObjects];
		[dateDictionary release];
	}
	dateDictionary = [[NSMutableDictionary alloc]init];
	
	for(int eventObjectIndex=0; eventObjectIndex<[sortedGroupEventObjectArray count]; eventObjectIndex++)
	{
		FolioItem *folioItem = [sortedGroupEventObjectArray objectAtIndex:eventObjectIndex];//get the obj at index
		NSString* objectId = [NSString stringWithFormat:@"%d",[[sortedGroupEventObjectArray objectAtIndex:eventObjectIndex] ItemId] ]; 
		NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:folioItem,nil];
		[dateDictionary setObject:localEventArray forKey:objectId];
		[localEventArray release];
		
		[dateKeyArray addObject:objectId];
//		
	}
	[sortedGroupEventObjectArray release];
	
	//sorting the key by date
	sortedDateKeyArray = [[NSArray alloc]initWithArray:[dateKeyArray sortedArrayUsingSelector:@selector(compare:)]];//check
	[dateKeyArray release];
	///////
	[folioArray release];

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
		case SummarySection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Summery_Icon];
			break;
		case ChargesSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Charges_Icon];
			break;
		case PaymentSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Payments_Icon];
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

	if(indexPath.section == SummarySection) //Summary
	{
		RSSummaryPage *mRSSummaryPage= [[RSSummaryPage alloc] initWithTitle:Club_Summary];
		[self.navigationController pushViewController:mRSSummaryPage animated:YES];
		mRSSummaryPage.navigationItem.title = Club_Summary;
		[mRSSummaryPage release];
		
	}
	else if(indexPath.section == ChargesSection)
	{
		NSString *viewTitle = [NSString stringWithFormat:AccOption_Chargesection_Title];      //on view title the view ll change for charge or payment
		NSArray *sLabelArray =[[NSArray alloc]initWithObjects:AccOption_Accountnum,
								   AccOption_AccountType,
								   AccOption_AccountOwner,
								   AccOption_StatementPeriod,
								   nil];
		
		NSString *statementPeriod = [NSString stringWithFormat:@"%@ - %@", appDelegate.clubStatementParser.clubStatement.stmtAccount.stmtBillingPeriod.periodStartDate,
									 appDelegate.clubStatementParser.clubStatement.stmtAccount.stmtBillingPeriod.billDate];
		
		
		NSArray *dLabelArray = [[NSArray alloc]initWithObjects:
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId],
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] classType],
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] statementCustomerName],
								
								statementPeriod,
								nil];
		NSMutableArray *objectArray = [[NSMutableArray alloc]init];  //to store the array of charege/payment objects
		
		[self dateSorting:appDelegate.clubStatementParser.clubStatement.stmtAccount.folioItems];
		
		for (int dateKeyIndex = 0; dateKeyIndex < [sortedDateKeyArray count]; dateKeyIndex++) {
			NSString * chargeDate = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] folioDate];
			
			NSString * objectLabel1 = [self stringFromDateWithoutYear:[self stringToDate:chargeDate]];
            
			NSString * objectLabel2 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] name];
            
			NSString * objectLabel3 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] totalPrice];
            
			NSArray *objectLabels = [[NSArray alloc]initWithObjects:objectLabel1,objectLabel2,objectLabel3,nil];
            
			NSString *ObjectDescription = [NSString stringWithFormat:@"your expences are"];
            
			RSChargeObject *mRSChargeObject = [[RSChargeObject alloc]initWtihObjectLabels:objectLabels withChargeDescription:ObjectDescription];
	
			[objectArray addObject:mRSChargeObject];
		
			[objectLabels release];
			[mRSChargeObject release];
		}
		
		RSChargeAndPaymentViewController *mRSChargeViewController = [[RSChargeAndPaymentViewController alloc]
                                        initWithTitle:viewTitle
                                        WithConstLabelText:sLabelArray
                                        DynamicTextLabels:dLabelArray
                                        objectArrays:objectArray];
		mRSChargeViewController.navigationItem.title = Club_Charges;
		[self.navigationController pushViewController:mRSChargeViewController animated:YES];
		
		[sLabelArray release];
		[dLabelArray release];
		[objectArray release];
		[mRSChargeViewController release];
		
	}
	else if(indexPath.section == PaymentSection)
	{
		
// eg for payment
		NSString *viewTitle = [NSString stringWithFormat:AccOption_Paymentsection_Title];    //depend on view title,the view ll change for charge or payment
		
		NSArray *sLabelArray =[[NSArray alloc]initWithObjects:AccOption_Accountnum,
							   AccOption_AccountType,
							   AccOption_AccountOwner,
							   AccOption_StatementPeriod,
							   nil];
		
		NSString *statementPeriod = [NSString stringWithFormat:@"%@ - %@", appDelegate.clubStatementParser.clubStatement.stmtAccount.stmtBillingPeriod.periodStartDate,
									 appDelegate.clubStatementParser.clubStatement.stmtAccount.stmtBillingPeriod.billDate];
		
		
		NSArray *dLabelArray = [[NSArray alloc]initWithObjects:
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId],
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] classType],
								[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] statementCustomerName],
								
								statementPeriod,
								nil];
		
		NSMutableArray *objectArray = [[NSMutableArray alloc]init];  //to store the array of charege/payment objects

		[self dateSorting:appDelegate.clubStatementParser.clubStatement.stmtAccount.folioPayments];

		for (int dateKeyIndex = 0; dateKeyIndex < [sortedDateKeyArray count]; dateKeyIndex++)
		{
			NSString * objectLabel1 = [self stringFromDateWithoutYear:[self stringToDate:[[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] folioDate]]];
			NSString * objectLabel2 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] label];			
			NSString * objectLabel3 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] amount];

			NSArray *objectLabels = [[NSArray alloc]initWithObjects:objectLabel1,objectLabel2,objectLabel3,nil];
			NSString *ObjectDescription = [NSString stringWithFormat:@"your expences are"];
			RSChargeObject *mRSChargeObject = [[RSChargeObject alloc]initWtihObjectLabels:objectLabels withChargeDescription:ObjectDescription];
			
			[objectArray addObject:mRSChargeObject];
			
			[objectLabels release];
			[mRSChargeObject release];
		}  

		RSChargeAndPaymentViewController *mRSChargeViewController = [[RSChargeAndPaymentViewController alloc] initWithTitle:viewTitle
        WithConstLabelText:sLabelArray
        DynamicTextLabels:dLabelArray
        objectArrays:objectArray];
		mRSChargeViewController.navigationItem.title = Club_Payments;
        [self.navigationController pushViewController:mRSChargeViewController animated:YES];
          
		[sLabelArray release];
		[dLabelArray release];
		[objectArray release];
		[mRSChargeViewController release];
/////////////////

		
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
	NSString* firstPart = [NSString stringWithFormat:@"From %@ to ",firstDate];
	
	
	return [NSString stringWithFormat:@"%@ %@",firstPart,lastDate];
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
	
	if (sortDescriptor) {
		[sortDescriptor release];
	}
	if (dateDictionary) {
		[dateDictionary removeAllObjects];
		[dateDictionary release];
	}	
    [sortedDateKeyArray release];
    [super dealloc];
}


@end

