    //
//  RSListViewController.m
//  ResortSuite
//
//  Created by Cybage on 27/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSListViewController.h"
#import "RSTableView.h"
#import "RSTableViewCell.h"
#import "RSListViewNode.h"
#import "RSDetailsPageViewController.h"
#import "MapViewController.h"
#import "RSMainViewController.h"
#import "Gallery.h"
#import "RSDetailPageWithoutHeaderVC.h"

@implementation RSListViewController

@synthesize viewTitle, headerImage, dictionaryArray;

-(id)initViewWithNode:(RSListViewNode *)node
{
	self = [super init];
	if (self) {
		self.viewTitle = node.nodeTitle;
		self.headerImage = node.nodeHeader_Image;
		self.dictionaryArray = node.nodeDictionaryArray;
	}
	
	return self;
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[ResortSuiteAppDelegate setCurrentScreenImage:self.headerImage controller:self];
	self.title = self.viewTitle;
    //set the tab bar title
#if defined(HOTEL_VERSION)
    [[[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB] tabBarItem].title = RSMyHotelTabTitle;
#elif defined(CLUB_VERSION)
    [[[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB] tabBarItem].title = RSMyClubTabTitle;
#endif
	//Crete a table from custom table view
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
}

- (void)viewWillAppear:(BOOL)animated {	
	ResortSuiteAppDelegate* appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self.navigationController.visibleViewController];
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
    return [dictionaryArray count];
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
    
	//Create a lable to display the content in the cell
	cell.cellLable.text = [[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key];
	
	//Create a image thumbnail which will come under each cell
	cell.cellImageView.image = [UIImage imageNamed:[[dictionaryArray objectAtIndex:indexPath.section] objectForKey:Plist_Thumbnail_Image_Key]];
	
	//Use to do masking of cell image
	[cell DoMaskingOnCellImage];
	
	//Edit accessory view for directional button
//	if ([[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] != nil)
//	{
//		[cell EditAccessoryView];
//	}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	//Adding selected mask image to the selected row.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [RSTableViewCell DoMaskingOnSelectedCellImage:cell];
    
	if ([[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] != nil)
	{
		//To display Map on the screen, use Map View controller.
		if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]isEqualToString:@"Map"]) {
            //get array of dictionary for location
            NSArray *plistlocationArray = [[NSArray alloc]initWithArray:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"Locations"]];
            NSString *infoPage = [[NSString alloc]initWithString:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"Info"]];
            NSString *infoPageTitle = [[NSString alloc]initWithString:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"InfoTitle"]];
            NSLog(@"info page = %@",infoPage);
			MapViewController *mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
            mapVC.locationArray = plistlocationArray;
            mapVC.InfoButtonPageName = infoPage;
            mapVC.InfoButtonPageTitle = infoPageTitle;
			[self.navigationController pushViewController:mapVC animated:YES];
            [plistlocationArray release];
            [infoPage release];
            [infoPageTitle release];
			[mapVC release];
            
		}
		else if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]isEqualToString:@"Gallery"]) {
			Gallery *galleryVC = [[Gallery alloc] init];
			[self.navigationController pushViewController:galleryVC animated:YES];
			[galleryVC release];
		}		
		else {
            //check if to load detail with or without header image
            if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key] isEqualToString:@""]) {
                RSDetailPageWithoutHeaderVC *detailPageWithoutHeader = [[RSDetailPageWithoutHeaderVC alloc]initWithNibName:@"RSDetailPageWithoutHeaderVC" bundle:[NSBundle mainBundle] viewTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] content:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]];
                [self.navigationController pushViewController:detailPageWithoutHeader animated:YES];
                [detailPageWithoutHeader release];
            }
            else{
			RSDetailsPageViewController *detailPage = [[RSDetailsPageViewController alloc]
                                                       initWithNibName:@"RSDetailsPageViewController" 
                                                                bundle:nil
                                                            viewTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
                                                            viewImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key] 
                                                            content:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] ];
			[self.navigationController pushViewController:detailPage animated:YES];
			[detailPage release];
            }
		}

	}
	else 
	{
		RSListViewNode *nextNode = [[RSListViewNode alloc]initWithTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
												HeaderImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key]
												  IConImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Thumbnail_Image_Key]
												  NodeArray:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DictionaryArray_Key] ];
		
		RSListViewController * nextListController = [[RSListViewController alloc]initViewWithNode:nextNode];
		[self.navigationController pushViewController:nextListController animated:YES];
		[nextListController release];
		[nextNode release];
			
		
	}


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
	[viewTitle release];
	[headerImage release];
	[dictionaryArray release];
    [super dealloc];
}


@end
