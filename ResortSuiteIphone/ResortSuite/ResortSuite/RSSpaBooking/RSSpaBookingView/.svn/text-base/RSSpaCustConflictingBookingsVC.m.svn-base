    //
//  RSSpaCustConflictingBookingsVC.m
//  ResortSuite
//
//  Created by Cybage on 13/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaCustConflictingBookingsVC.h"
#import "RSSpaService.h"
#import "SoapRequests.h"
#import "RSSpaCustomerConflictBookingsParser.h"
#import "RSSpaCustomerConflictingBookings.h"
#import "ResortSuiteAppDelegate.h"
#import "ErrorPopup.h"
#import "RSSpaClass.h"


@implementation RSSpaCustConflictingBookingsVC

@synthesize spaCustomerConflictBookingsParser;



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
}


- (void)dealloc {
	[spaCustomerConflictBookingsParser release];
	
    [super dealloc];
}

-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime
{
	NSString *spaItemId = nil;
	
	if ([spaServiceOrClass isKindOfClass:[RSSpaService class]]) {
		RSSpaService *service = (RSSpaService *)spaServiceOrClass;
		spaItemId = [NSString stringWithFormat:@"%d", service.spaItemID];
	}
	else if([spaServiceOrClass isKindOfClass:[RSSpaClass class]]) {
		RSSpaClass *class = (RSSpaClass *)spaServiceOrClass;
		spaItemId = [NSString stringWithFormat:@"%d", class.spaClassId];
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *bodyString = [NSString stringWithFormat: 
							@"<rsap:FetchSpaCustomerConflictingBookingsRequest>"
							"<CustomerId>%@</CustomerId>"	
							"<SpaItemId>%@</SpaItemId>"
							"<StartDateTime>%@</StartDateTime>"
							"</rsap:FetchSpaCustomerConflictingBookingsRequest>",
							[prefs stringForKey:CustomerIdKey],
							spaItemId, 
							dateTime];	//@"July 12, 2011 11:00 am"];
	
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	NSLog(@"soapString: %@", soapString);
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
	
	//If Ws response is of type SpaBooking
	if ([responseString rangeOfString:@"FetchSpaCustomerConflictingBookingsResponse"].length > 0) {
		if (self.spaCustomerConflictBookingsParser) {
			//[self.spaCustomerConflictBookingsParser release];
            self.spaCustomerConflictBookingsParser = nil;
		}
		spaCustomerConflictBookingsParser = [[RSSpaCustomerConflictBookingsParser alloc] init];
		spaCustomerConflictBookingsParser.delegate = self;
		
		[spaCustomerConflictBookingsParser parse:dataFromWS];	
	}
	[responseString release];
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	
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
	else if ([parserModelData isKindOfClass:[RSSpaCustomerConflictingBookings class]]) {		
		[self loadSpaCustomerConflictingBookingView:parserModelData];					
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}


#pragma mark Show an alert if conflicts exists
-(void) loadSpaCustomerConflictingBookingView:(id) parserModelData
{
	self.spaCustomerConflictBookingsParser.spaCustConflictBookingsModel = (RSSpaCustomerConflictingBookings *) parserModelData;
	
	//Alert the user if there are conflicts exists
	if ([self.spaCustomerConflictBookingsParser.spaCustConflictBookingsModel.spaBookings count] > 0) {
		
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:POPUP_Error
                                                            message:POPUP_Class_Already_Booked
                                                            delegate:self
                                                   cancelButtonTitle:POPUP_Button_Ok
                                                   otherButtonTitles:nil];
		
		[errorAlert show];
		[errorAlert release];		
	}
	else {
		NSLog(@"There are no conflicts. Create Spa Class Booking call");
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NoSpaConflictsNotification" 
															object:nil];
	}
}

#pragma mark Action event if conflict exists and user clicks OK
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clicked the OK button
	if (buttonIndex == [alertView cancelButtonIndex]) {
		//Navigate to the Date selection view
		[[NSNotificationCenter defaultCenter] postNotificationName:@"OKPressed" 
						object:self.spaCustomerConflictBookingsParser.spaCustConflictBookingsModel];
	}
}


@end
