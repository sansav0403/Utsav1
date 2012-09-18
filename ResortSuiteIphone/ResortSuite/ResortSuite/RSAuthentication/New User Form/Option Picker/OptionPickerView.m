//
//  OptionPickerView.m
//  ResortSuite
//
//  Created by Cybage on 1/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "OptionPickerView.h"

@implementation OptionPickerView

@synthesize optionPicker;
@synthesize doneButton;
@synthesize delegate;
@synthesize optionArray;
@synthesize selectedTextFeildTag;

-(void) dealloc
{
    [optionPicker release];
    [doneButton release];
    [optionArray release];
    [selectedString release];
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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedString = [[NSMutableString alloc]initWithString:[optionArray objectAtIndex:0]];    //by default the first sting in the array is passed on select button action
    
    //set up button
    doneButton.frame = CGRectMake(15, 403, 286, 45);
    [doneButton setBackgroundColor:[UIColor clearColor]];
	UIImage *btnImageenabled  = [UIImage imageNamed:Enabled_Select_button];
	[doneButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
    //set the frame below the screen//
    [self.view setFrame:CGRectMake(0, 480, 320, 480)];

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
-(IBAction)doneButtonAction:(id)sender
{
    if (delegate) {
    [delegate selectedOption:selectedString withSelectedTextFeildTag:self.selectedTextFeildTag];
    }
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [optionArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
	return [optionArray objectAtIndex:row] ;
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
    //set the value for the selected string
    [selectedString setString:[optionArray objectAtIndex:row]];
}


@end
