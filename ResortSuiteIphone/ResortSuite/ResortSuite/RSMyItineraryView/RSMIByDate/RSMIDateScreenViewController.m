    //
//  RSMIDateScreenViewController.m
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIDateScreenViewController.h"
#import "RSFolio.h"
#import "RSTableView.h"
#import "RSTableViewCell.h"
#import "RSByDateDetailScreenViewController.h"
@implementation RSMIDateScreenViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	[ResortSuiteAppDelegate setCurrentScreenImage:MyItineraryByDate_HI controller:self];

	
	NSArray *folioArray = [[NSArray	alloc]initWithArray:appDelegate.myItineraryParser.guestItinerary.guestBookings.folios];
	dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	dateDictionary = [[NSMutableDictionary alloc]init];
	for(int folioIndex=0; folioIndex<[appDelegate.myItineraryParser.guestItinerary.guestBookings.folios count]; folioIndex++)
	{
		NSArray *lkeyArray = [dateDictionary allKeys];
		RSFolio *folio = [folioArray objectAtIndex:folioIndex];//get the obj at index
		NSDate *keyDate = [self stringToDate:[self stringFromDate:[folio formatedStartDate]]];;	//to act as akey
				
		if ([lkeyArray containsObject:keyDate])
		{
			NSMutableArray *localEventArray = [dateDictionary objectForKey:keyDate];
			[localEventArray addObject:folio];
			[dateDictionary setObject:localEventArray forKey:keyDate];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:folio,nil];
			[dateDictionary setObject:localEventArray forKey:keyDate];
			[localEventArray release];
			[dateKeyArray addObject:keyDate];
		}

		
	}
	[folioArray release];
	
	//sorting the key by date
	sortedDateKeyArray = [[dateKeyArray sortedArrayUsingSelector:@selector(compare:)] retain];//check
	//
	
	mainTableView = [[RSTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	mainTableView.scrollEnabled = YES;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
}

-(NSString *)stringFromDate:(NSDate *)date
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
	return stringDate;
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];  

	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return date;
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
    return [sortedDateKeyArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.

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

-(void)checkThis:(UIButton*)sender{
	int indexRow = sender.tag;
	
	RSByDateDetailScreenViewController *mRSByDateDetailScreenViewController = [[RSByDateDetailScreenViewController alloc]
                                    initWithArray:[dateDictionary objectForKey:
                                                [sortedDateKeyArray objectAtIndex:indexRow]]];
    
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:mRSByDateDetailScreenViewController text:[self stringFromDate:[sortedDateKeyArray objectAtIndex:indexRow]] fontSize:nil];

	[self.navigationController pushViewController:mRSByDateDetailScreenViewController animated:YES];
	[mRSByDateDetailScreenViewController release];
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	RSByDateDetailScreenViewController *mRSByDateDetailScreenViewController = [[RSByDateDetailScreenViewController alloc]
                                                initWithArray:[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:indexPath.section]]];
    
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:mRSByDateDetailScreenViewController text:[self stringFromDate:[sortedDateKeyArray objectAtIndex:indexPath.section]] fontSize:nil];

	[self.navigationController pushViewController:mRSByDateDetailScreenViewController animated:YES];
	[mRSByDateDetailScreenViewController release];
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
	[dateDictionary release];
	[sortedDateKeyArray release];
	[dateKeyArray release];
	
	 [super dealloc];
}


@end
