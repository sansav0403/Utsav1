    //
//  RSMGByDateScreenViewController.m
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
#import "RSTableView.h"
#import "RSTableViewCell.h"
#import "RSGroupEvents.h"
#import "RSMGByDateDetailScreenView.h"

#import "RSMGByDateScreenViewController.h"


@implementation RSMGByDateScreenViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	[ResortSuiteAppDelegate setCurrentScreenImage:GroupItineraryByDate_HI controller:self];
	
	GroupEventArray = [[NSArray alloc]initWithArray:appDelegate.myItineraryParser.guestItinerary.groupEvents.groupEventsArr];

	//create the dictionary with date as keys	
	dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	dateDictionary = [[NSMutableDictionary alloc]init];
	
	for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)
	{
		NSArray *lkeyArray = [dateDictionary allKeys];
		GroupEvent *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
		NSDate *keyDate = [self stringToDate:[self stringFromDate:[groupEvent formatedStartTime]]];	//to act as akey get only the date

		if ([lkeyArray containsObject:keyDate])
		{
			NSMutableArray *localEventArray = [dateDictionary objectForKey:keyDate];
			[localEventArray addObject:groupEvent];
			[dateDictionary setObject:localEventArray forKey:keyDate];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
			[dateDictionary setObject:localEventArray forKey:keyDate];
			[localEventArray release];
			[dateKeyArray addObject:keyDate];
		}	
	}

	//sorting the key by date
	sortedDateKeyArray = [[NSArray alloc]initWithArray:[dateKeyArray sortedArrayUsingSelector:@selector(compare:)]];//check
	
	
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	mainTableView.scrollEnabled = YES;
	[self.view addSubview:mainTableView];
	[mainTableView release];	
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

- (void)dealloc {
   	[GroupEventArray release];
	[dateDictionary release];
	[sortedDateKeyArray release];
	[dateKeyArray release];
	
	 [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sortedDateKeyArray count];
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
	
	cell.cellLable.text = [self stringFromDate:[sortedDateKeyArray objectAtIndex:indexPath.section]];
	
    return cell;	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	RSMGByDateDetailScreenView *mRSMGByDateDetailScreenView = [[RSMGByDateDetailScreenView alloc]
                                    initWithArray:[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:indexPath.section]]];
	
	[self.navigationController pushViewController:mRSMGByDateDetailScreenView animated:YES];
	mRSMGByDateDetailScreenView.navigationItem.title = GroupTableViewTitle;
	[mRSMGByDateDetailScreenView release];
}


#pragma mark date Functions
-(NSString *)stringFromDate:(NSDate *)date
{
 	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];

	return [dateFormatter stringFromDate:date];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];  	
	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];

	return date;
}

@end
