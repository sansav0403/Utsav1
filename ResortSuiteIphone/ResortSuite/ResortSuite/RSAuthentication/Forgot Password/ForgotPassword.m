//
//  ForgotPassword.m
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "ForgotPassword.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
#import "ErrorPopup.h"
@implementation ForgotPassword
@synthesize responseString;
@synthesize resetPasswordParser;
@synthesize emailAddressTxtView;
@synthesize BGImageView;
@synthesize whiteOverLayImageView;

-(void)dealloc
{
    [resetPasswordParser release];
    [responseString release];
    [BGImageView release];
    [whiteOverLayImageView release];
    [emailAddressTxtView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self setTitle:FORGOT_PASSWORD_VIEW_TITLE];
    [BGImageView setImage:[UIImage imageNamed:Application_HomeScreen]];
    [whiteOverLayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
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

#pragma mark - button action methods
-(IBAction)resetButton:(id)sender
{
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        [emailAddressTxtView resignFirstResponder];
        [self createResetPasswordRequest];
    }
    else
    {
        //pop an alert view to say invalid email address
        [self alertForInvalidEmailAddress];
        [emailAddressTxtView setText:@""];
        [emailAddressTxtView becomeFirstResponder];
    }

}

-(IBAction)cancelButton:(id)sender
{    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //test if the string is a valid email address
    if ([NewUserForm validateEmail:[textField text]]) {
        [textField resignFirstResponder];
    }
    else
    {
        //pop an alert view to say invalid email address
        [self alertForInvalidEmailAddress];
        [textField setText:@""];
        [textField becomeFirstResponder];
    }
    
    return YES;
}

#pragma mark - UIalertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //create notification and pass the email address for which user forgot 
    //the pasword and set it in the email filed in login page
    if (alertView == successAlertView)
    {        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"resetPasswordSuccessful" object:[self.emailAddressTxtView text]];
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
    [self.navigationController popToRootViewControllerAnimated:YES];   
}

#pragma mark - Alert message function
-(void)alertForInvalidEmailAddress
{    
    [self createAlertMessageWithTitle:alertTitleForInvalidEmailAddress withMessage:alertMessageForInvalidEmailAddress withDelegate:nil];
}
#pragma mark create new user request
-(void) createResetPasswordRequest
{
    NSString *requestBody = [NSString stringWithFormat:
                             @"<rsap:ResetPasswordCustomerRequest>"
                             "<Source>IPHONE</Source>"
                             "<EmailAddress>%@</EmailAddress>"    //mahanm@resortsuite.com
                             "</rsap:ResetPasswordCustomerRequest>",
                             [self.emailAddressTxtView text]
                             ];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    [self.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    
	[self fetchDataForRequestWithBody:requestBody];
}
#pragma mark Common method for creating soap request
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
    
    NSLog(@" request body: %@",soapString);
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
    if (self.responseString) {		
          self.responseString = nil;
    }
	responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    NSLog(@"responseString ===== \n%@",responseString);
    if ([self.responseString rangeOfString:@"ResetPasswordCustomerResponse"].length > 0) {
		if (self.resetPasswordParser) {
            self.resetPasswordParser = nil;
		}
		resetPasswordParser = [[RSResetPasswordParser alloc] init];
		resetPasswordParser.delegate = self;
		[resetPasswordParser parse:dataFromWS];
	}
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[RSResetPasswordParser class]]) {
		[self resetPasswordDataRecieved:parserModelData];
	}

}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    [self.emailAddressTxtView setText:@""];
}

#pragma mark - action to taken on successful responce
-(void)resetPasswordDataRecieved:(id)parserModelData
{
    //show alert for success
    RSResetPasswordParser *parser = (RSResetPasswordParser *) parserModelData;
   successAlertView = [[UIAlertView alloc]initWithTitle:parser.resetPasswordResult.resultText message:alertMessageForPassWordResset delegate:self cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [successAlertView show];
    [successAlertView release];


}

-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
@end
