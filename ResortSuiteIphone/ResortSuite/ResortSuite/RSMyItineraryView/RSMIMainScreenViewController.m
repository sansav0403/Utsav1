//
//  RSMIMainScreenViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIMainScreenViewController.h"
#import "RSDetailsPageViewController.h"
#import "RSTableView.h"
#import "RSMIDateScreenViewController.h";
#import "RSMIDateSelectionViewController.h"
#import "MapViewController.h"
#import "RSMIByCategoryViewController.h"
#import "RSMainViewController.h"
#import "RSMIByCategoryDetailScreenView.h"
#import "ResortSuiteAppDelegate.h"
#import "ErrorPopup.h"

@implementation RSMIMainScreenViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
    [super viewDidLoad];
	[ResortSuiteAppDelegate setCurrentScreenImage:MyItinerary_HI controller:self];
	self.navigationItem.title = MyItitnerary_ViewTite;
	
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
		[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
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
		case ByDateSection:
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByDate_Icon];
			break;
		case ByCategorySection:
#if defined(HOTEL_VERSION)
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByCategory_Icon];
#elif defined(CLUB_VERSION)
			cell.cellImageView.image = [UIImage imageNamed:Club_MyItineraryByCategory_Icon];
#endif
			
			break;
		case AllSection:
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
   
    //Adding selected mask image to the selected row.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [RSTableViewCell DoMaskingOnSelectedCellImage:cell];    

	if (appDelegate.connectedToInternet || appDelegate.myItineraryParser.guestItinerary) {
		if (appDelegate.isLoggedIn) {
			if(indexPath.section == ByDateSection)
			{
				RSMIDateScreenViewController *mRSMIDateScreenViewController = [[RSMIDateScreenViewController alloc] init];
				[self.navigationController pushViewController:mRSMIDateScreenViewController animated:YES];
				mRSMIDateScreenViewController.navigationItem.title = ItineraryCategory_ByDate;
				
				[mRSMIDateScreenViewController release];
			}
			else if(indexPath.section == ByCategorySection)
			{
				RSMIByCategoryViewController *mRSMICategoryScreenViewController = [[RSMIByCategoryViewController alloc] init];
				[self.navigationController pushViewController:mRSMICategoryScreenViewController animated:YES];
				
				mRSMICategoryScreenViewController.navigationItem.title = ItineraryCategory_ByCategory;
				
				[mRSMICategoryScreenViewController release];
			}
			else if(indexPath.section == AllSection)
			{
				RSMIByCategoryDetailScreenView *mRSMIAllDetailScreenView = [[RSMIByCategoryDetailScreenView alloc]
                                    initWithArray:appDelegate.myItineraryParser.guestItinerary.guestBookings.folios];
				
				[self.navigationController pushViewController:mRSMIAllDetailScreenView animated:YES];
				mRSMIAllDetailScreenView.navigationItem.title = ItineraryCategory_ByAll;
				
				[mRSMIAllDetailScreenView release];
			}
		}				
	}	
	else {
		[appDelegate.mainVC showOfflineAlert];
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

