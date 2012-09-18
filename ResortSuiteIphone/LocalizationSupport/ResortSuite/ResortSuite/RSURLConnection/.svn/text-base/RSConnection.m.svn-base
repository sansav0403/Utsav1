//
//  RSConnection.m
//  ResortSuite
//
//  Created by Cybage on 26/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSConnection.h"
#import "RSMyItineraryParser.h"

static RSConnection *urlConnection=nil;

@implementation RSConnection
@synthesize delegate;
@synthesize receivedData;
+(RSConnection *)sharedInstance
{
	@synchronized(self)
	{
		if(urlConnection==nil)
		{
			urlConnection=[[RSConnection alloc]init];
        }
	}
	return urlConnection;

}

//Create a request using the soap string and make a connection
-(void)postDataToServer:(NSString *)soapMessage
{
	isErrorAlertShown = NO;
	

// 	if (!wsdlPath) {
//		wsdlPath = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"WSDL_url"];
//	}
    
    //get endpoint url from the prefs every time webservice is hit
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![[prefs stringForKey:configStatusKey] isEqualToString:DeprecatedStatus]) {
        wsdlPath = [prefs stringForKey:endPointUrlKey];
        wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@" " withString:@""];     //removing the space character
        wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@"\n" withString:@""];    //removing the new line character

///-----------------------------
	
	NSURL *url = [NSURL URLWithString:wsdlPath];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	
    [request addValue:@"text/xml; charset=utf-8"  forHTTPHeaderField:@"Content-Type"];	//soap 1.2 change
	
	[request setHTTPMethod:@"POST"];
	
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	if (connection) {
        if(receivedData != NULL)
        {
            [receivedData release];
        }
		receivedData = [[NSMutableData data] retain];		
	}
	[connection release];	
        //----------------
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:DeprecatedVersionAlertTitle message:DeprecatedVersionAlertMessage delegate:nil cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
    }
}

-(void) showErrorAlert
{
	if (!isErrorAlertShown) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

		UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle:POPUP_Error
								   message:POPUP_Server_Unavailable
								   delegate:nil
								   cancelButtonTitle:POPUP_Button_Ok
								   otherButtonTitles:nil];
		[errorAlert show];
		[errorAlert release];
		
		ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
		
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
		
		//Set YES when alert is already shown, not to show again didFailWithError alert.
		isErrorAlertShown = YES;
	}
}

#pragma mark -
#pragma mark URL Connection Delegates
-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
	
	[self.receivedData appendData:data];	
	isErrorAlertShown = YES;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection {	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (delegate) {
	[delegate responseReceived:receivedData];
    }

	isErrorAlertShown = YES;
}
-(void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
    
	//if (!isErrorAlertShown) {
		[self showErrorAlert];
	//}	
	//Set YES when alert is already shown, not to show again timeout error alert after 10 sec
	//isErrorAlertShown = YES;
}

#pragma mark Deal with self-signed certificates

//Sent to determine whether the delegate is able to respond to a protection space’s form of authentication.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

//Sent when a connection must authenticate a challenge in order to download its request.
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
