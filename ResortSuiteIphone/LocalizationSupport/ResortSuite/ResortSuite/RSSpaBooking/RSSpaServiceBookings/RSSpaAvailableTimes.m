    //
//  RSSpaAvailableTimes.m
//  ResortSuite
//
//  Created by Cybage on 17/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaAvailableTimes.h"
#import "RSSpaAvailibility.h"
#import "RSSpaService.h"
#import "RSSpaConfirmationView.h"
#import "RSBookingTableView.h"


@implementation RSSpaAvailableTimes

@synthesize availableTimes;
@synthesize spaServiceSelected;
@synthesize selectedStaffName;
@synthesize selectedStaffGender;	


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

    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:SpaAvailableTimes fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	//Add instruction label
	instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 43, 298, 57)];
	instructionLabel.text = SpaAvailableTimeText;
	instructionLabel.numberOfLines = 3;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:RSCBCTiltleLabelFont]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	//Add table with available times
    if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:90];

	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	
	[self.view addSubview:mainTableView];
	[mainTableView release];
}

-(id) initWithAvailableTimes:(NSArray *)times forSelectedSpaService:(RSSpaService *)spaService
                WithSelectedStaff:(NSString *)staffName andGender:(NSString *)staffGender
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.availableTimes = times;
		self.spaServiceSelected = spaService;
		self.selectedStaffName = staffName;
		self.selectedStaffGender = staffGender;
    }
    return self;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[availableTimes release];
	[spaServiceSelected release];
	
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
    return [availableTimes count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	
	RSSpaAvailibility *spaAvailability = [availableTimes objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [spaAvailability.startTime substringFromIndex:[spaAvailability.startTime length] -8];

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
    DLog(@"golf course selected");    
 
	RSSpaConfirmationView *spaConfirmationView = [[RSSpaConfirmationView alloc] 
												  initWithSpaAvailibilityArray:[NSArray arrayWithObject:[self.availableTimes objectAtIndex:indexPath.row]]
												  forSelectedSpaService:self.spaServiceSelected
												  WithSelectedStaff:self.selectedStaffName andGender:self.selectedStaffGender];
	[selectedStaffName release];
	[selectedStaffGender release];
	
	[self.navigationController pushViewController:spaConfirmationView animated:YES];
	[spaConfirmationView release];	
	
}


@end