    //
//  RSSpaClassServiceVC.m
//  ResortSuite
//
//  Created by Cybage on 22/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaClassServiceVC.h"
#import "RSBookingTableView.h"
#import "ResortSuiteAppDelegate.h"
#import "RSSpaServiceBookingMainVC.h"
#import "ErrorPopup.h"
#import "RSBookingTableViewCell.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaClassBookingFormVC.h"
@implementation RSSpaClassServiceVC

@synthesize viewTitle;

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

-(id) initWithViewTitle:(NSString *) viewTitleString
{
	self.viewTitle = viewTitleString;
	return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",viewTitle] fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:ClassActivityCellText, @"Service", nil];
		
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	
	//Store the text content for the cell
	cell.textLabel.text = [mainFieldArray objectAtIndex:indexPath.row];

	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
	
	//Set the accessory view
	[cell setAccessoryViewImage:YES];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

	//Get the selected Spa location from the shared instance
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
	
	if (indexPath.row == ClassSection) {
		NSLog(@"Load Class VC");        
        RSSpaClassBookingFormVC * spaClassBookingMainVC = [[RSSpaClassBookingFormVC alloc] initWithViewTitle:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName]];
        [self.navigationController pushViewController:spaClassBookingMainVC animated:YES];
        [spaClassBookingMainVC release];
	}
	else if (indexPath.row == ServiceSection) {			
		NSLog(@"Load Service VC");
		
		RSSpaServiceBookingMainVC *spaServiceBookingMainVC = [[RSSpaServiceBookingMainVC alloc] 
					initWithViewTitle:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName]];
		[self.navigationController pushViewController:spaServiceBookingMainVC animated:YES];
		[spaServiceBookingMainVC release];
	}
}

@end
