//
//  RSListAccountsViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSListAccountsViewController.h"
#import "RSTableView.h"
#import "MapViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMainViewController.h"
#import "RSAccountActivityViewController.h"

#import "RSStatementOptionViewController.h"
#import "RSChargeObject.h"
#import "RSClubStatementParser.h"
#import "RSProfile.h"

#import "RSClubStatementParser.h"
#import "RSClubBillingHistoryParser.h"
#import "ResortSuiteAppDelegate.h"

@implementation RSListAccountsViewController

@synthesize clubStatementParser;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyAccount_HI controller:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:AccountList_ViewTilte fontSize:nil];

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

    //to display the type of Account class a user holds
	for(int accountIndex=0; accountIndex< [appDelegate.myAccParser.clubAccounts.accounts count]; accountIndex++)
	{
		[mainFieldArray addObject:[NSString stringWithFormat:@"%@ Membership",[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:accountIndex] classType]]];
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
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];
}

-(void)signInOutButtonAction:(id)sender
{
	if (appDelegate.isLoggedIn) {
		[appDelegate.mainVC showLogoutAlert];		
	}
	else 
	{
		[appDelegate.mainVC showLoginPopup];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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

	//Store the text content for the cell
	[cell.cellLable setFrame:LisAccountLabel];

	//Create a lable to display the content in the cell
	cell.cellLable.text = mainfield;

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	if(appDelegate.isLoggedIn)
	{
		appDelegate.currentAccountID = indexPath.section;

		RSAccountActivityViewController *mRSAccountActivityViewController = [[RSAccountActivityViewController alloc] init];
		[self.navigationController pushViewController:mRSAccountActivityViewController animated:YES];
		[mRSAccountActivityViewController release];	
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
	
    [super dealloc];
}


@end

