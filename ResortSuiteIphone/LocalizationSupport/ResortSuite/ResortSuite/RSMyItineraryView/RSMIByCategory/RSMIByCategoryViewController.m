    //
//  RSMGByCategoryViewController.m
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIByCategoryViewController.h"

#import "RSTableView.h"
#import "RSGroupEvents.h"
#import "RSTableViewCell.H"
#import "RSMIByCategoryDetailScreenView.h"
@implementation RSMIByCategoryViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];

#if defined(HOTEL_VERSION)
	[ResortSuiteAppDelegate setCurrentScreenImage:MyItineraryByCategory_HI controller:self];
#elif defined(CLUB_VERSION)
	[ResortSuiteAppDelegate setCurrentScreenImage:Club_MyItineraryByCategory_HI controller:self];
#endif
	
	GroupEventArray = [[NSArray	alloc]initWithArray:appDelegate.myItineraryParser.guestItinerary.guestBookings.folios];

	//create the dictionary with date as keys	
	categoryKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	categoryDictionary = [[NSMutableDictionary alloc]init];

	for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)	//geting obj from the sorted event objs
	{
		NSArray *lkeyArray = [categoryDictionary allKeys];
		RSFolio *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
		
		NSString *keycategory;	//to act as akey 
		switch ([groupEvent appType]) {
			case Hotel:
				keycategory = Hotel_Itinerary_Title;    //in constant.h
				break;
			case Spa:
				keycategory = Hotel_SPA_Title;          //in teaserbuildconstant
				break;
			case Golf:
				keycategory = Hotel_GOLF_Title;         //in teaserbuildconstant
				break;
			case Dining:
				keycategory = Hotel_Dining_Title;       //in teaserbuildconstant
				break;
			case Transportation:
				keycategory = Hotel_Transportation_Title;   //in constant.h
				break;
			default:
				keycategory = @"";
				break;
		}
		
		if ([lkeyArray containsObject:keycategory])
		{
			NSMutableArray *localEventArray = [categoryDictionary objectForKey:keycategory];
			[localEventArray addObject:groupEvent];
			[categoryDictionary setObject:localEventArray forKey:keycategory];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
			[categoryDictionary setObject:localEventArray forKey:keycategory];
			[localEventArray release];
			[categoryKeyArray addObject:keycategory];
		}
				
	}
	
	//
	//sorting the key by date
	sortedcategoryKeyArray = [[NSArray alloc]initWithArray:[categoryKeyArray sortedArrayUsingSelector:@selector(compare:)]];//check

	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	mainTableView.scrollEnabled = YES;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
}
- (void)dealloc {
    [super dealloc];
	[GroupEventArray release];
	[categoryKeyArray release];
	[sortedcategoryKeyArray release];
	[categoryDictionary release];
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [categoryKeyArray count];
	
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
    RSTableViewCell *cell = (RSTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

		//Use to do masking of cell image
		[cell DoMaskingOnCellImage];
    }
	
	// Configure the cell...
    
	
//	//Store the text content for the cell
//	[cell.cellLable setFrame:CGRectMake(15, 10, 300, 30)];
	
	cell.cellLable.text = [categoryKeyArray objectAtIndex:indexPath.section];
	
	//Create a image thumbnail which will come under each cell
	if([cell.cellLable.text isEqualToString:Hotel_Itinerary_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_MyHotel_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_MyClub_Icon];
#endif
	}
	else if([cell.cellLable.text isEqualToString:Hotel_SPA_Title])
	{
	#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_SPA_Icon];
	#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_SPA_Icon];
	#endif
		
	}
	else if([cell.cellLable.text isEqualToString:Hotel_GOLF_Title])
	{
	#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_GOLF_Icon];
	#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_GOLF_Icon];
	#endif
		
	}
	else if([cell.cellLable.text isEqualToString:Hotel_Dining_Title])
	{
	#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_Dining_Icon];
	#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_Dining_Icon];
	#endif		
	}
	else if([cell.cellLable.text isEqualToString:Hotel_Transportation_Title])
	{
	#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Transportation_Icon];
	#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Transportation_Icon];
	#endif		
	}
	
    return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
			
	RSMIByCategoryDetailScreenView *mRSMIByCategoryDetailScreenView = [[RSMIByCategoryDetailScreenView alloc]
															   initWithArray:[categoryDictionary objectForKey:[categoryKeyArray objectAtIndex:indexPath.section]]];
	
	[self.navigationController pushViewController:mRSMIByCategoryDetailScreenView animated:YES];
	
	mRSMIByCategoryDetailScreenView.navigationItem.title = [categoryKeyArray objectAtIndex:indexPath.section];
	
	[mRSMIByCategoryDetailScreenView release];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
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

@end
