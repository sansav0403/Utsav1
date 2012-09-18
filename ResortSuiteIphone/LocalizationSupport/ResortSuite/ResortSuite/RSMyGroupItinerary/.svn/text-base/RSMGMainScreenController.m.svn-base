//
//  RSMGMainScreenController.m
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//


#import "RSTableView.h"
#import "RSMGByDateScreenViewController.h"
#import "RSMGByCategoryViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSMGMainScreenController.h"
#import "MapViewController.h"
#import "RSMainViewController.h"
#import "RSMGByCategoryDetailScreenView.h"
#import "ResortSuiteAppDelegate.h"
#import "ErrorPopup.h"

@implementation RSMGMainScreenController

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:GroupItinerary_HI controller:self];
	self.navigationItem.title = MyGroup_ViewTilte;
	[ResortSuiteAppDelegate setContactUsIcon:YES];

//	if (self.navigationController.delegate == nil) {    //nav in date selectn is nav delegate
//		[self.navigationController setDelegate:self];
//	}
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:ItineraryCategory_ByDate,ItineraryCategory_ByCategory,ItineraryCategory_ByAll,nil];
	
	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	//---------------ADDING REFRESH BUTTON-----------------
	UIBarButtonItem *modalButton = nil;
	
	if ([viewController isKindOfClass:[RSMGMainScreenController class]])
	{
//		modalButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
//																					 target:self 
//																					 action:@selector(refreshButtonAction:)];		
//		
//		[viewController.navigationItem setRightBarButtonItem:modalButton animated:YES];
	}
	//---------------ADDING SignIn/Out BUTTON-----------------
	else {
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
	self.navigationItem.backBarButtonItem.title = BackButtonTitle;
	mainVC.isRefresh = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
		case ByDatesSection:
			cell.cellImageView.image = [UIImage imageNamed:GroupItineraryByDate_Icon];
			break;
		case ByCategoriesSecion:
			cell.cellImageView.image = [UIImage imageNamed:GroupItineraryByCategory_Icon];
			break;
		case AllEventsSection:
			cell.cellImageView.image = [UIImage imageNamed:GroupItinerary_Icon];
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
   
	if (appDelegate.myItineraryParser.guestItinerary.groupEvents.groupEventsArr) {
		//Adding selected mask image to the selected row.
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		[RSTableViewCell DoMaskingOnSelectedCellImage:cell];
		
		if (appDelegate.isLoggedIn) {
			if(indexPath.section == ByDatesSection)
			{
				RSMGByDateScreenViewController *mRSMGByDateScreenViewController = [[RSMGByDateScreenViewController alloc] init];
				[self.navigationController pushViewController:mRSMGByDateScreenViewController animated:YES];
				mRSMGByDateScreenViewController.navigationItem.title = ItineraryCategory_ByDate;
				
				[mRSMGByDateScreenViewController release];
			}
			else if(indexPath.section == ByCategoriesSecion)
			{
				RSMGByCategoryViewController *mRSMGByCategoryViewController = [[RSMGByCategoryViewController alloc] init];
				[self.navigationController pushViewController:mRSMGByCategoryViewController animated:YES];
				mRSMGByCategoryViewController.navigationItem.title = ItineraryCategory_ByCategory;
				
				[mRSMGByCategoryViewController release];
			}
			else if(indexPath.section == AllEventsSection)
			{
				RSMGByCategoryDetailScreenView *mRSMGAllDetailScreenView = [[RSMGByCategoryDetailScreenView alloc]
                            initWithArray:appDelegate.myItineraryParser.guestItinerary.groupEvents.groupEventsArr];
			
				[self.navigationController pushViewController:mRSMGAllDetailScreenView animated:YES];
				mRSMGAllDetailScreenView.navigationItem.title = @"All Events";
				[mRSMGAllDetailScreenView release];
			}
		}
	}
	else {
		UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle:nil
								   message:POPUP_Meeting_Data_Unavailable
								   delegate:self
								   cancelButtonTitle:POPUP_Button_Ok
								   otherButtonTitles:nil];
		[errorAlert show];
		[errorAlert release];
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

