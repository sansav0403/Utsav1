//
//  ErrorPopup.m
//  ResortSuite
//
//  Created by Cybage on 28/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "ErrorPopup.h"
#import "ResortSuiteAppDelegate.h"

@implementation ErrorPopup

static ErrorPopup *errorPopup=nil;

+(ErrorPopup *)sharedInstance
{
	@synchronized(self)
	{
		if(errorPopup==nil)
		{
			errorPopup=[[ErrorPopup alloc]init];
        }
	}
	return errorPopup;	
}


-(void) initWithTitle:(NSString *) title
{
	appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *errorMessage;
	
	if([title compare:POPUP_Invalid_Email] == NSOrderedSame ||
	   [title compare:POPUP_Invalid_Request] == NSOrderedSame||
	   [title compare:POPUP_Invalid_GuestPin] == NSOrderedSame ||
	   [title compare:POPUP_Invalid_FolioId] == NSOrderedSame || 
	   [title compare:POPUP_Start_End_Date] == NSOrderedSame ||
	   [title compare:POPUP_Enter_Date] == NSOrderedSame || 
	   [title compare:POPUP_No_Bookings] == NSOrderedSame)		
	{
		errorMessage = [NSString stringWithFormat:@"%@",title];			
	}
	else {
		errorMessage = POPUP_Server_Unavailable;
	}
	UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle:POPUP_Error
							   message:errorMessage
							   delegate:nil
							   cancelButtonTitle:POPUP_Button_Ok
							   otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
	
	[appDelegate.activityIndicator.activity stopAnimating];
	[appDelegate.activityIndicator.view removeFromSuperview];
}

@end
