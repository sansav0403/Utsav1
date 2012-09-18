    //
//  RSSpaStaffSeletionVC.m
//  ResortSuite
//
//  Created by Cybage on 11/10/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaStaffSeletionVC.h"
#import "ResortSuiteAppDelegate.h"
#import "RSSelectedSpaLocation.h"
#import "RSBookingTableView.h"
#import "RSBookingTableViewCell.h"

@implementation RSSpaStaffSeletionVC

@synthesize prefStaffNames;

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

-(id) initWithSection:(int) section prefStaffs:(NSArray *) prefstaffs
{
	pickerType = section;
	self.prefStaffNames = prefstaffs;
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self 
													  text:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName] 
												  fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	if (pickerType == PrefStaffGenderPicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormStafGender,nil];
	}
	else if (pickerType == PrefStaffPicker)
	{
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormStaff,nil];
	}		

	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, nil];  // by deafult no pref in sub array
      //thus when button is selected without selecting from picker.No pref is passed via notification.
		
	if (prefStaffGenders) {
		[prefStaffGenders removeAllObjects];
		[prefStaffGenders release];
	}	
	prefStaffGenders = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, SpaBookingStaffMale, SpaBookingStaffFemale, nil];
	
	//Add UI controls to the view
	[self addControlsToView];
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
	[prefStaffNames release];
	
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
		cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	
	//Store the text content for the cell
	cell.textLabel.text = [mainFieldArray objectAtIndex:indexPath.row];	
    
	cell.detailTextLabel.text = [subFieldArray objectAtIndex:indexPath.row];
	
	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
	
	//Set the accessory view 
	[cell setAccessoryViewImage:NO];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerType == PrefStaffGenderPicker) {
		return 3;
	}
	else if (pickerType == PrefStaffPicker) {
		return [prefStaffNames count];
	}
	return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerType == PrefStaffGenderPicker) {
		return [prefStaffGenders objectAtIndex:row];
	}
	else if (pickerType == PrefStaffPicker) {
		return [prefStaffNames objectAtIndex:row];
	}
	return @"";
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
	[subFieldArray removeObjectAtIndex:0];
	
	if (pickerType == PrefStaffGenderPicker) {		
		[subFieldArray insertObject:[prefStaffGenders objectAtIndex:row] atIndex:0];
	}
	else if (pickerType == PrefStaffPicker) {
		[subFieldArray insertObject:[prefStaffNames objectAtIndex:row] atIndex:0];
	}
	searchButton.enabled = YES;
	[mainTableView reloadData];
}

-(void) addControlsToView
{
	//Display label to the view
	UILabel *instructionLabel = [[UILabel alloc] initWithFrame:InstructionLabelFrame];
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	//Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	//Add the Staff Gender / Names picker
	prefStaffPicker = [[UIPickerView alloc] initWithFrame:PickerFrame];			
	prefStaffPicker.hidden = NO;
	prefStaffPicker.showsSelectionIndicator = YES;
	prefStaffPicker.delegate = self;
	[self.view addSubview:prefStaffPicker];
	[prefStaffPicker release];
		
	//Add Search Button
	searchButton = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[searchButton setBackgroundColor:[UIColor clearColor]];
	//searchButton.enabled = NO;
    searchButton.enabled = YES;
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:Disabled_Select_button];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:Enabled_Select_button];
	
	[searchButton setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
	[searchButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
	
	[self.view addSubview:searchButton];
	[searchButton release];

	
	//Action for fetching the Spa Classes
	[searchButton addTarget:self action:@selector(selectPrefStaffGenderOrName:) 
		   forControlEvents:UIControlEventTouchUpInside];

}

//Send the staff gender or name selection
-(void) selectPrefStaffGenderOrName: (id) sender
{
	//Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"StaffPickerValueChanged" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
