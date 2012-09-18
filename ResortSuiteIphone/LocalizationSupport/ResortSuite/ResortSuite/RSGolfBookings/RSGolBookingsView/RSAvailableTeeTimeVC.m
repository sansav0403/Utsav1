//
//  RSAvailableTeeTimeVC.m
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSAvailableTeeTimeVC.h"

#import "SoapRequests.h"
#import "ErrorPopup.h"

#import "RSBookingTableViewCell.h"

#import "RSBookingTableView.h"

#import "RSGolfTeeTimesParser.h"
#import "RSGolfTeeTimes.h"

#import "RSGolfConfirmationView.h"
#import "RSMainViewController.h"

@implementation RSAvailableTeeTimeVC

@synthesize AvailableTeeTimeArray;
@synthesize selectedCourseId;
@synthesize selectedNoOfPlayers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTeeTimeArray:(NSArray *)TeeTime withSelectedCourseId:(NSString *)courseID andNoOfPlayer:(NSString *)players
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.AvailableTeeTimeArray = TeeTime;   
        self.selectedCourseId = courseID;
        self.selectedNoOfPlayers = players;

    }
    return self;
}

- (void)dealloc
{
    [AvailableTeeTimeArray release];
    [selectedCourseId release];
    [selectedNoOfPlayers release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:BookGolf_ViewTilte fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, Screen_Width, 40)];
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];


}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [AvailableTeeTimeArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
    RSGolfTeeTime *TeeTime = (RSGolfTeeTime *)[AvailableTeeTimeArray objectAtIndex:indexPath.row];
    NSString *DateString = TeeTime.dateTime;
    cell.textLabel.text = [DateString substringFromIndex:[DateString length] - 8];	

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
    RSGolfConfirmationView *golfConfirmation = [[RSGolfConfirmationView alloc]initWithSelectedTime:
                                                [[AvailableTeeTimeArray objectAtIndex:indexPath.row] dateTime] 
                                                andSelectedCourseID:self.selectedCourseId andSelectedPlayer:self.selectedNoOfPlayers];
    [self.navigationController pushViewController:golfConfirmation animated:YES];
    [golfConfirmation release];
}

@end
