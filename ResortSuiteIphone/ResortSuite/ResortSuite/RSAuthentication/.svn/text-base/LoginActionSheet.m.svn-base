//
//  ActionSheet.m
//  ActionSheetWithVC
//
//  Created by cybage on 12/15/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "LoginActionSheet.h"
#import "EmailVerificationVC.h"
#import "NewUserForm.h"
#import "ForgotPassword.h"
#import "ChangePassword.h"
@implementation LoginActionSheet

@synthesize txtFieldPMSFolioId;
@synthesize txtFieldGuestPin;
@synthesize welcomeLbl;
@synthesize welcomeMessageLbl;
@synthesize backgroundImage;
@synthesize whiteOverLayImageView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"LoginActionSheet :: Release");
    
    [txtFieldPMSFolioId release];
    [txtFieldGuestPin release];
    [welcomeMessageLbl release];
    [welcomeLbl release];
    [backgroundImage release];
    [whiteOverLayImageView release];
    delegate = nil;
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

    [backgroundImage setImage:[UIImage imageNamed:Application_HomeScreen]];
    [whiteOverLayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
//--------------------*******************************------------    
    //since comman in both Hotel and club app
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldPMSFolioId.placeholder = @"Email Address";
    txtFieldGuestPin.placeholder = @"Password";
    #if defined(DEBUG_)
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldPMSFolioId.text = @"sk@rs.com";
    txtFieldGuestPin.text = @"rsmobile123";
    #endif
    
    //register for notification from forgot/newuser
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulResetPassowrd:)
                                                 name:@"resetPasswordSuccessful" object:nil];
    //register for notification from newuser
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulCreatecustomer:)
                                                 name:@"createUserSuccessful" object:nil];
    
}

-(void)onSuccessfulResetPassowrd:(NSNotification *)notice
{
    NSLog(@"reset password successful");
    NSString *emailAddress = (NSString *)[notice object];
    [self.txtFieldPMSFolioId setText:emailAddress];
    [self.txtFieldGuestPin setText:@""];
    [self.txtFieldGuestPin setPlaceholder:@"enter new Password"];
}

-(void)onSuccessfulCreatecustomer:(NSNotification *)notice
{
    NSLog(@"create customer successful");
    NSString *emailAddress = (NSString *)[notice object];
    [self.txtFieldPMSFolioId setText:emailAddress];
    [self.txtFieldGuestPin setText:@""];
    [self.txtFieldGuestPin setPlaceholder:@"enter Password"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


#pragma mark - ButtonActionMethods

-(IBAction)loginButton:(id)sender
{
    if (delegate) {
        [txtFieldGuestPin resignFirstResponder];
        [txtFieldPMSFolioId resignFirstResponder];
        [delegate ActionSheet:self buttonSelectedAtindex:signIn];
    }
}

-(IBAction)forgotPasswordButton:(id)sender
{

    ForgotPassword *forgotPassword = [[ForgotPassword alloc]initWithNibName:@"ForgotPassword" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [self.navigationController pushViewController:forgotPassword animated:YES];
    [forgotPassword release];
}

-(IBAction)newUserButton:(id)sender
{

    //add the new user form VC modally

    EmailVerificationVC *mEmailVerificationVC = [[EmailVerificationVC alloc]initWithNibName:@"EmailVerificationVC" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [self.navigationController pushViewController:mEmailVerificationVC animated:YES];
    [mEmailVerificationVC release];

}

-(IBAction)changePasswordButton:(id)sender
{
    ChangePassword *changePassword = [[ChangePassword alloc]initWithNibName:@"ChangePassword" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [changePassword setTitle:CHANGE_PASSWORD_VIEW_TITLE];
    [self.navigationController pushViewController:changePassword animated:YES];
    [changePassword release];

}
-(IBAction)cancelButton:(id)sender
{
    if (delegate) {
        [txtFieldGuestPin resignFirstResponder];
        [txtFieldPMSFolioId resignFirstResponder];
        [delegate ActionSheet:self buttonSelectedAtindex:cancel];
    }
}

#pragma mark - textfield Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
