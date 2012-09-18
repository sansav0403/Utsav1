//
//  RSGolfConfirmationView.m
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSGolfConfirmationView.h"
#import "SoapRequests.h"
#import "ErrorPopup.h"
#import "RSMainViewController.h"
#import "RSGolfRatesParser.h"
#import "RSGolfRates.h"
#import "RSGolfBookingParser.h"
#import "RSSpaBookingConfirmationVC.h"
#import "RSSelectedGolfLocation.h"
@implementation RSGolfConfirmationView

@synthesize TimeOfBooking;
@synthesize selectedCourseId;
@synthesize selectedPlayers;
@synthesize golfRate;

@synthesize timeString;
@synthesize dateString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSelectedTime:(NSString *)dateTime andSelectedCourseID:(NSString *)courseId andSelectedPlayer:(NSString *)player
{
    self =[super init];
    if (self) {
        
        self.TimeOfBooking = dateTime;
        self.selectedCourseId = courseId;
        self.selectedPlayers = player;
    }
    return self;
}
- (void)dealloc
{
    [TimeOfBooking release];
    [selectedCourseId release];
    [selectedPlayers release];
    [golfRate release];
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
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:BookGolf_ViewTilte fontSize:nil];
    
    [self createTitleHeader:ConfirmGolfBookDetailheader yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
	
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];

    int dateTimeStingLen = [self.TimeOfBooking length];
    
    self.timeString = [self.TimeOfBooking substringFromIndex:dateTimeStingLen - 8];
    self.dateString = [self.TimeOfBooking substringToIndex:dateTimeStingLen - 8];
    
    NSLog(@"date=%@time=%@ss",dateString,timeString);

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:FetchGolfRatesRequest>"
                             "<Source>IPHONE</Source>"
                             "<CourseId>%@</CourseId>"
                             "<CustomerId>%@</CustomerId>"
                             "<Date>%@</Date>"
                             "<TeeTime>%@</TeeTime>"
                             "</rsap:FetchGolfRatesRequest>",
                             [NSString stringWithString:self.selectedCourseId],
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             [NSString stringWithString:dateString],
                             [NSString stringWithString:timeString]
                             ]; 
    
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    [self fetchDataForRequestWithBody:requestBody];

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
	if ([responseString rangeOfString:@"FetchGolfRatesResponse"].length > 0)
    {
        rateParser = [[RSGolfRatesParser alloc] init];
        rateParser.delegate = self;                
        [rateParser parse:dataFromWS];	
    }
    else if ([responseString rangeOfString:@"CreateGolfBookingResponse"].length > 0)
    {
        golfBookingParser = [[RSGolfBookingParser alloc] init];
        golfBookingParser.delegate = self;                
        [golfBookingParser parse:dataFromWS];	
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
//		[self showErrorMessage:parserModelData];
        Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSGolfRates class]])
    {
        
        self.golfRate = (RSGolfRates *)parserModelData;
        NSLog(@"golf Rate is %@",self.golfRate.price);
        [self createMainBodyLabelArray];
        [rateParser release];
    }
    else if ([parserModelData isKindOfClass:[RSGolfBookingParser class]])
    {
        
        NSLog(@"Golf Booking SuccesFull and golfBookingId %@",golfBookingParser.golfBookingId);
        [golfBookingParser release];
        
        //Booking successful
		
		RSSpaBookingConfirmationVC *spaBookingConfirmVC = [[RSSpaBookingConfirmationVC alloc] init];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
        
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
    
    
    
    //call a function to create atatic and dynamic label and Draw it
    
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
-(void)createMainBodyLabelArray
{
    NSLog(@"values datestrin %@ timestring %@ no of player = %@ golfrate  = %@",dateString,timeString,self.selectedPlayers,[self.golfRate price]);
   
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                         @"Date :",
                                         @"Tee Time :"
                                         ,@"# of Players :"
                                         ,@"Price per Player :"
                                         ,nil
                                         ]autorelease];
    
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                          dateString,
                                          timeString,
                                          self.selectedPlayers,
                                          [[self.golfRate price] isEqualToString:@""] ? DataNotAvailable:[self.golfRate price],
                                          nil
                                          ] autorelease];

    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
    //set the content view of the scrollview
    
    if (label2Y_cord +35 >= scrollViewHeight)
    {
        scrollView.contentSize = CGSizeMake(Screen_Width, label2Y_cord+35);
    }
    
    // add booking button 
    [self drawBookButton];
       
}

-(void)drawBookButton
{
    // add booking button note new y is already calculated
	
	UIImage *BookNowBtnImage  = [UIImage imageNamed:Enabled_Book_button];
	
    UIButton *bookButton = [[UIButton alloc] initWithFrame: CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)]; 
	[bookButton setBackgroundImage:BookNowBtnImage forState:UIControlStateNormal];
	
    [bookButton addTarget:self action:@selector(bookAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookButton];
	[bookButton release];
	
}

-(void)bookAction
{
    NSLog(@"take booking action----Create Golf Booking");

    [self createGolfBooking];

}

- (void)createGolfBooking
{  
    RSSelectedGolfLocation *selectedGolfLocation = [RSSelectedGolfLocation sharedInstance];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //[NSString stringWithString:self.TimeOfBooking]
    NSString *teetime = @"2012-08-17091000";
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:CreateGolfBookingRequest>"
                             "<Source>IPHONE</Source>"
                             "<AuthorizationId>%@</AuthorizationId>"
                             "<TeeTime>%@</TeeTime>"
                             "<CourseId>%@</CourseId>"
                             "<Players>%@</Players>"
                             "<CustomerId>%@</CustomerId>"
                             "<ItemId>%@</ItemId>"
                             "<Price>%@</Price>"
                             "<LocationId>%@</LocationId>"
                             "</rsap:CreateGolfBookingRequest>",
                             [NSString stringWithString:[prefs stringForKey:AuthorizationIdKey]],           
                             teetime,
                             [NSString stringWithString:self.selectedCourseId],
                             [NSString stringWithString:self.selectedPlayers],
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             [NSString stringWithString:self.golfRate.itemId],           
                             [NSString stringWithString:self.golfRate.price],
                             [NSString stringWithString:selectedGolfLocation.golfLocation.locationId]
                             ]; 
    NSLog(@"req Body = %@",requestBody);
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    [self fetchDataForRequestWithBody:requestBody];
}
@end
