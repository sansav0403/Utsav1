//
//  RSSpaConfirmationView.m
//  ResortSuite
//
//  Created by Cybage on 9/20/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaConfirmationView.h"
#import "RSSpaAvailibility.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaCustConflictingBookingsVC.h"
#import "ResortSuiteAppDelegate.h"
#import "SoapRequests.h"
#import "RSSpaServiceBookingParser.h"
#import "ErrorPopup.h"
#import "RSSpaBookingConfirmationVC.h"

@implementation RSSpaConfirmationView

@synthesize bookedService,spaAvailibilities,prefGender,prefStaffName, selectedDateAndTime, spaServiceBookingParser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService 
{
    self = [super init];
    if (self)
    {
        //self.bookingDate = date;
        self.bookedService  = spaService;
        self.spaAvailibilities = Availibilites;
    }
    return self;
}

-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService
                WithSelectedStaff:(NSString *)staffName andGender:(NSString *)selectedStaffgender
{
    self = [super init];
    if (self)
    {
        self.bookedService  = spaService;
        self.spaAvailibilities = Availibilites;
        self.prefGender = selectedStaffgender;
        self.prefStaffName = staffName;
    }
    return self;
}

- (void)dealloc
{
	[selectedDateAndTime release];
    [bookedService release];
    [spaAvailibilities release];
	[spaServiceBookingParser release];

    if(bookingTime)
    {
        [bookingTime release];
    }
     [spaCustConflictingBookingsVC release];
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
	appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    spaCustConflictingBookingsVC = [[RSSpaCustConflictingBookingsVC alloc] init];
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    self.navigationItem.title = [NSString stringWithFormat:@"Book %@",location.spaLocation.locationName];

    [ self displayBookingConfirmation];
}

-(void)displayBookingConfirmation
{
	NSString *bookingStr = nil;
	
	if ([spaAvailibilities count] == 0) {
		bookingStr = self.selectedDateAndTime;
	}
	else if ([spaAvailibilities count] > 0)
	{
		RSSpaAvailibility *tempAvailibility = (RSSpaAvailibility *)[spaAvailibilities objectAtIndex:0];
		bookingStr = [tempAvailibility startTime];
	}
	
	NSDate *bookingDate = [self dateFromString:bookingStr];	
    
    [self createTitleHeader:@"Book" yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];

    //Set current booking time
    bookingTime = [[NSString alloc] initWithString:[self timeStringFromDate:bookingDate]];
    
    //generate the array of the static label text and the dynamioc label text
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:SpaConfirmationView_Service,SpaConfirmationView_Date,SpaConfirmationView_Time,SpaConfirmationView_Duration,SpaConfirmationView_Price,SpaConfirmationView_Description, nil]autorelease];
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                    bookedService.itemName,
                                    
                                  [self stringFromDate:bookingDate],
                                  [self timeStringFromDate:bookingDate],
                                  [NSString stringWithFormat:@"%d",bookedService.serviceTime],
                                  [NSString stringWithFormat:@"%0.02f",bookedService.price],
                                          bookedService.itemDesc,
                                  nil
                                  ] autorelease];
    
    if(![self.prefGender isEqualToString:SpaBookingNoPref])
    {
        [staticLabelTexts insertObject:@"Gender" atIndex:2];
        [DynamicLabelTexts insertObject:self.prefGender atIndex:2];
        
        if (![self.prefStaffName isEqualToString:SpaBookingNoPref])
        {
            [staticLabelTexts insertObject:@"Staff Name" atIndex:3];
            [DynamicLabelTexts insertObject:self.prefStaffName atIndex:3];
        }
    }
    
    if (![self.prefStaffName isEqualToString:SpaBookingNoPref] && [self.prefGender isEqualToString:SpaBookingNoPref])
    {
        [staticLabelTexts insertObject:@"Staff Name" atIndex:2];
        [DynamicLabelTexts insertObject:self.prefStaffName atIndex:2];
    }
    
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    //set the content view of the scrollview
    if (label2Y_cord +35 >= scrollViewHeight)
    {
        scrollView.contentSize = CGSizeMake(Screen_Width, label2Y_cord+35);
    }
    // add booking button 
    [self drawBookButton];
    //set the contentsize of the scroolview
                         
}

-(void) updateBookingTime;
{
    DLog(@"bookingTime %@     %@",bookingTime , [NSString stringWithFormat:@"%d",bookedService.serviceTime]);
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:bookingTime,[NSString stringWithFormat:@"%d",bookedService.serviceTime], nil];
    
	//Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"updateNextBookingTime" 
														object:dataArray];
    [dataArray release];	
}

-(void)drawBookButton
{
    // add booking button note new y is already calculated
	
	UIImage *BookNowBtnImage  = [UIImage imageNamed:Enabled_Book_button];
	
    UIButton *bookButton = [[UIButton alloc] initWithFrame: CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)]; 
	[bookButton setBackgroundImage:BookNowBtnImage forState:UIControlStateNormal];
	
    [bookButton addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookButton];
	[bookButton release];
	
}

-(void)bookAction:(id) sender
{
    DLog(@"take booking action");
	
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
	[appDelegate.activityIndicator.activity startAnimating];
	
	//If there are colflicts with the bookings exists
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOKPressed:)
                                                 name:@"OKPressed" object:nil];
	
	//Fetch the data to check if there are conflict doesn't exist
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createSpaServiceBooking:)
                                                 name:@"NoSpaConflictsNotification" object:nil];

	[spaCustConflictingBookingsVC checkForSpaCustomerConflicts:bookedService forDateAndTime:[[spaAvailibilities objectAtIndex:0] startTime]];
}

#pragma mark Notifications received
//Pop to the main screen to reselect the date or time as there are conflicts
-(void) onOKPressed:(NSNotification *) notice
{
	DLog(@"onOKPressed");
	
	[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] 
										  animated:YES];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"OKPressed" object:nil];
}

-(void) createSpaServiceBooking:(NSNotification *) notice
{
	DLog(@"createSpaServiceBooking");	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"NoSpaConflictsNotification" object:nil]; 
	
    [self createSpaBooking];
	
}

-(void)createSpaBooking
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *bodyString = [NSString stringWithFormat: 
							@"<rsap:CreateSpaBookingRequest>"
							@"<AuthorizationId>%@</AuthorizationId>"
							"<CustomerId>%@</CustomerId>"
							@"<SpaItemId>%@</SpaItemId>"
							@"<StartDateTime>%@</StartDateTime>"
							"<SpaStaffId>%@</SpaStaffId>"
							"</rsap:CreateSpaBookingRequest>",
							[prefs stringForKey:AuthorizationIdKey],
							[prefs stringForKey:CustomerIdKey],
							[NSString stringWithFormat:@"%d", bookedService.spaItemID],
							[[spaAvailibilities objectAtIndex:0] startTime],
							[NSString stringWithFormat:@"%d",[[spaAvailibilities objectAtIndex:0] spaStaffID]]
							];
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	DLog(@"soapStr: %@", soapString);
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
    //If Ws response is of type spaService
	if ([responseString rangeOfString:@"CreateSpaBookingResponse"].length > 0)
    {
        if (self.spaServiceBookingParser) {
            self.spaServiceBookingParser = nil;
        }
        spaServiceBookingParser = [[RSSpaServiceBookingParser alloc] init];
        spaServiceBookingParser.delegate = self;                
        [spaServiceBookingParser parse:dataFromWS];	
    }
    else
    {
        ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"exception while booking"];
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
		if (resultError.ErrorID == kGuaranteeRequiredErrorId) {
            [errorPopup initWithErrorId:resultError.ErrorID];
        }
        else{
            [errorPopup initWithTitle:errorMessage];    
        }
	}	
	else if ([parserModelData isKindOfClass:[RSSpaServiceBooking class]]) {
		//Booking successful
        [self updateBookingTime];

		RSSpaBookingConfirmationVC *spaBookingConfirmVC = [[RSSpaBookingConfirmationVC alloc] init];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}


-(void)displayBookingOption
{
    [self createTitleHeader:@"Select an Appointment" yPosition:RSCBCTiltleYcord];
    [self createMessage:@"The requested time slot is not available,Please select the following alternate time" yPostion:RSCBCMessageYcord];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

#pragma mark - Date formatting

-(NSDate *)dateFromString:(NSString *)stringDate {
 	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy hh:mm a"];		

    //Need to set one day ahead, dont know why.
    NSDate *Date = [dateFormatter dateFromString:stringDate];
	[dateFormatter release];	
	return Date;	
}


@end

