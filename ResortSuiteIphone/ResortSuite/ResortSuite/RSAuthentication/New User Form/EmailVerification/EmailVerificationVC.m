//
//  EmailVerificationVC.m
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EmailVerificationVC.h"
#import "NewUserForm.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
@implementation EmailVerificationVC

@synthesize BGImageView;
@synthesize whiteOverLayImageView;
@synthesize emailAddressTxtView;
@synthesize emailVerificationParser;
@synthesize responseString;
-(void)dealloc
{
    [BGImageView release];
    [whiteOverLayImageView release];
    [emailAddressTxtView release];
    [emailVerificationParser release];
    [responseString release];
    
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
    
    [self setTitle:VERIFY_EMAIL_VIEW_TITLE];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem.title = BackButtonTitle;
}

///---------------------------------------------
#pragma mark - button action methods
-(IBAction)verifyButton:(id)sender
{
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        [emailAddressTxtView resignFirstResponder];
        [self createEmailVerificationRequest];
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
    if (alertView == successAlertView)
    {        
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
    [self.navigationController popToRootViewControllerAnimated:YES];   
}

#pragma mark - Alert message function
-(void)alertForInvalidEmailAddress
{
    
    [self createAlertMessageWithTitle:@"Invalid Email Address" withMessage:@"Enter a valid email address" withDelegate:nil];
}
#pragma mark create new user request
-(void) createEmailVerificationRequest
{
    NSString *requestBody = [NSString stringWithFormat:
                             @"<rsap:CheckCustomerEmailRequest>"
                             "<Source>IPHONE</Source>"
                                "<EmailAddress>%@</EmailAddress>" 
                             "</rsap:CheckCustomerEmailRequest>",
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
    if ([self.responseString rangeOfString:@"CheckCustomerEmailResponse"].length > 0) {
		if (self.emailVerificationParser) {
            self.emailVerificationParser = nil;
		}
		emailVerificationParser = [[EmailVerificationParser alloc] init];
		emailVerificationParser.delegate = self;
		[emailVerificationParser parse:dataFromWS];
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
	else if ([parserModelData isKindOfClass:[EmailVerificationParser class]]) {
		[self verificationDataRecieved:parserModelData];
	}
    
}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{

    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    
    //push notification to signin with the registred email ID in the sigin screen
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"resetPasswordSuccessful" object:[self.emailAddressTxtView text]];
    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - action to taken on successful responce
-(void)verificationDataRecieved:(id)parserModelData
{

    
    NewUserForm *newUserForm = [[NewUserForm alloc]initWithNibName:@"NewUserForm" bundle:[NSBundle mainBundle]];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    
    [self.navigationController pushViewController:newUserForm animated:YES];
    
    [newUserForm.emailTxtView setText:[self.emailAddressTxtView text]];
    [newUserForm.confirmEmailTxtView setText:[self.emailAddressTxtView text]];
    
    [newUserForm release];

    
}

-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

@end
