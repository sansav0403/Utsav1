//
//  RSSpaServiceDescVC.m
//  ResortSuite
//
//  Created by Cybage on 9/28/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaServiceDescVC.h"
#import "RSMainViewController.h"

#import "RSSelectedSpaLocation.h"
@implementation RSSpaServiceDescVC

@synthesize selectedService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSelectedService:(RSSpaService *)selSerivce
{
    self = [super init];
    if (self) {
        self.selectedService = selSerivce;
    }
    return self;

}
- (void)dealloc
{
    [selectedService release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];	
    [appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}
#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    valForClassOrService = 1;       //one for spaService
    if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
    

    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
    //self.navigationItem.title = [NSString stringWithFormat:@"Book %@",location.spaLocation.locationName];
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",location.spaLocation.locationName] fontSize:nil];

    [self createTitleHeader:SpaServiceDesc_TitleHeader yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamioc label text    
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:SpaServiceDesc_serviceLbl,SpaServiceDesc_DescriptionLbl,SpaServiceDesc_DurationLbl,SpaServiceDesc_PriceLbl, SpaServiceDesc_ClientInstructionLbl, nil]autorelease]; // new addition @"client Instruction :"
    
    NSMutableString *descString = [NSMutableString stringWithFormat:@"%@",selectedService.itemDesc];
    
    if ([descString isEqualToString:@""])
    {
        [descString setString:DataNotAvailable];
    }
    
    NSMutableString *instructionString = [NSMutableString stringWithFormat:@"%@",selectedService.clientInstruction];
    


    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                   selectedService.itemName,
                                   descString,
                                   [NSString stringWithFormat:@"%d", selectedService.serviceTime],
                                   [NSString stringWithFormat:@"%.02f", selectedService.price],
                                   instructionString,
                                   nil
                                   ] autorelease];
    if ([instructionString isEqualToString:@""])
    {
        [staticLabelTexts removeObjectAtIndex:4];
        [DynamicLabelTexts removeObjectAtIndex:4];
    }
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
    [self AddSelectButton];
    
}
-(void)AddSelectButton
{
    // add booking button note new y is already calculated
	UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
	[selectButton setBackgroundColor:[UIColor clearColor]];	
    
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Select_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Select_button];
	
	[selectButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[selectButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
    

    [selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    [selectButton release];

}

-(void)selectAction     //post notification
{
    NSLog(@"take select action");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"spaServiceSelected" object:selectedService];    //send the object as notification obj

    ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.bookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.bookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

@end
