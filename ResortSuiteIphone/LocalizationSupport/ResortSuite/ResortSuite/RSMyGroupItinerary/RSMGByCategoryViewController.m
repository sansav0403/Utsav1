    //
//  RSMGByCategoryViewController.m
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMGByCategoryViewController.h"

#import "RSTableView.h"
#import "RSGroupEvents.h"
#import "RSTableViewCell.H"
#import "RSMGByCategoryDetailScreenView.h"
@implementation RSMGByCategoryViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	[ResortSuiteAppDelegate setCurrentScreenImage:GroupItineraryByCategory_HI controller:self];
	
	GroupEventArray = [[NSArray alloc]initWithArray:appDelegate.myItineraryParser.guestItinerary.groupEvents.groupEventsArr];
	

	//create the dictionary with date as keys	
	categoryKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	categoryDictionary = [[NSMutableDictionary alloc]init];
	for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)	//geting obj from the sorted event objs
	{
		NSArray *lkeyArray = [categoryDictionary allKeys];
		GroupEvent *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
		NSString *keycategory = groupEvent.eventCategory;	//to act as akey 

		
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
    [GroupEventArray release];
	[categoryKeyArray release];
	[sortedcategoryKeyArray release];
	[categoryDictionary release];
	[super dealloc];
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
    }
	
	// Configure the cell...
	
	//Store the text content for the cell
	[cell.cellLable setFrame:CGRectMake(15, 25, 300, 20)];
	
	cell.cellLable.text = [categoryKeyArray objectAtIndex:indexPath.section];
	
	
    return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
			
	RSMGByCategoryDetailScreenView *mRSMGByCategoryDetailScreenView = [[RSMGByCategoryDetailScreenView alloc]
															   initWithArray:[categoryDictionary objectForKey:[categoryKeyArray objectAtIndex:indexPath.section]]];
	
	[self.navigationController pushViewController:mRSMGByCategoryDetailScreenView animated:YES];
	mRSMGByCategoryDetailScreenView.navigationItem.title = GroupTableViewTitle;
	[mRSMGByCategoryDetailScreenView release];
	
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
