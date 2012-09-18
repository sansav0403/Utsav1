//
//  RSGolfBookingFormVC.m
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSGolfBookingFormVC.h"
#import "RSBookingTableViewCell.h"
#import "RSSelectedGolfLocation.h"
#import "RSMainViewController.h"
#import "RSAvailableTeeTimeVC.h"
#import "RSDateSelectionVC.h"
#import "RSPlayerSelectionVC.h"

#import "SoapRequests.h"
#import "ErrorPopup.h"

#import "RSGolfTeeTimesParser.h"
#import "RSGolfTeeTimes.h"

#define PM                          @"pm"
#define DIFFERENT_TEETIMES          2


@implementation RSGolfBookingFormVC

@synthesize selectedCourseID;

static NSMutableString *golfSelectedDate ;  //to save the selected date 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCourseId:(NSString *)CourseID
{
    self = [super init];
    if (self) {
        self.selectedCourseID = CourseID;
    }

    return self;
}
- (void)dealloc
{
    [teeTimeParser release];
    [mainFieldArray release];
    [subFieldArray release];
    [selectedCourseID release];
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
    //intialize the static date value to be used to save selected Date.
    if (!golfSelectedDate) {
        golfSelectedDate = [[NSMutableString alloc]initWithString:NONE ];
    }
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:GolfBookingFormDate, GolfBookingFormPrefTeeTime,GolfBookingFormNoOfPlayer, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE, NONE, nil];
    
    //to modify the sub field array if static date(previous selected date) is available
    
    if (![golfSelectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:GolfDateSection withObject:golfSelectedDate];
    }
    
    ////to act as a data soource for the player pickerVIew
    if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] initWithYCordinate:BookingTable_Y];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
	instructionLabel = [[UILabel alloc] initWithFrame:InstructionLabelFrame];
	instructionLabel.text = pleaseSelectText;
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
	instructionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	checkAvailButton = [[UIButton alloc] initWithFrame:ButtonImageFrame];
	[checkAvailButton setBackgroundColor:[UIColor clearColor]];
	//checkAvailButton.titleLabel.text = @"Check Availability";
	checkAvailButton.enabled = NO;
	
	
	UIImage *disabledCheckImage  = [UIImage imageNamed:Disabled_Availibility_button];
	UIImage *enabledCheckImage  = [UIImage imageNamed:Enabled_Availibility_button];
	
	[checkAvailButton setBackgroundImage:disabledCheckImage forState:UIControlStateDisabled];
	[checkAvailButton setBackgroundImage:enabledCheckImage forState:UIControlStateNormal];
	
	[self.view addSubview:checkAvailButton];
	[checkAvailButton release];
    
	
	[checkAvailButton addTarget:self action:@selector(checkAvailabilityForGolfBooking:) 
			   forControlEvents:UIControlEventTouchUpInside];
    //
    //Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelctionOfPlayers:)
                                                 name:@"NoOfPlayerSelected" object:nil];
}
#pragma mark Date and Time picker selection

- (void) onSelctionOfPlayers:(NSNotification *)notice
{
    NSString *noOfPlayer = [notice object];
    
    [subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:noOfPlayer atIndex:selectedSection];
    
	[mainTableView reloadData];
	
	[self shouldBookButtonEnabled];
}
#pragma mark Date and Time picker selection
- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
    
    if(selectedSection == GolfDateSection)
    {
        [golfSelectedDate setString:date];
    }

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
	
	//Set the accessory view for Service Section
		[cell setAccessoryViewImage:YES];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    isPickerJustDisable = FALSE;
	
	[self shouldBookButtonEnabled];
    
	mainTableView.frame = CGRectMake(0, BookingTable_Y, Screen_Width, Screen_Height);
	[UIView commitAnimations];
	
	if ([[[self.view subviews] lastObject] isKindOfClass:[UIDatePicker class]]) {				
		[datePicker removeFromSuperview];
		datePicker =  nil;
        isPickerJustDisable = TRUE;
	}
	else if ([[[self.view subviews] lastObject] isKindOfClass:[UIPickerView class]]) {				
//		[PlayerCountPickerView removeFromSuperview];
//		PlayerCountPickerView =  nil;
        isPickerJustDisable = TRUE;
	}
    
    if (!isPickerJustDisable) 
    {
        selectedSection =  indexPath.row;
        switch (selectedSection)
        {			

            case GolfDateSection:
            {
                RSDateSelectionVC *spaDateSelVC = [[RSDateSelectionVC alloc] initWithSection:DatePicker dateString:[subFieldArray objectAtIndex:GolfDateSection]];
                spaDateSelVC.isGolf = YES;
                [self.navigationController pushViewController:spaDateSelVC animated:YES];
                
                RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];	
                [ResortSuiteAppDelegate changeNavigationBarTitleFormat:spaDateSelVC 
                                                                  text:[NSString stringWithFormat:@"Book %@", location.golfLocation.locationName] 
                                                              fontSize:nil];

                [spaDateSelVC release];
            }
                break;
                
            case TeeTimeSection:	
                if (![[subFieldArray objectAtIndex:GolfDateSection] isEqualToString:NONE])
                {
                RSDateSelectionVC *spaDateSelVC = [[RSDateSelectionVC alloc] initWithSection:TimePicker dateString:[subFieldArray objectAtIndex:GolfDateSection] timeString:[subFieldArray objectAtIndex:TeeTimeSection]];
                spaDateSelVC.isGolf = YES;
                [self.navigationController pushViewController:spaDateSelVC animated:YES];
                RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];	
                [ResortSuiteAppDelegate changeNavigationBarTitleFormat:spaDateSelVC 
                                                                  text:[NSString stringWithFormat:@"Book %@", location.golfLocation.locationName] 
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
            case PlayersCountSection:
            {
                RSPlayerSelectionVC *spaDateSelVC = [[RSPlayerSelectionVC alloc] init];
                [self.navigationController pushViewController:spaDateSelVC animated:YES];
                [spaDateSelVC release];
            }
                break;
                
        
            default:
                break;
        }	
	}
}

#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}

#pragma mark Book Button actions

-(void) shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:GolfDateSection] isEqualToString:NONE] || 
		[[subFieldArray objectAtIndex:TeeTimeSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:PlayersCountSection] isEqualToString:NONE])
	{
		checkAvailButton.enabled = NO;
	}
	else
	{		
		checkAvailButton.enabled = YES;
	}
}


-(void) checkAvailabilityForGolfBooking: (id) sender
{
	NSLog(@"Temp loading otherAvailableTime view");
    //call the service for tee time 
    // if teetime count is > 0 then push the tee time control 
    //else show apop out
    
    [self fetchTeeTime];

    
}
-(void) fetchTeeTime
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    
    [dateFormater setDateFormat:@"MMMM dd, yyyy hh:mm a"];
    NSString *prefTeeTime = [NSString stringWithFormat:@"%@ %@",
                             [subFieldArray objectAtIndex:GolfDateSection],
                             [subFieldArray objectAtIndex:TeeTimeSection]];
    
    NSDate *startTeeDate = [dateFormater dateFromString:prefTeeTime];
    
    NSDate *endTeeDate = [NSDate dateWithTimeInterval:3600 * DIFFERENT_TEETIMES sinceDate:startTeeDate];
    NSString *PrefEndTeeTime = [dateFormater stringFromDate:endTeeDate];
    [dateFormater release];
    
    NSLog(@"NSString *PrefEndTeeTime= %@",PrefEndTeeTime);
    
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:FetchGolfTeeTimesRequest>"
                             "<Source>IPHONE</Source>"
                             "<CourseId>%@</CourseId>"
                             "<Players>%@</Players>"
                             "<StartDateTime>%@</StartDateTime>"
                             "<EndDateTime>%@</EndDateTime>"
                             "</rsap:FetchGolfTeeTimesRequest>",
                             [NSString stringWithString:self.selectedCourseID],
                             [NSString stringWithString:[subFieldArray objectAtIndex:2]],
                             [NSString stringWithString:prefTeeTime],
                             [NSString stringWithString:PrefEndTeeTime]      //after the 2 hours from start time
                             ];                                            //Locatiojn id from Spa Location service
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    self.navigationController.navigationBar.userInteractionEnabled = NO;  
    
	[self fetchDataForRequestWithBody:requestBody];
    
}
-(NSDate *)dateFromString:(NSString *)stringDate
{
	
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy"];		
	NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return Date;
	
}
#pragma mark Common method for creating soap request and make a connection with WS 
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	NSString *responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    
    NSLog(@"responseString: %@", responseString);
	
	//If Ws response is of type spaService
	if ([responseString rangeOfString:@"FetchGolfTeeTimesResponse"].length > 0)
    {
        teeTimeParser = [[RSGolfTeeTimesParser alloc] init];    // relesed in dealloc
        teeTimeParser.delegate = self;                
        [teeTimeParser parse:dataFromWS];	
    }
    [responseString release];
	//If Ws response is of type SpaLocationsResponse
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating])
    {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        
	}	
	
	if ([parserModelData isKindOfClass:[Result class]])
    {
        Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
        
	}	
	else if ([parserModelData isKindOfClass:[RSGolfTeeTimes class]])
    {
        
		//If the data received is of type RSSpaServices fill the service into array
        RSGolfTeeTimes *teeTimesModel = (RSGolfTeeTimes *)parserModelData;
        
        NSLog(@"teetime count = %d",[teeTimesModel.golfTeeTimes count]);
        for (RSGolfTeeTime *teeTime in teeTimesModel.golfTeeTimes) {
            NSLog(@"teeTime are = %@",teeTime.dateTime);
        }       
        //push the tee time table view
        if ([teeTimesModel.golfTeeTimes count] > 0) {
            //push the tee time table view
            RSAvailableTeeTimeVC *otherAvailableTimeView = [[RSAvailableTeeTimeVC alloc]initWithTeeTimeArray:teeTimesModel.golfTeeTimes
            withSelectedCourseId:self.selectedCourseID
            andNoOfPlayer:[subFieldArray objectAtIndex:2]];
            [self.navigationController pushViewController:otherAvailableTimeView animated:YES];
            [otherAvailableTimeView release];
        }
        else
        {
            //show error pop out
            UIAlertView *errorAlert = [[UIAlertView alloc]
									   initWithTitle:POPUP_Tee_Times
									   message:POPUP_Tee_Times_Text
									   delegate:nil
									   cancelButtonTitle:POPUP_Button_Ok
									   otherButtonTitles:nil];
			[errorAlert show];
			[errorAlert release];

        }
    }

   
    
}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	
	appDelegate.myItineraryParser.errorResult = (Result *) parserModelData;
	
	if (appDelegate.connectedToInternet) {
		NSString *errorMessage = [NSString stringWithFormat:@"%@", appDelegate.myItineraryParser.errorResult.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}
}


@end
