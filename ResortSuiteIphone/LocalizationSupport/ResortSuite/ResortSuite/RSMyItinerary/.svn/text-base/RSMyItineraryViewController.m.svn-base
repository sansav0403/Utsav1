//
//  RSMyItineraryViewController.m
//  ResortSuite
//
//  Created by Amit Jain on 01/06/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "RSMyItineraryViewController.h"
#import "RSConnection.h"
#import "RSMyItineraryParser.h"
#import "RSMIMainScreenViewController.h"

@implementation RSMyItineraryViewController
@synthesize parserItineraryObj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//Create the Soap Message and send the inputs for parsing
-(void) getItinerary:(NSString *) PMSFolioId GuestPin:(NSString *) GuestPin
{
 	NSString *soapMessage = 
	[NSString stringWithFormat:
	 @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rsap=\"http://www.resortsuite.com/RSAPP\">" 
	 "<soapenv:Header>"
	 "<o:Security xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" soapenv:mustUnderstand=\"1\">"
	 "<o:UsernameToken>"
	 "<o:Username>resortsuite</o:Username>"
	 "<o:Password>resortsuite</o:Password>"
	 "</o:UsernameToken>"
	 "</o:Security>"
	 "</soapenv:Header>"
	 "<soapenv:Body>"
	 "<rsap:FetchGuestItineraryRequest>"
	 "<PMSFolioId>%@</PMSFolioId>"
	 "<GuestPin>%@</GuestPin>"
	 "</rsap:FetchGuestItineraryRequest>"
	 "</soapenv:Body>"
	 "</soapenv:Envelope>",PMSFolioId, GuestPin
	 ];
	
	parserItineraryObj = [[RSMyItineraryParser alloc] init];
	parserItineraryObj.delegate = self;
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapMessage];
    
	
}
#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	[parserItineraryObj parse:dataFromWS];
}
#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{

	
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
