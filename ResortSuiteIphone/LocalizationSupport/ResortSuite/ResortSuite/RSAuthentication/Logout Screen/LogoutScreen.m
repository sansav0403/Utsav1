//
//  LogoutScreen.m
//  ResortSuite
//
//  Created by Cybage on 1/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "LogoutScreen.h"
#import "ChangePassword.h"
#import "RSMainViewController.h"
@implementation LogoutScreen
@synthesize okButton;
@synthesize changeButton;
@synthesize cancelButton;
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
    DLog(@"logout released");
    [okButton release];
    [changeButton release];
    [cancelButton release];
    [backgroundImage release];
    [whiteOverLayImageView release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    //set backgroung image
    [backgroundImage setImage:[UIImage imageNamed:Application_HomeScreen]];
    [whiteOverLayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
    // set button images
    [okButton setBackgroundImage:[UIImage imageNamed:OK_Button_Enabled] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:OK_Button_Disabled] forState:UIControlStateSelected];
    
    [changeButton setBackgroundImage:[UIImage imageNamed:CHANGE_Password_Button] forState:UIControlStateNormal];
    
    [cancelButton setBackgroundImage:[UIImage imageNamed:CANCEL_Button] forState:UIControlStateNormal];
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

#pragma mark - button action

-(IBAction)okButtonAction:(id)sender
{
    if (delegate) {
        [delegate logoout:self buttonSelectedAtindex:Logout_ok];
    }
}
-(IBAction)changeButtonAction:(id)sender
{
    if (delegate) {
        [delegate logoout:self buttonSelectedAtindex:Logout_changePassword];
    }
    
}
-(IBAction)cancelButtonAction:(id)sender
{
    if (delegate) {
        [delegate logoout:self buttonSelectedAtindex:Logout_cancel];
    }
}


@end
