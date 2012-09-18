//
//  RSSpaClassConfirmationVC.m
//  ResortSuite
//
//  Created by Cyabge on 10/14/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaClassConfirmationVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaClassTableViewController.h"
#import "RSSpaCustConflictingBookingsVC.h"
#import "RSSpaBookingConfirmationVC.h"
#import "RSClassBooking.h"
#import "ErrorPopup.h"
#import "SoapRequests.h"
@implementation RSSpaClassConfirmationVC
@synthesize selectedClass;

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

-(id)initWithSelectedClass:(RSSpaClass *)selClass
{
    self = [super init];
    if (self) {
        self.selectedClass = selClass;
    }
    return self;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}    
    appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];

    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",location.spaLocation.locationName] fontSize:nil];
	
    [self createTitleHeader:@"Book" yPosition:TitleHeaderYcord];  
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamic label text
    
    NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:ClassConfirmationView_Service, ClassConfirmationView_NoOfClass, 
								  ClassConfirmationView_StartTime, ClassConfirmationView_Date, ClassConfirmationView_Duration,ClassConfirmationView_Price,ClassConfirmationView_Description, nil]autorelease];
    
    NSString *descString = [NSString stringWithFormat:@"%@",selectedClass.itemDescription];
	if ([descString isEqualToString:@""])
    {
        descString = [NSString stringWithString:DataNotAvailable];
    }
	
    NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                   selectedClass.spaItemName,
                                   //selectedClass.itemDescription
								   [NSString stringWithFormat:@"%d", selectedClass.numClasses],
								   [self getDateTimeFromString:selectedClass.startTime format:@"Time"],
								   [self getDateTimeFromString:selectedClass.startTime format:@"Date"],
								   [NSString stringWithFormat:@"%.0f", selectedClass.serviceTime],
                                   [NSString stringWithFormat:@"%.02f", selectedClass.price],
                                   descString,
                                   nil
                                   ] autorelease];
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
    
	//Add Book Now button
	bookButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
	[bookButton setBackgroundColor:[UIColor clearColor]];	
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Book_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Book_button];
    
    [bookButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
    [bookButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    [bookButton addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookButton];	
	
    spaCustConflictingBookingsVC = [[RSSpaCustConflictingBookingsVC alloc] init];   //change
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
	[selectedClass release];
	[spaCustConflictingBookingsVC release];
    [super dealloc];
}

#pragma mark Book button action
-(void)bookAction:(id)sender
{
    DLog(@"In bookAction");

    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
	
    //Fetch the data to check if there are conflicts exists
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOKPressed:)
                                                 name:@"OKPressed" object:nil];
	
	//Fetch the data to check if there are conflict doesn't exist
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createSpaClassBooking:)
                                                 name:@"NoSpaConflictsNotification" object:nil];
	

	[spaCustConflictingBookingsVC checkForSpaCustomerConflicts:self.selectedClass forDateAndTime:self.selectedClass.startTime];

}


//Pop to the main screen to reselect the date or time as there are conflicts
-(void) onOKPressed:(NSNotification *) notice
{
	DLog(@"onOKPressed");
    if (appDelegate.bookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.bookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }

	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"OKPressed" object:nil]; 
}

-(void) createSpaClassBooking:(NSNotification *) notice
{
	DLog(@"createSpaClassBooking");
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"NoSpaConflictsNotification" object:nil]; 
//create spa class booking on no conflict
    [self createClassBooking];

}

-(void)createClassBooking
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:CreateClassBookingRequest>"
                             "<Source>IPHONE</Source>"
                             "<AuthorizationId>%@</AuthorizationId>"
                             "<CustomerId>%@</CustomerId>"
                             "<SpaClassId>%@</SpaClassId>"
                             "</rsap:CreateClassBookingRequest>",
                             [NSString stringWithString:[prefs stringForKey:AuthorizationIdKey]],
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             [NSString stringWithFormat:@"%d",self.selectedClass.spaClassId]
                             ];    
    
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    self.navigationController.navigationBar.userInteractionEnabled = NO; 
    DLog(@"REQUEST BODY: %@",requestBody);
    [self fetchDataForRequestWithBody:requestBody];
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
    
    DLog(@"responseString: %@", responseString);
	
	//If Ws response is of type spaService
	if ([responseString rangeOfString:@"CreateClassBookingResponse"].length > 0)
    {
        classBookingParser = [[RSClassBookingParser alloc] init];
        classBookingParser.delegate = self;                
        [classBookingParser parse:dataFromWS];	
    }
    else
    {
        ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"exception while booking"];
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
		//[self showErrorMessage:parserModelData];
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
	else if ([parserModelData isKindOfClass:[RSClassBooking class]])
    {
        DLog(@"class booking succesful");
        [classBookingParser release];
        RSSpaBookingConfirmationVC *spaBookingConfirmVC = [[RSSpaBookingConfirmationVC alloc] init];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
        
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}
}

#pragma mark Date formatting
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *) dateOrTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy hh:mm a"];	
	
	NSDate *startTime = nil;
	
	if([dateOrTime isEqualToString:@"Time"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:@"HH:mm a"];
	}
	else if([dateOrTime isEqualToString:@"Date"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:@"MMMM dd, yyyy"];
	}			 
	
	NSString *startDateOrTime = [dateFormatter stringFromDate:startTime];
	[dateFormatter release];
	
	return startDateOrTime;
}

@end
