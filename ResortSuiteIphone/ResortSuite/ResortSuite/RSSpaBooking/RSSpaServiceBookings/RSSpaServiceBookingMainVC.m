    //
//  RSSpaServiceBookingMainVC.m
//  ResortSuite
//
//  Created by Cybage on 27/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaServiceBookingMainVC.h"
#import "RSBookingTableView.h"
#import "ErrorPopup.h"
#import "RSBookingTableViewCell.h"
#import "SoapRequests.h"
#import "RSSpaStaffParser.h"
#import "RSSpaStaff.h"

#import "RSSpaService.h"

#import "RSSpaServiceCategoryVC.h"
#import "RSSpaServicesTableViewController.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaLocation.h"
#import "RSSpaAvailibility.h"
#import "RSSpaConfirmationView.h"
#import "RSDateSelectionVC.h"
#import "RSSpaStaffSeletionVC.h"

#import "RSSpaServiceParser.h"  //
#import "RSSpaServicesTableViewController.h"
#import "RSSpaAvailibilityParser.h"
#import "RSSpaAvailableTimes.h"

#define PM         @"pm"

@implementation RSSpaServiceBookingMainVC

@synthesize viewTitle;
@synthesize prefStaffGender;
@synthesize spaStaffParser;
@synthesize spaStaffs;

@synthesize selectedDateAndTime;
@synthesize notifiedSpaService;

@synthesize selectedStaff;
@synthesize selectedGender;

@synthesize spaServiceParser;
@synthesize spaAvailibilityParser;
@synthesize isCurrentTimeUpdated;

static NSMutableString *selectedDate ;      //to save the time date and duration of the pervious selected service.
static NSMutableString *selectedTime ;

static NSMutableString *startTime ;      //to save the time date and duration of the pervious selected service.
static NSMutableString *endTime ;

static int selectedSpaServiceSection;
static int serviceDuration = 0;  

-(id) initWithViewTitle:(NSString *) viewTitleString
{
	self.viewTitle = viewTitleString;
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];

	if (!selectedDate && !selectedTime) {
        selectedDate = [[NSMutableString alloc]initWithString:NONE ];
        selectedTime = [[NSMutableString alloc]initWithString:NONE ];
        
    }

	if (!startTime && !endTime) {
        startTime = [[NSMutableString alloc]initWithString:@"" ];
        endTime = [[NSMutableString alloc]initWithString:@"" ];
        
    }
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];

	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:self.viewTitle fontSize:nil];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormService, SpaBookingFormDate, SpaBookingFormTime, SpaBookingFormStafGender,SpaBookingFormStaff, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE, NONE, SpaBookingNoPref,SpaBookingNoPref, nil];
    
    if (![selectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:DateSection withObject:selectedDate];
    }
    if (![selectedTime isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:TimeSection withObject:selectedTime];
    }
	
	if (prefStaffGenders) {
		[prefStaffGenders removeAllObjects];
		[prefStaffGenders release];
	}	
	prefStaffGenders = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, SpaBookingStaffMale, SpaBookingStaffFemale, nil];
	
	prefStaffGender = @"";		//For No Pref.
    
    self.selectedGender = SpaBookingNoPref;
    self.selectedStaff = SpaBookingNoPref;
	
	//Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	instructionLabel = [[UILabel alloc] initWithFrame:InstructionLabelFrame];  //InstructionLabelFrame//CGRectMake(0, 38, 320, 40)
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	checkAvailButton = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[checkAvailButton setBackgroundColor:[UIColor clearColor]];
	checkAvailButton.enabled = NO;
	
	
	UIImage *disabledCheckImage  = [UIImage imageNamed:Disabled_Availibility_button];
	UIImage *enabledCheckImage  = [UIImage imageNamed:Enabled_Availibility_button];
	
	[checkAvailButton setBackgroundImage:disabledCheckImage forState:UIControlStateDisabled];
	[checkAvailButton setBackgroundImage:enabledCheckImage forState:UIControlStateNormal];
	
	[self.view addSubview:checkAvailButton];
	[checkAvailButton release];

	
	[checkAvailButton addTarget:self action:@selector(checkAvailabilityForSpaBooking:) 
			   forControlEvents:UIControlEventTouchUpInside];
    
	
	//Notification for selecting the Service
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSpaServiceSelection:)
                                                 name:@"spaServiceSelected" object:nil];
	
	//Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDateTimeChanged:)
                                                 name:@"DayTimesAccordingToDate" object:nil];
	
	//Notification for selecting the Staff Gender/Name
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onStaffPickerValueChanged:)
                                                 name:@"StaffPickerValueChanged" object:nil];

	//Notification for selecting the Staff Gender/Name
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCurrentBookingTime:)
                                                 name:@"updateNextBookingTime" object:nil];
}

#pragma mark Service selection
- (void)onSpaServiceSelection:(NSNotification *)notification
{
    RSSpaService *spaService = [notification object];
    self.notifiedSpaService = spaService;           //object saved in the controller release in dealloc

    [subFieldArray removeObjectAtIndex:SpaServiceSection];
    [subFieldArray insertObject:spaService.itemName atIndex:SpaServiceSection];
    
    [mainTableView reloadData];
   
    [self shouldBookButtonEnabled];
}


#pragma mark Date and Time picker selection

- (void) onDateTimeChanged:(NSNotification *)notice
{
    NSMutableArray* dayTimes = [notice object];   
    [startTime setString:[dayTimes objectAtIndex:0]];
    [endTime setString:[dayTimes objectAtIndex:1]];
     NSLog(@"onDateTimeChanged startTime and endtime = %@  %@ ",startTime,endTime);
}

- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSpaServiceSection];
	[subFieldArray insertObject:date atIndex:selectedSpaServiceSection];
		
    if(selectedSpaServiceSection == DateSection)
    {
        [selectedDate setString:date];
        
        //To set the start time for the selected date
        NSLog(@"onPickerValueChanged start time = %@",startTime);
        [selectedTime setString:startTime];        
        if (![selectedTime isEqualToString:NONE]) {
            [subFieldArray replaceObjectAtIndex:TimeSection withObject:selectedTime];   //should be DateSectionin plac of time section
        }
    }
    else if(selectedSpaServiceSection == TimeSection)
    {
        //To set the start time for the selected date
        [selectedTime setString:date];        
    }

	[mainTableView reloadData];
	
	[self shouldBookButtonEnabled];
}

- (void) updateCurrentBookingTime:(NSNotification *)notice
{
    NSMutableArray* timeAndDuration = [notice object];
    NSString *newTime = [timeAndDuration objectAtIndex:0];
    serviceDuration = [[timeAndDuration objectAtIndex:1] intValue];
	
    if((serviceDuration % TIME_INTERVAL) > 0)
    {
        serviceDuration += (TIME_INTERVAL - (serviceDuration % TIME_INTERVAL)); 
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MMMM d, yyyy hh:mm a"];  
    
    NSString* newDate = [selectedDate stringByAppendingString:@" "];
    newDate = [newDate stringByAppendingString:newTime];
    
    NSString* endDate = [selectedDate stringByAppendingString:@" "];
    endDate = [endDate stringByAppendingString:endTime];

    //after adding time durartion
    NSDate *selectedTimeInDF = [[NSDate alloc]initWithTimeInterval:serviceDuration * 60 sinceDate:[dateFormatter1 dateFromString:newDate]];  
    NSDate *endTimeInDF = [[NSDate alloc]initWithTimeInterval:0 sinceDate:[dateFormatter1 dateFromString:endDate]];  
    [dateFormatter1 release];
    
    if ([selectedTimeInDF compare:endTimeInDF] == NSOrderedDescending )
    {
        [selectedTime setString:startTime];        
    }
    else
    {
        [selectedTime setString:[dateFormatter stringFromDate:selectedTimeInDF]];  
    }
    [selectedTimeInDF release];
    [endTimeInDF release];
    [dateFormatter release];

}

#pragma mark Staff picker selection
- (void) onStaffPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
	
	if (selectedSection == PrefStaffGenderSection) {
		[subFieldArray removeObjectAtIndex:selectedSection+1];
		[subFieldArray insertObject:SpaBookingNoPref atIndex:selectedSection+1];
	}
	[mainTableView reloadData];
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
	
	[[NSNotificationCenter defaultCenter] removeObserver:self]; 
}

- (void)dealloc {
    
	[viewTitle release];
	[prefStaffGender release];
	[spaStaffParser release];
    [selectedDateAndTime release];
    [notifiedSpaService release];
    [spaServiceParser release];
    [spaCategoryDictionary release];
	[spaAvailibilityParser release];
	
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
	[cell setAccessoryViewImage:YES];
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

    isPickerJustDisable = FALSE;
	selectedSpaServiceSection = indexPath.row;
    
	[self shouldBookButtonEnabled];
	
	if ([[[self.view subviews] lastObject] isKindOfClass:[UIDatePicker class]]) {				
		[datePicker removeFromSuperview];
		datePicker =  nil;
        isPickerJustDisable = TRUE;
	}
	else if ([[[self.view subviews] lastObject] isKindOfClass:[UIPickerView class]]) {				
		[prefStaffPicker removeFromSuperview];
		prefStaffPicker =  nil;
        isPickerJustDisable = TRUE;
	}

    if (!isPickerJustDisable) 
    {
        selectedSection =  indexPath.row;
        switch (selectedSection)
        {			
            case SpaServiceSection:
            {
                NSLog(@"Load Spa Services View...");
                //fetch spa service at the start and create dictionary
                [self fetchSpaServices];

            }
                break;
                
            case DateSection:
                //Load the Date Picker for date 
				{
					NSString *dateSelected = [subFieldArray objectAtIndex:1];
					
					RSDateSelectionVC *spaDateSelVC = [[RSDateSelectionVC alloc] initWithSection:DateSection dateString:dateSelected];
					[self.navigationController pushViewController:spaDateSelVC animated:YES];

                    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
                    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:spaDateSelVC 
                                                                      text:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName] 
                                                                  fontSize:nil];

					[spaDateSelVC release];
				}                
				break;
                
            case TimeSection:
                //Load the Date Picker for time 
				if (![[subFieldArray objectAtIndex:DateSection] isEqualToString:NONE])
				{
					RSDateSelectionVC *spaDateSelVC = [[RSDateSelectionVC alloc] initWithSection:TimeSection dateString:[subFieldArray objectAtIndex:DateSection] timeString:[subFieldArray objectAtIndex:TimeSection]];    //NONE string is passed for the first time.
					[self.navigationController pushViewController:spaDateSelVC animated:YES];

                    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];	
                    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:spaDateSelVC 
                                                                      text:[NSString stringWithFormat:@"Book %@", location.spaLocation.locationName] 
                                                                  fontSize:nil];
					[spaDateSelVC release];
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
                break;
                
            case PrefStaffGenderSection:
                //Load the staff gender pref picker 
				{
					RSSpaStaffSeletionVC *spaStaffSelVC = [[RSSpaStaffSeletionVC alloc] initWithSection:selectedSection 
                            prefStaffs:prefStaffGenders];
					[self.navigationController pushViewController:spaStaffSelVC animated:YES];
					[spaStaffSelVC release];
				}
                break;
                
            case PrefStaffSection:			
				if ([[subFieldArray objectAtIndex:0] isEqualToString:NONE]) {
					UIAlertView *errorAlert = [[UIAlertView alloc]
											   initWithTitle:POPUP_Error
											   message:POPUP_Select_Service
											   delegate:nil
											   cancelButtonTitle:POPUP_Button_Ok
											   otherButtonTitles:nil];
					[errorAlert show];
					[errorAlert release];
				}
				else {		
   					//Set the prefStaffGender Male/Female/No Pref.
					if ([[subFieldArray objectAtIndex:3] isEqualToString:SpaBookingStaffMale]) {
						prefStaffGender = @"M";
					}
					else if ([[subFieldArray objectAtIndex:3] isEqualToString:SpaBookingStaffFemale]) {
						prefStaffGender = @"F";
					}			
					else {
						prefStaffGender = @"";
					}
                
					//Fetch the spa staffs for the selected spa item and gender preference
					NSString *selectedSpaItemId = [NSString stringWithFormat:@"%d", notifiedSpaService.spaItemID];				
					[self fetchSpaStaffsForId:selectedSpaItemId forGender:prefStaffGender];				
				}                
                break;
                
            default:
                break;
        }	
    }
	
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (selectedSection == PrefStaffGenderSection) {
		return 3;
	}
	else if (selectedSection == PrefStaffSection) {
		return [prefStaffNames count];
	}
	return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (selectedSection == PrefStaffGenderSection) {
		return [prefStaffGenders objectAtIndex:row];
	}
	else if (selectedSection == PrefStaffSection) {
		return [prefStaffNames objectAtIndex:row];
	}
	return @"";
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
	[subFieldArray removeObjectAtIndex:selectedSection];
	
	if (selectedSection == PrefStaffGenderSection) {		
		[subFieldArray insertObject:[prefStaffGenders objectAtIndex:row] atIndex:selectedSection];
        self.selectedGender = [prefStaffGenders objectAtIndex:row];
		
		[subFieldArray removeObjectAtIndex:selectedSection+1];
		[subFieldArray insertObject:SpaBookingNoPref atIndex:selectedSection+1];
	}
	else if (selectedSection == PrefStaffSection) {
		[subFieldArray insertObject:[prefStaffNames objectAtIndex:row] atIndex:selectedSection];
        self.selectedStaff = [prefStaffNames objectAtIndex:row];
	}
	[mainTableView reloadData];
}


#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	NSString *responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
	NSLog(@"responseString: %@", responseString);
	
	//If Ws response is of type Spa Staff Response
	if ([responseString rangeOfString:@"FetchSpaStaffResponse"].length > 0) {
		 if (self.spaStaffParser) {
		 //[self.spaStaffParser release];
             self.spaStaffParser = nil;
		 }
		 spaStaffParser = [[RSSpaStaffParser alloc] init];
		 spaStaffParser.delegate = self;
		 
		 [spaStaffParser parse:dataFromWS];	
	 }
    //If Ws response is of type spaService
	else if ([responseString rangeOfString:@"FetchSpaServicesResponse"].length > 0)
    {
        if (self.spaServiceParser) {
            //[self.spaServiceParser release];
            self.spaServiceParser = nil;
        }
        spaServiceParser = [[RSSpaServiceParser alloc] init];
        spaServiceParser.delegate = self;                
        [spaServiceParser parse:dataFromWS];	
    }
	//If Ws response is of type Spa Availability
	else if ([responseString rangeOfString:@"FetchSpaAvailabilityResponse"].length > 0)
    {
        if (self.spaAvailibilityParser) {
            //[self.spaAvailibilityParser release];
            self.spaAvailibilityParser = nil;
        }
        spaAvailibilityParser = [[RSSpaAvailibilityParser alloc] init];
        spaAvailibilityParser.delegate = self;                
        [spaAvailibilityParser parse:dataFromWS];	
    }	
    [responseString release];
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}	
	
	if ([parserModelData isKindOfClass:[Result class]]) {
		Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSSpaStaffs class]]) {
		//Load the staff names in the picker
		[self loadStaffNamesinPicker:parserModelData];	
	}
    else if ([parserModelData isKindOfClass:[RSSpaServices class]])
    {
        
		//If the data received is of type RSSpaServices fill the service into array        
        [self createDictionaryAndReloadTable];
        
    }
	else if ([parserModelData isKindOfClass:[RSSpaAvailibilties class]])
    {
        NSLog(@"RSSpaAvailibilties response");
		spaAvailibilityParser.rsSpaAvailibilties = (RSSpaAvailibilties *) parserModelData;
		
		if ([spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities count] == 1) {
            if ([self doesAvailableTimeExitsInAvailibilityArray]) {
                RSSpaConfirmationView *spaConfirmationView = [[RSSpaConfirmationView alloc] 
                        initWithSpaAvailibilityArray:[NSArray arrayWithObject:[spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities objectAtIndex:0]]
                        forSelectedSpaService:notifiedSpaService
                        WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
                [selectedStaff release];
                [selectedGender release];
                
                [self.navigationController pushViewController:spaConfirmationView animated:YES];
                [spaConfirmationView release];
            }
            else
            {
                RSSpaAvailableTimes *spaAvailableTimesVC = [[RSSpaAvailableTimes alloc] initWithAvailableTimes:spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities
                    forSelectedSpaService:notifiedSpaService
                    WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
                [self.navigationController pushViewController:spaAvailableTimesVC animated:YES];
                [spaAvailableTimesVC release];	
            }
	
		}
		else if ([spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities count] > 1) {
			RSSpaAvailableTimes *spaAvailableTimesVC = [[RSSpaAvailableTimes alloc] initWithAvailableTimes:spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities
                forSelectedSpaService:notifiedSpaService
                WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
			[self.navigationController pushViewController:spaAvailableTimesVC animated:YES];
			[spaAvailableTimesVC release];		
		}
		else {
			UIAlertView *errorAlert = [[UIAlertView alloc]
									   initWithTitle:@""
									   message:POPUP_Service_Unavailable //POPUP_Change_Search
									   delegate:nil
									   cancelButtonTitle:POPUP_Button_Ok
									   otherButtonTitles:nil];
			[errorAlert show];
			[errorAlert release];
		}
    }
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}

-(BOOL)doesAvailableTimeExitsInAvailibilityArray
{
     RSSpaAvailibility *spaAvailibility = (RSSpaAvailibility *)[spaAvailibilityParser.rsSpaAvailibilties.spaAvailibilities 
                                                                objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy hh:mm a"];
    NSDate* userSelectedDate = (NSDate*)[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",
                                                           [subFieldArray objectAtIndex:DateSection],
                                                           [subFieldArray objectAtIndex:TimeSection]
                                                           ]];
    
    NSDate* availableDate = (NSDate*)[dateFormatter dateFromString:spaAvailibility.startTime];
	[dateFormatter release];
   
        
    if ([availableDate isEqualToDate:userSelectedDate])
        {
            return YES;
        }
    return NO;
        
  
  
}
#pragma mark - dictionary creation function
-(void)createDictionaryAndReloadTable
{
    //create dictionary to divided in category
    //create the dictionary with category as key	
    NSArray *spaServiceArray = self.spaServiceParser.rsSpaServices.spaServices;
    spaCategoryDictionary = [[NSMutableDictionary alloc]init];
    
    for (int i= 0; i < [spaServiceArray count];i++)
    {
        RSSpaService *spaService = [spaServiceArray objectAtIndex:i];
        NSString *spaCategoryKey = spaService.itemCategory;     //key are are string
        
        NSArray *lkeyArray = [spaCategoryDictionary allKeys];
        
        if ([lkeyArray containsObject:spaCategoryKey])
        {
            NSMutableArray *localEventArray = [spaCategoryDictionary objectForKey:spaCategoryKey];
            [localEventArray addObject:spaService];
            [spaCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
        }
        else 
        {
            NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:spaService,nil];
            [spaCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
            [localEventArray release];
        }
    }

    [self switchApplicationToSpaServices];
}

-(void)switchApplicationToSpaServices
{
    //now the dictionary is created
    NSArray *categoryAllKey = [spaCategoryDictionary allKeys];
    
    //condition to put in row did select
    if ([categoryAllKey count] == 1) {
        //push the table view
        RSSpaServicesTableViewController *spaServiceTable = [[RSSpaServicesTableViewController alloc]
                                                             initWithSpaServiceArray:
                                                             self.spaServiceParser.rsSpaServices.spaServices];
        [self.navigationController pushViewController:spaServiceTable animated:YES];
        [spaServiceTable release];
    }
    else if([categoryAllKey count] > 1)
    {
        //add all key in the dictionary
        [spaCategoryDictionary setObject:self.spaServiceParser.rsSpaServices.spaServices forKey:@"All"];
        //push the category view
        RSSpaServiceCategoryVC *spaServiceTable = [[RSSpaServiceCategoryVC alloc]initWithSpaDictionary:spaCategoryDictionary];
        [self.navigationController pushViewController:spaServiceTable animated:YES];
        [spaServiceTable release];
    }
    else 
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:POPUP_Error
                                   message:POPUP_Service_Unavailable
                                   delegate:self
                                   cancelButtonTitle:POPUP_Button_Ok
                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }		
    
}

#pragma mark fetch the data for the spa services
-(void) fetchSpaServices
{
    //
	//[self.view addSubview:appDelegate.activityIndicator.view];
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
	
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
	NSString *bodyString = [NSString stringWithFormat:                             
                            @"<rsap:FetchSpaServicesRequest>"
                            "<Location>%@</Location>"
                            "</rsap:FetchSpaServicesRequest>",
                            [NSString stringWithFormat:@"%d",location.spaLocation.locationID] //Locatiojn id from Spa Location service
                            ];
	
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}



#pragma mark fetch the data for staffs
-(void) fetchSpaStaffsForId:(NSString *) spaItemId forGender:(NSString *) gender
{
	//[self.view addSubview:appDelegate.activityIndicator.view];
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
	
	NSString *bodyString = [NSString stringWithFormat: 
							 @"<rsap:FetchSpaStaffRequest>"
							 "<SpaItemId>%@</SpaItemId>"							 
							 "<Gender>%@</Gender>"		//"<!--Optional:-->"
							 "</rsap:FetchSpaStaffRequest>",spaItemId, gender];
	
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}

-(void) loadStaffNamesinPicker:(id) parserModelData
{
	//If the data received is of type RSSpaStaffs
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	self.spaStaffs = (RSSpaStaffs *) parserModelData;
	
	if(appDelegate.connectedToInternet)	{
		appDelegate.isLoggedIn = YES;
	}
	
	if (prefStaffNames) {
		[prefStaffNames removeAllObjects];
		[prefStaffNames release];
	}	
	prefStaffNames = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, nil];
	
	if ([self.spaStaffs.spaStaffs count] > 0) {
		//Add Spa staff names into an array with sorting order	
		NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"spaStaffName" ascending:YES];
		[self.spaStaffs.spaStaffs sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]]; 
		[nameSorter release];
		
		for (int staffIndex =0; staffIndex < [self.spaStaffs.spaStaffs count]; staffIndex++) {
			[prefStaffNames addObject:[[self.spaStaffs.spaStaffs objectAtIndex:staffIndex] spaStaffName]];				
		}	
	}
	
	//Load the staff picker with staff names
	RSSpaStaffSeletionVC *spaStaffSelVC = [[RSSpaStaffSeletionVC alloc] initWithSection:selectedSection 
																			 prefStaffs:prefStaffNames];
	[self.navigationController pushViewController:spaStaffSelVC animated:YES];
	[spaStaffSelVC release];
}

#pragma mark Book Button actions

-(void) shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:SpaServiceSection] isEqualToString:NONE] || 
		[[subFieldArray objectAtIndex:DateSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:TimeSection] isEqualToString:NONE])
	{
		checkAvailButton.enabled = NO;
	}
	else
	{		
		checkAvailButton.enabled = YES;
	}
}


-(void) checkAvailabilityForSpaBooking: (id) sender
{
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
    
	self.selectedDateAndTime = [NSString stringWithFormat:@"%@ %@", [subFieldArray objectAtIndex:1], [subFieldArray objectAtIndex:2]];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

	NSString *bodyString = [NSString stringWithFormat: 
							@"<rsap:FetchSpaAvailabilityRequest>"
							@"<AuthorizationId>%@</AuthorizationId>"
							"<SpaItemId>%@</SpaItemId>"							 
							"<StartDateTime>%@</StartDateTime>"
							"<CustomerId>%@</CustomerId>"
							"<SpaLocationId>%@</SpaLocationId>"
							"</rsap:FetchSpaAvailabilityRequest>",
							[prefs stringForKey:AuthorizationIdKey],
							[NSString stringWithFormat:@"%d", self.notifiedSpaService.spaItemID],
							self.selectedDateAndTime,
							[prefs stringForKey:CustomerIdKey],
							[NSString stringWithFormat:@"%d", self.notifiedSpaService.location]];
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	NSLog(@"soapStr: %@", soapString);
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
	
}

@end
