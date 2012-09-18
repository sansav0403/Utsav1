//
//  NewUserForm.m
//  ResortSuite
//
//  Created by Cybage on 12/23/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "NewUserForm.h"
#import "SoapRequests.h"
#import "ErrorPopup.h"
#import "RSDateSelectionVC.h"
#import <QuartzCore/QuartzCore.h>
@implementation NewUserForm

#define adjustScrollContentSizeto 1100
#define Y_Sepration  40.0
#define initialScrollContentSize 1000
@synthesize containerScrollView;

@synthesize genderTxtView;
@synthesize salutaionTxtView;
@synthesize firstNameTxtView;
@synthesize lastNameTxtView;
@synthesize emailTxtView;
@synthesize confirmEmailTxtView;
@synthesize PasswordTxtView;
@synthesize ConfirmPasswordTxtView;
@synthesize dobTxtView;

@synthesize homePhoneTxtView;
@synthesize workPhExtensionTxtView;
@synthesize WorkPhoneTxtView;
@synthesize OtherPhoneTxtView;

@synthesize address1TxtView;
@synthesize address2TxtView;
@synthesize cityTxtView;
@synthesize stateTxtView;
@synthesize countryTxtView;
@synthesize ZipTxtView;

@synthesize address1Label;
@synthesize address2Label;
@synthesize cityLabel;
@synthesize stateLabel;
@synthesize countryLabel;
@synthesize zipLabel;
//--
@synthesize otherAddressOptionalLabel;
//@synthesize otherAddressOptionalButton;

@synthesize otherAddress1TxtView;
@synthesize otherAddress2TxtView;
@synthesize otherCityTxtView;
@synthesize otherStateTxtView;
@synthesize otherCountryTxtView;
@synthesize otherZipTxtView;

@synthesize otherAddress1Label;
@synthesize otherAddress2Label;
@synthesize otherCityLabel;
@synthesize otherStateLabel;
@synthesize otherCountryLabel;
@synthesize otherZipLabel;

@synthesize mainWorkButton;
@synthesize mainOtherButton;
@synthesize mainHomeButton;

@synthesize BGImageView;
@synthesize whiteOverLayImageView;

@synthesize responseString;
@synthesize createCustomerParser;
-(void)dealloc
{
    [containerScrollView release];

    [genderTxtView release];
    [salutaionTxtView release];
    [firstNameTxtView release];
    [lastNameTxtView release];
    [emailTxtView release];
    [confirmEmailTxtView release];
    [PasswordTxtView release];
    [ConfirmPasswordTxtView release];
    [dobTxtView release];
    
    [homePhoneTxtView release];
    [workPhExtensionTxtView release];
    [WorkPhoneTxtView release];
    [OtherPhoneTxtView release];
    
    [address1TxtView release];
    [address2TxtView release];
    [cityTxtView release];
    [stateTxtView release];
    [countryTxtView release];
    [ZipTxtView release];
    
    [address1Label release];
    [address2Label release];
    [cityLabel release];
    [stateLabel release];
    [countryLabel release];
    [zipLabel release];
    
    [mainHomeButton release];
    [mainOtherButton release];
    [mainWorkButton release];
    //---
    [otherAddressOptionalLabel release];
//    [otherAddressOptionalButton release];
    
    [otherAddress1TxtView release];
    [otherAddress2TxtView release];
    [otherCityTxtView release];
    [otherStateTxtView release];
    [otherCountryTxtView release];
    [otherZipTxtView release];
    
    [otherAddress1Label release];
    [otherAddress2Label release];
    [otherCityLabel release];
    [otherStateLabel release];
    [otherCountryLabel release];
    [otherZipLabel release];
    //---
    
    [BGImageView release];
    [whiteOverLayImageView release];
    
    [salutationArray release];
    [genderArray release];
    [responseString release];
    [createCustomerParser release];
    
    [mainHomePhoneSelectionState release];
    [mainWorkPhoneSelectionState release];
    [mainOtherPhoneSelectionState release];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [self ResignResponderForAllTextField];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
enum tableTag
{
    genderTableTag,
    salutationTableTag
};

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self setTitle:@"New User"];
    [BGImageView setImage:[UIImage imageNamed:Application_HomeScreen]];
    [whiteOverLayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
    genderArray = [[NSArray alloc]initWithObjects:Gender_Male,Gender_Female,Gender_No_answer, nil];
    salutationArray = [[NSArray alloc]initWithObjects:Salutation_Mr,Salutation_Ms,Salutation_Mrs,Salutation_Miss,Salutation_Dr,Salutation_Mr_Mrs, nil];

    [containerScrollView setContentSize:CGSizeMake(Screen_Width, initialScrollContentSize)];
    

    // home phone is main by default,
    mainHomePhoneSelectionState = [[NSMutableString alloc]initWithString:@""];  //primary=\"true\"
    mainWorkPhoneSelectionState = [[NSMutableString alloc]initWithString:@""];
    mainOtherPhoneSelectionState = [[NSMutableString alloc]initWithString:@""];


    
   
}
#pragma mark Date selection notification action
- (void) onPickerValueChanged:(NSNotification *)notice
{
    NSString *date = [notice object];
    [dobTxtView setText:date];
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
#pragma mark - Done Button Action
-(IBAction)DoneBtnAction:(id)sender
{
    if ([self allFieldValidated])   //validate all mandatory fields then create request
    {
        [self createNewUserRequest];
    }
  
}
-(IBAction)cancelBtnAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)selectMainPhone:(id)sender
{
    UIButton *selectedButton = (UIButton *)sender;
    int selectedButtonTag = selectedButton.tag;
    switch (selectedButtonTag) {
        case mainHomePhone:
        {
            [mainHomeButton setSelected:YES];
            [mainWorkButton setSelected:NO];
            [mainOtherButton setSelected:NO];
        }
        break;
            
        case mainWorkPhone:
        {
            [mainWorkButton setSelected:YES];
            [mainHomeButton setSelected:NO];
            [mainOtherButton setSelected:NO];
        }           
        break;
            
        case mainOtherPhone:
        {
            [mainOtherButton setSelected:YES];
            [mainWorkButton setSelected:NO];
            [mainHomeButton setSelected:NO];
        }            
        break;
            
        default:
            break;
    }
    
    
}
#pragma mark - textfield Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == salutaionTxtView)
    {
        [self ResignResponderForAllTextField];
        optionPickerView = [[OptionPickerView alloc]initWithNibName:@"OptionPickerView" bundle:[NSBundle mainBundle]];
        optionPickerView.selectedTextFeildTag = salutaionTxtView.tag;
        [optionPickerView setDelegate:self];      
        
        
        [optionPickerView setOptionArray:salutationArray];
        [self.view addSubview:optionPickerView.view];
        [CATransaction begin];
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [optionPickerView.view setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [[optionPickerView.view layer] addAnimation:animation forKey:@"Push"];
        [CATransaction commit];

        return NO;
    }
    else if (textField == dobTxtView)
    {
        [self ResignResponderForAllTextField];
        dobPicker = [[DOBPickerView alloc]initWithNibName:@"DOBPickerView" bundle:[NSBundle mainBundle]];
        [dobPicker setDelegate:self];
        
        [self setTheContentOffsetOfScrollViewFortextView:dobTxtView];
        [self.view addSubview:dobPicker.view];
        
        [CATransaction begin];
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [dobPicker.view setFrame:CGRectMake(0, 10, Screen_Width, Screen_Height)];
        [[dobPicker.view layer] addAnimation:animation forKey:@"Push"];
        [CATransaction commit];
        return NO;
        
    }
    else if (textField == genderTxtView) {

        
        [self ResignResponderForAllTextField];
        optionPickerView = [[OptionPickerView alloc]initWithNibName:@"OptionPickerView" bundle:[NSBundle mainBundle]];
        optionPickerView.selectedTextFeildTag = genderTxtView.tag;
        [optionPickerView setDelegate:self];      
        
        
        [optionPickerView setOptionArray:genderArray];
        [self setTheContentOffsetOfScrollViewFortextView:genderTxtView];    //change the position of gender array on selection.
        [self.view addSubview:optionPickerView.view];

        [CATransaction begin];
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [optionPickerView.view setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [[optionPickerView.view layer] addAnimation:animation forKey:@"Push"];
        [CATransaction commit];
        
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField == emailTxtView)
    {
        [textField resignFirstResponder];        
        
    }
    else if (textField == confirmEmailTxtView)
    {
        [textField resignFirstResponder];
        [self setTheContentOffsetOfScrollViewFortextView:confirmEmailTxtView];
        
    }
    else if(textField == PasswordTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:PasswordTxtView];
    }
    else if(textField == ConfirmPasswordTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:ConfirmPasswordTxtView];
    }
    else if(textField == homePhoneTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:homePhoneTxtView];
    }
    else if(textField == WorkPhoneTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:WorkPhoneTxtView];
    }
    else if(textField == workPhExtensionTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:workPhExtensionTxtView];
    }
    else if(textField == OtherPhoneTxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:OtherPhoneTxtView];
    }
 
    else if(textField == address1TxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:address1TxtView];
    }
    else if(textField == address2TxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:address2TxtView];
    }
    
    else if (textField == cityTxtView)   //change the ontent size after city
    {
        //[containerScrollView setContentSize:CGSizeMake(Screen_Width, 850)];
        [self setTheContentOffsetOfScrollViewFortextView:cityTxtView];
    }
    else if (textField == stateTxtView)   //change the ontent size after state
    {
        //[containerScrollView setContentSize:CGSizeMake(Screen_Width, 850)];
        [self setTheContentOffsetOfScrollViewFortextView:stateTxtView];
    }
    else if (textField == countryTxtView)   //change the ontent size after country
    {
        //[containerScrollView setContentSize:CGSizeMake(Screen_Width, 850)];
        [self setTheContentOffsetOfScrollViewFortextView:countryTxtView];
    }
    else if (textField == ZipTxtView)   //change the ontent size after zip
    {
        //[containerScrollView setContentSize:CGSizeMake(Screen_Width, 850)];
        [self setTheContentOffsetOfScrollViewFortextView:ZipTxtView];
    }
    // other address
    else if(textField == otherAddress1TxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:otherAddress1TxtView];
    }
    else if(textField == otherAddress2TxtView)
    {
        [self setTheContentOffsetOfScrollViewFortextView:otherAddress2TxtView];
    }
    
    else if (textField == otherCityTxtView)   //change the ontent size after city
    {
        [containerScrollView setContentSize:CGSizeMake(Screen_Width, adjustScrollContentSizeto)];
        [self setTheContentOffsetOfScrollViewFortextView:otherCityTxtView];
    }
    else if (textField == otherStateTxtView)   //change the ontent size after state
    {
        [containerScrollView setContentSize:CGSizeMake(Screen_Width, adjustScrollContentSizeto)];
        [self setTheContentOffsetOfScrollViewFortextView:otherStateTxtView];
    }
    else if (textField == otherCountryTxtView)   //change the ontent size after country
    {
        [containerScrollView setContentSize:CGSizeMake(Screen_Width, adjustScrollContentSizeto)];
        [self setTheContentOffsetOfScrollViewFortextView:otherCountryTxtView];
    }
    else if (textField == otherZipTxtView)   //change the ontent size after zip
    {
        [containerScrollView setContentSize:CGSizeMake(Screen_Width, adjustScrollContentSizeto)];
        [self setTheContentOffsetOfScrollViewFortextView:otherZipTxtView];
    }

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //resign keyboard always
    //also hide the salutation and gender table if visisble

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - animation function

// set the content offset of the scroll with animation
-(void)setTheContentOffsetOfScrollViewFortextView:(UITextField *)txtView
{
    //get the cordinate of the textview and set the scroll content offset
    CGFloat txtFieldYCords = [txtView frame].origin.y;
    CGFloat scrollXcontentOffset = [containerScrollView contentOffset].x;
    [containerScrollView  setContentOffset:CGPointMake(scrollXcontentOffset, txtFieldYCords-80) animated:YES];
}
#pragma mark - Validation function
+(BOOL) ValidatePhoneNumber:(NSString *)phoneNum
{
    NSString *str=@"^\\+(?:[0-9] ?){6,14}[0-9]$";
    NSPredicate *no=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];

    BOOL isValid = [no evaluateWithObject:phoneNum];
    return isValid;

}
+(BOOL) ValidateText:(NSString *)string
{
    if ([string isEqualToString:@""] || [string isEqual:nil]) {

        return NO;
    }else
    {
        return YES;
    }

}

+(BOOL) validateEmail: (NSString *) email 
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

-(BOOL) validateIfAtLeastOnePhoneNumberIsProvided
{
//    IBOutlet UITextField *homePhoneTxtView;
//    IBOutlet UITextField *WorkPhoneTxtView;
//    IBOutlet UITextField *workPhExtensionTxtView;
//    IBOutlet UITextField *OtherPhoneTxtView;
    if ( ([NewUserForm ValidateText:homePhoneTxtView.text]) || ([NewUserForm ValidateText:WorkPhoneTxtView.text]) || ([NewUserForm ValidateText:OtherPhoneTxtView.text])) {
        return YES;
    }
    return NO;
}


#pragma mark - Alert messages
-(void) alertForInvalidPhoneNumber
{
    [self createAlertMessageWithTitle:@"Warning" withMessage:@"Please Enter correct contact no." withDelegate:nil];
}

-(void) alertForInvalidText
{
    [self createAlertMessageWithTitle:alertTitleForInvalidText withMessage:alertMessageForInvalidText withDelegate:nil];
}
-(void) alertForEmptyGender
{
    [self createAlertMessageWithTitle:alertTitleForEmptyGender withMessage:alertMessageForEmptyGender withDelegate:nil];
}
-(void)alertForValidSalutation
{
    [self createAlertMessageWithTitle:alertTitleForValidSalutation withMessage:alertMessageForValidSalutation withDelegate:nil];
}
-(void)alertForInvalidEmailAddress
{
    [self createAlertMessageWithTitle:alertTitleForInvalidEmailAddress withMessage:alertMessageForInvalidEmailAddress withDelegate:nil];
}
-(void) alertForUnmatchedEmail
{
    [self createAlertMessageWithTitle:alertTitleForUnmatchedEmail withMessage:alertMessageForUnmatchedEmail withDelegate:nil];
}
-(void)alertForImproperPassord
{
    [self createAlertMessageWithTitle:alertTitleForImproperPassord withMessage:[NSString stringWithFormat:alertMessageForImproperPassord,PASSWORD_REQ_LENGTH] withDelegate:nil];
}
-(void) alertForUnmatchedPassword
{
    [self createAlertMessageWithTitle:alertTitleForUnmatchedPassword withMessage:alertMessageForUnmatchedPassword withDelegate:nil];
}
-(void) alertForAtleastOnePhoneNumber
{
    [self createAlertMessageWithTitle:alertTitleForAtleastOnePhoneNumber withMessage:alertMessageForAtleastOnePhoneNumber withDelegate:nil];
}
#pragma mark - UIalertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == successAlertView)
    {        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"createUserSuccessful" object:[self.emailTxtView text]];
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
    [self.navigationController popToRootViewControllerAnimated:YES];   
}

#pragma mark create new user request
-(void) createNewUserRequest
{

    NSString *genderChar;
    if ([[self.genderTxtView text] isEqualToString:SpaBookingStaffMale]) {
        genderChar = [NSString stringWithFormat:@"M"];
    }
    else
    {
        genderChar = [NSString stringWithFormat:@"F"];
    }
    //-----------
    //set string to defaulst
    if (mainHomeButton.isSelected) {
        [mainHomePhoneSelectionState setString:@" primary=\"true\""];
    }
    else if(mainOtherButton.isSelected)
    {
        [mainOtherPhoneSelectionState setString:@" primary=\"true\""];
    }
    else if(mainWorkButton.isSelected)
    {
        [mainWorkPhoneSelectionState setString:@" primary=\"true\""];
    }
    
    DLog(@"main phone status is home = %@, work = %@, other = %@",mainHomePhoneSelectionState,mainWorkPhoneSelectionState,mainOtherPhoneSelectionState);
    //
    NSString *requestBody = [NSString stringWithFormat: 
                             @"<rsap:CreateCustomerRequest>"
                             "<Source>IPHONE</Source>"
                             "<Name>"
                             "<Salutation>%@</Salutation>"  //Mr.
                             "<FirstName>%@</FirstName>"    //Joe
                             "<LastName>%@</LastName>"      //Black
                             "</Name>"
                             "<EmailAddress>%@</EmailAddress>"    //joe@email.com
                             "<Password>%@</Password>"
                             "<!--Optional:-->"
                             "<Gender>%@</Gender>"
                             "<!--Optional:-->"
                             "<DateOfBirth>%@</DateOfBirth>"    //01-JAN-1960
                             "<!--0 to 2 repetitions:-->"
                             "<Address type=\"HOME\">"
                             "<!--Optional:-->"
                             "<Address1>%@</Address1>"
                             "<!--Optional:-->"
                             "<Address2>%@</Address2>"
                             "<!--Optional:-->"
                             "<City>%@</City>"
                             "<!--Optional:-->"
                             "<StateProv>%@</StateProv>"
                             "<!--Optional:-->"
                             "<Country>%@</Country>"
                             "<!--Optional:-->"
                             "<PostCode>%@</PostCode>"    //L4Y-8U7
                             "</Address>"
                             "<Address type=\"OTHER\">"
                             "<!--Optional:-->"
                             "<Address1>%@</Address1>"
                             "<!--Optional:-->"
                             "<Address2>%@</Address2>"
                             "<!--Optional:-->"
                             "<City>%@</City>"
                             "<!--Optional:-->"
                             "<StateProv>%@</StateProv>"
                             "<!--Optional:-->"
                             "<Country>%@</Country>"
                             "<!--Optional:-->"
                             "<PostCode>%@</PostCode>"
                             "</Address>"
                             "<!--0 to 3 repetitions:-->"
                             "<Phone type=\"HOME\"%@>"   //primary=\"true\"
                             "<!--You have a CHOICE of the next 2 items at this level-->"
                             "<!--Optional:-->"
                             "<PhoneNumber>%@</PhoneNumber>"
                             "</Phone>"
                             "<Phone type=\"OTHER\"%@>"        //primary=\"true\"
                             "<!--You have a CHOICE of the next 2 items at this level-->"
                             "<!--Optional:-->"
                             "<PhoneNumber>%@</PhoneNumber>"
                             "</Phone>"
                             "<Phone type=\"WORK\"%@>"     //primary=\"true\"
                             "<!--You have a CHOICE of the next 2 items at this level-->"
                             "<!--Optional:-->"
                             "<PhoneNumber>%@</PhoneNumber>"
                             "<!--Optional:-->"
                             "<PhoneData>"
                             "<!--Optional:-->"
                             "<PhoneNumber>%@</PhoneNumber>"
                             "<!--Optional:-->"
                             "<Extension>%@</Extension>"
                             "</PhoneData>"
                             "</Phone>"
                             "</rsap:CreateCustomerRequest>",
                             [self.salutaionTxtView text],
                             [self.firstNameTxtView text],
                             [self.lastNameTxtView text],
                             [self.emailTxtView text],
                             [self.PasswordTxtView text],
                             genderChar , //pass M/F
                             [self.dobTxtView text],
                             [self.address1TxtView text],
                             [self.address2TxtView text],
                             [self.cityTxtView text],
                             [self.stateTxtView text],
                             [self.countryTxtView text],
                             [self.ZipTxtView text],//-------
                             [self.otherAddress1TxtView text],
                             [self.otherAddress2TxtView text],
                             [self.otherCityTxtView text],
                             [self.otherStateTxtView text],
                             [self.otherCountryTxtView text],
                             [self.otherZipTxtView text],//----
                             mainHomePhoneSelectionState,
                             [self.homePhoneTxtView text],
                             mainOtherPhoneSelectionState,
                             [self.OtherPhoneTxtView text],
                             mainWorkPhoneSelectionState,
                             [self.WorkPhoneTxtView text],
                             [self.WorkPhoneTxtView text],
                             [self.workPhExtensionTxtView text]                             
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
    
    DLog(@" request body: %@",soapString);
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	if (self.responseString) {		
        self.responseString = nil;
	}
	responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    DLog(@"responseString ===== \n%@",responseString);
    if ([self.responseString rangeOfString:@"CreateCustomerRespons"].length > 0) {
		if (self.createCustomerParser) {
            self.createCustomerParser = nil;
		}
		createCustomerParser = [[RSCreateCustomerParser alloc] init];
		createCustomerParser.delegate = self;
		[createCustomerParser parse:dataFromWS];
	}
    else
    {
        //show error
        [self createAlertMessageWithTitle:nil withMessage:@"Error" withDelegate:nil];
        if([appDelegate.activityIndicator.activity isAnimating]) {
            [appDelegate.activityIndicator.activity stopAnimating];
            [appDelegate.activityIndicator.view removeFromSuperview];
        }
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
	else if ([parserModelData isKindOfClass:[RSCreateCustomerParser class]]) {
		[self createCustomerDataRecieved:parserModelData];
	}
}
#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{

    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    [self.emailTxtView setText:@""];
}
-(void)createCustomerDataRecieved:(id)parserModelData
{
    //show alert for success

    successAlertView = [[UIAlertView alloc]initWithTitle:alertTitleForUserCreated message:alertMessageForUserCreated delegate:self cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [successAlertView show];
    [successAlertView release];
}
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

//validate field in the form

-(BOOL) allFieldValidated
{
    //create a bool to keep track of all validation
    BOOL allValidated = NO;
    
    if ([NewUserForm ValidateText:[salutaionTxtView text]]) {
        allValidated = YES;
    }
    else
    {
        [self alertForValidSalutation];
        [salutaionTxtView becomeFirstResponder];
        return NO;
    }

        if ([NewUserForm ValidateText:[firstNameTxtView text]]) {
            allValidated = YES;
        }
        else
        {
            [self alertForInvalidText];
            [firstNameTxtView becomeFirstResponder];
            return NO;
        }
    

        if ([NewUserForm ValidateText:[lastNameTxtView text]]) {
             allValidated = YES;
        }
        else
        {
            [self alertForInvalidText];
            [lastNameTxtView becomeFirstResponder];
            return NO;
        }

        //first validate email address
        //then make confirmemailtxtview the responder
        if ([NewUserForm validateEmail:[emailTxtView text]]) {
            allValidated = YES;
            
        }else
        {
            //pop an alert view to say invalid email address
            [self alertForInvalidEmailAddress];
            [emailTxtView setText:@""];
            [emailTxtView becomeFirstResponder];
            return NO;
        }
    
        if ([[confirmEmailTxtView text]isEqualToString:[emailTxtView text]])
        {
            allValidated = YES;
        }
        else
        {  
            [self alertForUnmatchedEmail];
            [confirmEmailTxtView setText:@""];
            [confirmEmailTxtView becomeFirstResponder];
            return NO;
        }

 
        if ([[PasswordTxtView text] length] >= 8) {
            allValidated = YES;
        }
        else
        {
            [self alertForImproperPassord];
            [PasswordTxtView setText:@""];
            [PasswordTxtView becomeFirstResponder];
            return NO;
        }
        

        if ([[ConfirmPasswordTxtView text]isEqualToString:[PasswordTxtView text]])
        {
            allValidated = YES;
        }
        else
        {
            [self alertForUnmatchedPassword];
            [ConfirmPasswordTxtView setText:@""];
            [ConfirmPasswordTxtView becomeFirstResponder];
            return NO;
        }
    if ([NewUserForm ValidateText:[genderTxtView text]]) {
        allValidated = YES;
    }
    else
    {
        [self alertForEmptyGender];
        [genderTxtView becomeFirstResponder];
        return NO;
    }
    //also put a condition for atleast one phone number
    if ([self validateIfAtLeastOnePhoneNumberIsProvided]) {
        allValidated = YES;
    }
    else
    {
        [self alertForAtleastOnePhoneNumber];
        [homePhoneTxtView becomeFirstResponder];
        return NO;
    }
    if (allValidated) {
        return allValidated;
    }
    return allValidated;
}
#pragma mark - DOBPickerView delegate method
-(void)dateSelected:(NSString *)date
{
    [dobPicker.view removeFromSuperview];
    [dobTxtView setText:date];
    dobPicker = nil;
}
#pragma mark - OptionPicker delegate method
-(void)selectedOption:(NSString *)option withSelectedTextFeildTag:(int)tag
{
    if (tag == 0) {
        [optionPickerView.view removeFromSuperview];
        [salutaionTxtView setText:option];
        optionPickerView = nil;
    }
    else if (tag == 1) {
        [optionPickerView.view removeFromSuperview];
        [genderTxtView setText:option];
        optionPickerView = nil;
    }

}

#pragma mark - animation
-(void)doAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
}
-(void)ResignResponderForAllTextField
{
    [genderTxtView resignFirstResponder];
    [salutaionTxtView resignFirstResponder];
    [firstNameTxtView resignFirstResponder];
    [lastNameTxtView resignFirstResponder];
    [emailTxtView resignFirstResponder];
    [confirmEmailTxtView resignFirstResponder];
    [PasswordTxtView resignFirstResponder];
    [ConfirmPasswordTxtView resignFirstResponder];
    [dobTxtView resignFirstResponder];
    
    [homePhoneTxtView resignFirstResponder];
    [workPhExtensionTxtView resignFirstResponder];
    [WorkPhoneTxtView resignFirstResponder];
    [OtherPhoneTxtView resignFirstResponder];
    
    [address1TxtView resignFirstResponder];
    [address2TxtView resignFirstResponder];
    [cityTxtView resignFirstResponder];
    [stateTxtView resignFirstResponder];
    [countryTxtView resignFirstResponder];
    [ZipTxtView resignFirstResponder];
    [otherAddress1TxtView resignFirstResponder];
    [otherAddress2TxtView resignFirstResponder];
    [otherCityTxtView resignFirstResponder];
    [otherStateTxtView resignFirstResponder];
    [otherCountryTxtView resignFirstResponder];
    [otherZipTxtView resignFirstResponder];
}
@end

