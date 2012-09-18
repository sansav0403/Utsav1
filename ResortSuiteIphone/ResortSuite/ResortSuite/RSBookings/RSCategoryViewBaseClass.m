//
//  RSCategoryViewBaseClass.m
//  ResortSuite
//
//  Created by Cybage on 10/12/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSCategoryViewBaseClass.h"
#import "RSMainViewController.h"

@implementation RSCategoryViewBaseClass

@synthesize keyArray = _keyArray;
@synthesize categoryDictionary = _categoryDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.categoryDictionary = dictionary;
        self.keyArray = [dictionary allKeys];
    }
    return self;
}

- (void)dealloc
{
    [_categoryDictionary release];
    [_keyArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    //title header label to drawn from funtion call from sub class
    //sort the key in alphabatical order
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.keyArray = [[self.categoryDictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    //draw the picker view
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, Screen_Width, Picker_Height)];			
	_pickerView.hidden = NO;
	_pickerView.showsSelectionIndicator = YES;
	_pickerView.delegate = self;
	[self.view addSubview:_pickerView];
	[_pickerView release];
    
    //add select button
    
    [self AddSelectButtonWithTag:0];    //by default the 0th index of key array is set as tag ie All
    _selectButton.enabled = YES;
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

#pragma mark -function for view load
-(void) createTitleHeader:(NSString*)headerTitle yPosition:(float)yCoordinate
{
    UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, yCoordinate, titleLabelCord_width, titleLabelCord_height)];
	tLabel.backgroundColor = [UIColor whiteColor];
	tLabel.opaque = YES;
	tLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[tLabel setFont:[UIFont boldSystemFontOfSize:RSCBCTiltleLabelFont]];
	[tLabel setText:[NSString stringWithFormat:@"  %@", headerTitle]];
	[self.view addSubview:tLabel];
	[tLabel release];
}

-(void)AddSelectButtonWithTag:(int)rowinfo
{
    // add booking button note new y is already calculated
    _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
    [_selectButton setBackgroundColor:[UIColor clearColor]];	
    _selectButton.tag = rowinfo;
    
    
    UIImage * disabledImage =  [UIImage imageNamed:Disabled_Select_button];
    
    UIImage * enabledImage =  [UIImage imageNamed:Enabled_Select_button];
    
    [_selectButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    [_selectButton setBackgroundImage:enabledImage forState:UIControlStateNormal];

    [self.view addSubview:_selectButton];
    [_selectButton release];
    
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_keyArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	
    if ([_keyArray count] > 0) 
    {
        return [_keyArray objectAtIndex:row];
    }
	return @"";
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 	
    _selectButton.enabled = YES;
    _selectButton.tag = row;    //tag store the index of the key from the key array.
    
}
#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}

@end
