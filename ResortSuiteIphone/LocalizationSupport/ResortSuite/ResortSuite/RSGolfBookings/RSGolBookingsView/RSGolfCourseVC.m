    //
//  RSGolfCourseVC.m
//  ResortSuite
//
//  Created by Cybage on 23/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

/*
 Shows the glof locations
 */
#import "RSGolfCourseVC.h"
#import "RSBookingTableView.h"
#import "ResortSuiteAppDelegate.h"
#import "RSGolfLocationsParser.h"
#import "RSGolfLocations.h"
#import "RSBookingTableViewCell.h"

#import "RSSelectedSpaLocation.h"

#import "RSGolfCourseBookingVC.h"
#import "RSSelectedGolfLocation.h"
@implementation RSGolfCourseVC

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:GolfLocation_ViewTilte fontSize:nil];	
	
    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
    if (self.navigationController.delegate == nil) 
    {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithArray:appDelegate.golfLocationsParser.golfLocationsModel.golfLocations];
	DLog(@"location names = %@ : %@", [[mainFieldArray objectAtIndex:0] locationName],[[mainFieldArray objectAtIndex:1] locationName]);
	//Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
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
    [mainFieldArray release];   
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [mainFieldArray count];
}


// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       	
	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell...
	
	//Store the text content for the cell
	NSString *mainfield = [[mainFieldArray objectAtIndex:indexPath.row] locationName];
	cell.textLabel.text = mainfield;
	
	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
    
    //Set the accessory view
	[cell setAccessoryViewImage:YES];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];        
    location.golfLocation = [appDelegate.golfLocationsParser.golfLocationsModel.golfLocations objectAtIndex:indexPath.row];

    RSGolfCourseBookingVC *golfcourseTable = [[RSGolfCourseBookingVC alloc]initWithGolflocationID:[location.golfLocation.locationId intValue]];
    [self.navigationController pushViewController:golfcourseTable animated:YES];
    [golfcourseTable release];
}


#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}	
	
	if ([parserModelData isKindOfClass:[Result class]]) {
		//[self showErrorMessage:parserModelData];
	}
}

@end
