    //
//  RSSpaClassTableViewController.m
//  ResortSuite
//
//  Created by Cybage on 03/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaClassTableViewController.h"
#import "RSSpaServiceTableCell.h"
#import "RSChargeTableCellLabel.h"
#import "customAccesoryButton.h"
#import "RSSpaClass.h"
#import "RSSpaClassDescVC.h"
#import "SoapRequests.h"
#import "ResortSuiteAppDelegate.h"
#import "RSMainViewController.h"
#import "RSSpaCustomerConflictBookingsParser.h"
#import "RSSpaCustomerConflictingBookings.h"
#import "ErrorPopup.h"
#import "RSSelectedSpaLocation.h"


#define SeriveTableColLabelYcord  titleLabelCord_y+titleLabelCord_height
#define serviceTableYcord  SeriveTableColLabelYcord + 48

@implementation RSSpaClassTableViewController

@synthesize spaClasses;
@synthesize spaCustomerConflictBookingsParser;

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

-(id)initWithSpaClassArray:(NSArray *)spaClassesArray
{
    self = [super init];
    if (self) {
        self.spaClasses = spaClassesArray;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self 
													  text:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName] 
												  fontSize:nil]; 
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, titleLabelCord_y, titleLabelCord_width, titleLabelCord_height)];
	titleLabel.backgroundColor = [UIColor whiteColor];
	titleLabel.opaque = YES;
	titleLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
	[titleLabel setText:searchResultText];
	[self.view addSubview:titleLabel];
	[titleLabel release];
	
	tableColumnTitles = [[NSArray alloc]initWithObjects:ClassActivityCellText,ClassServiceTableCol_StartTimeLbl,ClassServiceTableCol_PriceLbl,ClassServiceTableCol_TimeLbl, nil];
	    
    [self drawTableColumnTitleWithTitleArray:tableColumnTitles AtYCord: SeriveTableColLabelYcord];   //width of searchbar
    [self drawSeperatorImageAtYCord:serviceTableYcord-dot_height];
	
	//Crete a table from custom table view
	mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, serviceTableYcord, Screen_Width, serviceTableHeight)];
	[mainTableView setDelegate:self];
	[mainTableView setDataSource:self];
	mainTableView.allowsSelection = YES;
    mainTableView.showsVerticalScrollIndicator = YES;
	
	[mainTableView setBounces:YES];
	[mainTableView setBackgroundColor:[UIColor clearColor]];
	[mainTableView setSeparatorColor:[UIColor clearColor]];
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	
	// add select button, note: new y is already calculated
	
    [self AddSelectButtonWithTag:0];
	selectButton.enabled = NO;

}

-(void)AddSelectButtonWithTag:(int)rowinfo
{
    // add booking button note new y is already calculated
	selectButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
	[selectButton setBackgroundColor:[UIColor clearColor]];	
    selectButton.tag = rowinfo;
    
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Select_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Select_button];
	
	[selectButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[selectButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    //
    [selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    [selectButton release];
    
}

-(void)selectAction:(id)sender     //post notification
{
    UIButton *tempButton = (UIButton *)sender;
    DLog(@"ttempButton tag = %d",tempButton.tag);
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"spaClassSelected" object:[spaClasses objectAtIndex:tempButton.tag]];    //send the object as notification obj

    if (appDelegate.bookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.bookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }

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
	[spaClasses release];	
	[spaCustomerConflictBookingsParser release];
	
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
    return [self.spaClasses count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    RSSpaServiceTableCell *locationCell = (RSSpaServiceTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (locationCell == nil) {
        locationCell = [[[RSSpaServiceTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secondField:YES] autorelease];
	}
 
    RSSpaClass *selectedClass = (RSSpaClass *)[self.spaClasses objectAtIndex:indexPath.row];
    
    locationCell.fieldLabel1.text = [selectedClass spaItemName];	
	locationCell.fieldLabel2.text = [self getTimeFromString:[selectedClass startTime]];
	locationCell.fieldLabel3.text = [NSString stringWithFormat:@"%.02f", [selectedClass price]];
	locationCell.fieldLabel4.text = [NSString stringWithFormat:@"%.0f",[selectedClass serviceTime]];
    
	customAccesoryButton *dButton = [[customAccesoryButton alloc] initWithFrame:CellAccessoryImageSize];
	[dButton setBackgroundColor:[UIColor clearColor]];
	UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CellAccessoryImageSize ];
	btnImage.image  = [UIImage imageNamed:CellAccessoryImageCircular];
	[dButton addSubview:btnImage];
	[btnImage release];
	
	dButton.path = indexPath;
	[dButton addTarget:self action:@selector(checkThis:) forControlEvents:UIControlEventTouchDown];
	
	[locationCell setAccessoryView:dButton];	
    [dButton release];  // was not released after adding to view
	UIImageView *selectionBackground = [[UIImageView alloc] init];
	selectionBackground.image = [UIImage imageNamed:accessoryBlankImage];
	locationCell.selectedBackgroundView = selectionBackground;
	[selectionBackground release];
       
    return locationCell;
}

-(void)checkThis:(id)sender
{
    customAccesoryButton *button = (customAccesoryButton *)sender;
    NSIndexPath *indexPath = button.path;
    	
    RSSpaClassDescVC *spaClassDescVC = [[RSSpaClassDescVC alloc] initWithSelectedClass:
										[self.spaClasses objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:spaClassDescVC animated:YES];
    [spaClassDescVC release];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

	selectButton.enabled = YES;
    selectButton.tag = indexPath.row;
    
	selectedSpaClassIndex = indexPath.row;	
}


#pragma mark UI layouts

-(void)drawSeperatorImageAtYCord:(float)ycord 
{
	UIImageView *seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - dot_width)/2,  ycord, dot_width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[self.view addSubview:seperatorImage];
	[seperatorImage release];
}

-(void)drawTableColumnTitleWithTitleArray:(NSArray *)titleArray AtYCord:(float)ycord
{
	
	//run a loop and set each frame and text from array
    for (int i = 0; i< [titleArray count]; i++)
    {
		RSChargeTableCellLabel *label = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
        if (i == 0) {
            label.frame = CGRectMake(10, ycord, label1Width, label3_4Height); //label3_4Height 30
            label.numberOfLines = 1;						   //For "Class"
        }
		else if (i == 1) {
			label.frame = CGRectMake(90, ycord, 50, label1_2Height*1.5); 
            label.numberOfLines = 2;
            [label setTextAlignment:UITextAlignmentRight];    //For "Start Time"
        }
        else if (i == 2) {
            label.frame = CGRectMake(label3_XCord, ycord, label3Width, label3_4Height); 
            label.numberOfLines = 1;
            [label setTextAlignment:UITextAlignmentRight];    //For "Price"
        }
        else if (i == 3) {
            label.frame = CGRectMake(label4_XCord, ycord, label4Width, label3_4Height*1.5); 
            label.numberOfLines = 2;						   //For "Time"
        }
        label.text = [titleArray objectAtIndex:i];
        [self.view addSubview:label];
        [label release];
    }
    
}


#pragma mark Set Date Format

-(NSString *) getTimeFromString:(NSString *) dateString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy hh:mm a"];	
	
	NSDate *startTime = (NSDate *) [dateFormatter dateFromString:dateString];
	[dateFormatter setDateFormat:@"HH:mm a"];
	
	NSString *startTimeStr = [dateFormatter stringFromDate:startTime];
	[dateFormatter release];
	
	return startTimeStr;
}

@end
