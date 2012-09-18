//
//  RSPlayerSelectionVC.m
//  ResortSuite
//
//  Created by Cybage on 10/11/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSPlayerSelectionVC.h"

#import "RSSelectedGolfLocation.h"
#import "RSBookingTableViewCell.h"
@implementation RSPlayerSelectionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [NoPlayersArray release];
    [mainFieldArray release];
    [subFieldArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NoPlayersArray = [[NSArray alloc]initWithObjects:@"                      1",@"                      2",@"                      3",@"                      4" ,nil];
    
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    
	RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self 
													  text:[NSString stringWithFormat:@"Book %@", location.golfLocation.locationName] 
												  fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
    mainFieldArray = [[NSMutableArray alloc] initWithObjects:NoOfPlayerCellText,nil];	
    
    if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
    
     subFieldArray = [[NSMutableArray alloc] initWithObjects:DefaultNoOfPlayers,nil]; //no of plyaer = 2 by default.
    
    //Add UI controls to the view
	[self addControlsToView];
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
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	//Add Search Button
	selectBtn = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[selectBtn setBackgroundColor:[UIColor clearColor]];
	selectBtn.enabled = YES;
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:Disabled_Select_button];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:Enabled_Select_button];
	
	[selectBtn setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
	[selectBtn setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
	
	[self.view addSubview:selectBtn];
	[selectBtn release];

	
	//Action for fetching the Spa Classes
	[selectBtn addTarget:self action:@selector(selectNoOfPlayer:) 
		   forControlEvents:UIControlEventTouchUpInside];	
    //add picker view
    PlayerPickerView = [[UIPickerView alloc]initWithFrame:PickerFrame];
    [self.view addSubview:PlayerPickerView];
    PlayerPickerView.hidden = NO;
	PlayerPickerView.showsSelectionIndicator = YES;
    [PlayerPickerView setDataSource:self];
    [PlayerPickerView setDelegate:self];  
    [PlayerPickerView selectRow:1 inComponent:0 animated:YES];
    [PlayerPickerView release];
}
-(void)selectNoOfPlayer:(id) sender
{
    //Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"NoOfPlayerSelected" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
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
    return [NoPlayersArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

	return [NoPlayersArray objectAtIndex:row] ;
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
	[subFieldArray removeObjectAtIndex:0];
	
		
    [subFieldArray insertObject:[[NoPlayersArray objectAtIndex:row]stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] atIndex:0];

	selectBtn.enabled = YES;
	[mainTableView reloadData];
}

@end
