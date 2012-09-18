//
//  ChangePassword.m
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "ChangePassword.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
#import "ErrorPopup.h"
@implementation ChangePassword
@synthesize responseString;
@synthesize changePasswordParser;
@synthesize emailAddressTxtView;
@synthesize currentPasswordTxtView;
@synthesize newerPasswordTxtView;
@synthesize confirmPasswordTxtView;
@synthesize BGImageView;
@synthesize whiteOverLayImageView;
-(void)dealloc
{
    [responseString release];
    [changePasswordParser release];
    [BGImageView release];
    [whiteOverLayImageView release];
    [emailAddressTxtView release];
    [currentPasswordTxtView release];
    [newerPasswordTxtView release];
    [confirmPasswordTxtView release];
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
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
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
-(BOOL) validNewPasswordAndConfirmPassword
{    
    if (([[newerPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH) &&([[confirmPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH)
        && ([[newerPasswordTxtView text] isEqualToString:[confirmPasswordTxtView text]]))
    {
        return  YES;
    }
    else
    {
        return  NO;
    }
}
-(IBAction)changeButton:(id)sender
{
    //change the pass word  when every field is correct.
    // 1 valid email addres
    //2 valid old password
    // current and new passwrd are same
    //create abool to keep track of all validation,set it to No if one fails
    BOOL AllVaildated = NO;
    
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        AllVaildated = YES;
    }else
    {
        [self alertForInvalidEmailAddress];
        [self.emailAddressTxtView setText:@""];
        return;
    }
    if ([[currentPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH) {  //IF LEN LESS THAN REQ PASSWORD LENGTH
        AllVaildated = YES;
    }else
    {
        [self alertForInvalidPassword];
        [self.currentPasswordTxtView setText:@""];
        return;
    }
    if ([self validNewPasswordAndConfirmPassword]) {    //FOR INVAILD NEW AND CONFIRM PASS  
        AllVaildated = YES;
    }else
    {
        [self alertForDiffNewAndConfirmPassword];
        [self.newerPasswordTxtView setText:@""];
        [self.confirmPasswordTxtView setText:@""];
        return;
    }
    if (AllVaildated) 
    {
        [self createChangePasswordRequest];
    }

}
-(IBAction)cancelButton:(id)sender
{
    
    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Alert message function
-(void)alertForInvalidEmailAddress
{
    [self createAlertMessageWithTitle:alertTitleForInvalidEmailAddress withMessage:alertMessageForInvalidEmailAddress withDelegate:nil];
}
-(void)alertForInvalidPassword
{
    [self createAlertMessageWithTitle:alertTitleForImproperPassord withMessage:[NSString stringWithFormat:alertMessageForImproperPassord,PASSWORD_REQ_LENGTH ] withDelegate:nil];
}

-(void)alertForDiffNewAndConfirmPassword
{
    [self createAlertMessageWithTitle:alertTitleForUnmatchedPassword withMessage:alertMessageForUnmatchedPassword withDelegate:nil];
}
#pragma mark - UIalertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     [self dismissModalViewControllerAnimated:YES];   
}

#pragma mark create new user request
-(void) createChangePasswordRequest
{
    NSString *requestBody = [NSString stringWithFormat:
                             @" <rsap:ChangePasswordCustomerRequest>"
                             "<Source>IPHONE</Source>"
                             "<EmailAddress>%@</EmailAddress>"  //mahan@resortsuite.com
                             "<PasswordOld>%@</PasswordOld>"  //testing1234
                             "<PasswordNew>%@</PasswordNew>"    //testing12345
                             "</rsap:ChangePasswordCustomerRequest>",
                             [self.emailAddressTxtView text],
                             [self.currentPasswordTxtView text],
                             [self.newerPasswordTxtView text]
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
    if ([self.responseString rangeOfString:@"ChangePasswordCustomerResponse"].length > 0) {
		if (self.changePasswordParser) {
            self.changePasswordParser = nil;
		}
		changePasswordParser = [[RSChangePasswordParser alloc] init];
		changePasswordParser.delegate = self;
		[changePasswordParser parse:dataFromWS];
	}
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating]) {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
	}
    if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[RSChangePasswordParser class]]) {
		[self changePasswordDataRecieved:parserModelData];
	}
}
#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{    
    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    [self.emailAddressTxtView setText:@""];
    [self.currentPasswordTxtView setText:@""];
    [self.newerPasswordTxtView setText:@""];
    [self.confirmPasswordTxtView setText:@""];
}
#pragma action to taken on successful responce
-(void)changePasswordDataRecieved:(id)parserModelData
{
    //show alert for success
    RSChangePasswordParser *parser = (RSChangePasswordParser *) parserModelData;
    successAlertView = [[UIAlertView alloc]initWithTitle:@"" message:parser.changePasswordResult.resultText delegate:self cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [successAlertView show];
    [successAlertView release];
    //perform action on change password
}
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
@end
