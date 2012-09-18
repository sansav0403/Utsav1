//
//  RSAccountActivityViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSAccountActivityViewController.h"
#import "RSTableView.h"
#import "MapViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMainViewController.h"
#import "RSStatementBillingPeriodViewController.h"

#import "RSProfile.h"

@implementation RSAccountActivityViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyAccount_HI controller:self];
	
	self.navigationItem.title = Club_MyActivity;
	
	//
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}

	[ResortSuiteAppDelegate setContactUsIcon:YES];

	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:Club_ViewProfile,Club_ViewStatement,nil];

	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

//#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	//---------------ADDING SignIn/Out BUTTON-----------------
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
		case ProfileSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_MyAccount_List_Icon];
			break;
		case StatementSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_ViewStatement_Icon];
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
    if ([appDelegate.myAccParser.clubAccounts.accounts count] > 0)
    {  
        if(indexPath.section == ProfileSection) //Profile
        {
        RSProfile *mRSProfile = [[RSProfile alloc] initWithTitle:Club_Profile ];
        [self.navigationController pushViewController:mRSProfile animated:YES];
        mRSProfile.navigationItem.title = Club_Profile;
        [mRSProfile release];                

        }
        else if(indexPath.section == StatementSection)
        {
		RSStatementBillingPeriodViewController *mRSStatementBillingPeriodViewController = [[RSStatementBillingPeriodViewController alloc] init];
		[self.navigationController pushViewController:mRSStatementBillingPeriodViewController animated:YES];
		[mRSStatementBillingPeriodViewController release];
		

        }
    }
    else
    {
        UIAlertView *noAccountProfileAlert = [[UIAlertView alloc]
                                              initWithTitle:@""
                                              message:@"No Memebership found for the Guest"
                                              delegate:self //prev nil
                                              cancelButtonTitle:POPUP_Button_Ok
                                              otherButtonTitles:nil];  
        [noAccountProfileAlert show];
        [noAccountProfileAlert release];
        
    }


}
#pragma mark Handle event for OK button click
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clicked the OK button
	if (buttonIndex == [alertView cancelButtonIndex])
	{
		[self.navigationController popToRootViewControllerAnimated:YES];
        
		appDelegate.tabBarController.selectedIndex =0;
        //
        [[[appDelegate.tabBarController viewControllers]objectAtIndex:HOME_TAB]popToRootViewControllerAnimated:YES];
	}	
}
#pragma mark date Functions
-(NSString *)stringFromDate:(NSDate *)date
{
 	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"MMMM d, yyyy"];
	return [dateFormatter stringFromDate:date];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];  
	
	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return date;
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

