//
//  Authentication.m
//  ResortSuite
//
//  Created by Cybage on 02/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "Authentication.h"


@implementation Authentication

@synthesize txtFieldPMSFolioId;
@synthesize txtFieldGuestPin;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
    }
	return self;
}

- (id)initWithTitle:(NSString *)title 
			message:(NSString *)message 
		   delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
	  okButtonTitle:(NSString *)okayButtonTitle {    
	
	if ((self = [super initWithTitle:title 
							message:message 
						   delegate:delegate 
				  cancelButtonTitle:cancelButtonTitle 
				  otherButtonTitles:okayButtonTitle, nil])) {        
		
		UITextField *thePMSFolioId = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];       
		[thePMSFolioId setBackgroundColor:[UIColor whiteColor]];     
		thePMSFolioId.autocorrectionType = UITextAutocorrectionTypeNo;
		
		#if defined(HOTEL_VERSION)
			thePMSFolioId.placeholder = @"Reservation No.";
		#elif defined(CLUB_VERSION)
			thePMSFolioId.placeholder =	@"Email Address";
			thePMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;

			#if defined(DEBUG_)
				thePMSFolioId.text = @"js@rs.com";
			#endif
		#endif

#if defined(DEBUG_)
        thePMSFolioId.text = @"js@rs.com";
#endif

		thePMSFolioId.autocapitalizationType = UITextAutocapitalizationTypeNone;
		
		[self addSubview:thePMSFolioId];      
		self.txtFieldPMSFolioId = thePMSFolioId;     
		[thePMSFolioId release]; 
		
		UITextField *theGuestPin = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)];       
		[theGuestPin setBackgroundColor:[UIColor whiteColor]];     
		theGuestPin.autocorrectionType = UITextAutocorrectionTypeNo;
		
		#if defined(HOTEL_VERSION)
			theGuestPin.placeholder = @"GuestPin";
		#elif defined(CLUB_VERSION)
			theGuestPin.placeholder = @"Password";
		
			#if defined(DEBUG_)
				theGuestPin.text = @"club12345";	
			#endif
		
		#endif	

#if defined(DEBUG_)
        theGuestPin.text = @"club12345";	
#endif

		[theGuestPin setSecureTextEntry:YES];
		[self addSubview:theGuestPin];      
		self.txtFieldGuestPin = theGuestPin;     
		[theGuestPin release];
				
		CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 20.0); 
		[self setTransform:translate];   
	}   
	
	return self;	
}

- (void)show
{   
	    
	[super show];
    [txtFieldPMSFolioId becomeFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clicked the Submit button
	if (buttonIndex == [alertView cancelButtonIndex])
	{
		
	}
}

- (void)dealloc
{   
	[txtFieldPMSFolioId release];   
	[txtFieldGuestPin release];
	
	[super dealloc];
}

@end
