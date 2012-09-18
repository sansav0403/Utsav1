//
//  RSSpaClassBookingFormVC.m
//  ResortSuite
//
//  Created by Cybage on 10/13/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaClassBookingFormVC.h"
#import "RSBookingTableView.h"
#import "RSBookingTableViewCell.h"
#import "RSSelectedSpaLocation.h"
#import "SoapRequests.h"
#import "RSConnection.h"
#import "RSDailySpaClassesParser.h"
#import "ErrorPopup.h"
#import "RSSpaClassTableViewController.h"
#import "RSSpaClassCategoryVC.h"
#import "RSSpaCustomerConflictBookingsParser.h"
#import "RSSpaCustomerConflictingBookings.h"
#import "RSSpaCustConflictingBookingsVC.h"

#import "RSSpaClassConfirmationVC.h"
#import "RSDateSelectionVC.h"
#import "DateManager.h"

@implementation RSSpaClassBookingFormVC

@synthesize viewTitle;
@synthesize dailySpaClassesParser;
@synthesize selectedSpaClass;
@synthesize spaCustomerConflictBookingsParser;

static NSMutableString *selectedDate ;      //to save the time date and duration of the pervious selected service.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithViewTitle:(NSString *) viewTitleString
{
	self.viewTitle = viewTitleString;
	return self;
}
- (void)dealloc
{
    [mainFieldArray release];
    [subFieldArray release];
    [selectedSpaClass release];
    
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
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if (!selectedDate) {
        selectedDate = [[NSMutableString alloc]initWithString:NONE ];
    }
    
    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    //self.navigationItem.title = viewTitle;
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:self.viewTitle fontSize:nil];
    
    if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
    
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:@"Date", ClassActivityCellText, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE,nil];
    
    if (![selectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:0 withObject:selectedDate];
    }
    
    //Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	instructionLabel = [[UILabel alloc] initWithFrame:InstructionLabelFrame];  //CGRectMake(0, 38, 320, 40)
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	checkAvailButton = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[checkAvailButton setBackgroundColor:[UIColor clearColor]];
	//checkAvailButton.titleLabel.text = @"Check Availability";
	checkAvailButton.enabled = NO;
	
	
	UIImage *disabledCheckImage  = [UIImage imageNamed:Disabled_Select_button];
	UIImage *enabledCheckImage  = [UIImage imageNamed:Enabled_Select_button];
	
	[checkAvailButton setBackgroundImage:disabledCheckImage forState:UIControlStateDisabled];
	[checkAvailButton setBackgroundImage:enabledCheckImage forState:UIControlStateNormal];
	
	[self.view addSubview:checkAvailButton];
	[checkAvailButton release];
    
	
	[checkAvailButton addTarget:self action:@selector(checkAvailabilityForClassBooking:) 
			   forControlEvents:UIControlEventTouchUpInside];
    
    //Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];
    
    //Notification for selecting Spa class
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onSpaClassSelection:)
                                                     name:@"spaClassSelected" object:nil];
}
#pragma mark Date and Spa class selection notification action
- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
    
    if(selectedSection == ClassDateSection)
    {
        [selectedDate setString:date];
    }
    [mainTableView reloadData];
    [self shouldBookButtonEnabled];
}

-(void)onSpaClassSelection:(NSNotification *)notice
{
    self.selectedSpaClass = (RSSpaClass *)[notice object];
    [subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:selectedSpaClass.spaItemName atIndex:selectedSection];
    
    [mainTableView reloadData];
    [self shouldBookButtonEnabled];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
	[cell setAccessoryViewImage:YES];
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    selectedSection =  indexPath.row;
    
    switch (selectedSection)
    {			
        case ClassDateSection:
        {
            NSString *dateSelected = [subFieldArray objectAtIndex:0];
            
            RSDateSelectionVC *spaDateSelVC = [[RSDateSelectionVC alloc] initWithSection:DatePicker dateString:dateSelected];
            [self.navigationController pushViewController:spaDateSelVC animated:YES];

            RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
            [ResortSuiteAppDelegate changeNavigationBarTitleFormat:spaDateSelVC 
                                                              text:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName] 
                                                          fontSize:nil];
            [spaDateSelVC release];
        }
            break;
            
        case ClassServiceSection:
        {
            if (![[subFieldArray objectAtIndex:ClassDateSection] isEqualToString:NONE])
            {
            [self fetchSpaClasses];
            }
            else {
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle:POPUP_Error
                                           message:POPUP_Select_Date
                                           delegate:nil
                                           cancelButtonTitle:POPUP_Button_Ok
                                           otherButtonTitles:nil];
                [errorAlert show];
                [errorAlert release];
            }

        }
            
            break;
    }
}
//call service to fetch spa class and create dictionary
-(void) fetchSpaClasses
{
    NSString *selectedDate = [subFieldArray objectAtIndex:ClassDateSection];
	DLog(@"Fetching spa classes view: %@",selectedDate );
    
    selectedDate = [DateManager convertIntoResponseStringFromSpecificFormatString:selectedDate dateFormatStyle:MMMM_d_yyyyFormat withTime:NO];
    DLog(@"Fetching spa classes view: %@",selectedDate );
    
	//Get the selected Spa location from the shared instance
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
    
	NSString *bodyString = [NSString stringWithFormat: 
							@"<rsap:FetchSpaClassesRequest>"
							"<Location>%@</Location>"
							"<StartDate>%@</StartDate>"                                                                        
							"<EndDate>%@</EndDate>"                                                                           
							"</rsap:FetchSpaClassesRequest>", 
							[NSString stringWithFormat:@"%d",location.spaLocation.locationID],
							selectedDate, selectedDate]; 
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
     
   
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
    
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	NSString *responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
	DLog(@"responseString: %@", responseString);
	
	//If Ws response is of type FetchSpaClassesResponse
	if ([responseString rangeOfString:@"FetchSpaClassesResponse"].length > 0) {
		if (self.dailySpaClassesParser) {
			
            self.dailySpaClassesParser = nil;
		}
		dailySpaClassesParser = [[RSDailySpaClassesParser alloc] init];
		dailySpaClassesParser.delegate = self;
		
		[dailySpaClassesParser parse:dataFromWS];	
	}
    else if ([responseString rangeOfString:@"FetchSpaCustomerConflictingBookingsResponse"].length > 0) {
            if (self.spaCustomerConflictBookingsParser) {
                
                self.spaCustomerConflictBookingsParser = nil;
            }
            spaCustomerConflictBookingsParser = [[RSSpaCustomerConflictBookingsParser alloc] init];
            spaCustomerConflictBookingsParser.delegate = self;
            
            [spaCustomerConflictBookingsParser parse:dataFromWS];	
        }

    
	[responseString release];
	
}

#pragma mark RSParseBase delegate
- (void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}	
	
	if ([parserModelData isKindOfClass:[Result class]]) {
		//[self showErrorMessage:parserModelData];
	}	
	else if ([parserModelData isKindOfClass:[RSDailySpaClasses class]])
    {
		
		self.dailySpaClassesParser.rsDailySpaClasses = (RSDailySpaClasses *) parserModelData;
		
		
		if ([self.dailySpaClassesParser.rsDailySpaClasses.spaClasses count] > 0)
        {
            [self createDictionaryAndReloadTable];
		}
		else 
        {
			UIAlertView *errorAlert = [[UIAlertView alloc]
									   initWithTitle:POPUP_Error
									   message:POPUP_Activity_Data_Unavailable
									   delegate:self
									   cancelButtonTitle:POPUP_Button_Ok
									   otherButtonTitles:nil];
			[errorAlert show];
			[errorAlert release];
		}		
	}
	else
    {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}

- (void)createDictionaryAndReloadTable
{
    
    classCategoryDictionary = [[NSMutableDictionary alloc]init];
    
    NSArray *classArray = self.dailySpaClassesParser.rsDailySpaClasses.spaClasses;      //get the refrence of classes in classArray
    
    for (int i= 0; i < [classArray count];i++)
    {
        RSSpaClass *spaClass = (RSSpaClass *)[classArray objectAtIndex:i];
        NSString *spaCategoryKey = [NSString stringWithFormat:@"%@", spaClass.itemCategory];     //key are string
        
        DLog(@"spaCategoryKey %@ = ",spaCategoryKey)	;	
        
        NSArray *lkeyArray = [classCategoryDictionary allKeys];
        
        if ([lkeyArray containsObject:spaCategoryKey])
        {
            NSMutableArray *localEventArray = [classCategoryDictionary objectForKey:spaCategoryKey];
            [localEventArray addObject:spaClass];
            [classCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];		
        }
        else 
        {
            NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:spaClass,nil];
            [classCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
            [localEventArray release];			
	    }
    }
    //class dictionary is now created
    //check the count of the key 
    //the push tabl;e or cate4gory on condition
    if ([[classCategoryDictionary allKeys] count] == 1 )
    {
        RSSpaClassTableViewController *spaClassTableVC = [[RSSpaClassTableViewController alloc] 
                                                          initWithSpaClassArray:self.dailySpaClassesParser.rsDailySpaClasses.spaClasses];
        [self.navigationController pushViewController:spaClassTableVC animated:YES];
        [spaClassTableVC release];
    }
    else if([[classCategoryDictionary allKeys] count] > 1 && [[classCategoryDictionary allKeys] count] > 0)
    {
        [classCategoryDictionary setObject:classArray forKey:@"All"];
        
        //call the sub class of the category view base class
        RSSpaClassCategoryVC *classCategoryVC = [[RSSpaClassCategoryVC alloc]initWithClassDictionary:classCategoryDictionary];
        [self.navigationController pushViewController:classCategoryVC animated:YES];
        [classCategoryVC release];
    }else 
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:POPUP_Error
                                   message:POPUP_Activity_Data_Unavailable
                                   delegate:self
                                   cancelButtonTitle:POPUP_Button_Ok
                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }		
    
}

#pragma mark Book Button actions
-(void)shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:ClassDateSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:ClassServiceSection] isEqualToString:NONE] )
	{
		checkAvailButton.enabled = NO;
	}
	else
	{		
		checkAvailButton.enabled = YES;
	}
    
}

#pragma mark Check Availibility
-(void)checkAvailabilityForClassBooking:(id)sender
{
    //show confirmation view
    //there check foe conflicct and  do book action
    RSSpaClassConfirmationVC *classConfirmationVC = [[RSSpaClassConfirmationVC alloc]initWithSelectedClass:self.selectedSpaClass];
    [self.navigationController pushViewController:classConfirmationVC animated:YES];
    [classConfirmationVC release];
}


@end
