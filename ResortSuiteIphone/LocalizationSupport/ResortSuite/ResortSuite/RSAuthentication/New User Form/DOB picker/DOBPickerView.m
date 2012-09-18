//
//  DOBPickerView.m
//  ResortSuite
//
//  Created by Cybage on 1/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "DOBPickerView.h"

@implementation DOBPickerView
@synthesize datePicker;
@synthesize doneButton;
@synthesize delegate;
-(void) dealloc
{
    [datePicker release];
    [doneButton release];
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
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
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
    self.delegate = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - done Button action
-(IBAction)doneButtonAction:(id)sender
{
    //call the delegate method and push date value to it
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateString = [NSString stringWithString:[dateFormatter stringFromDate:datePicker.date]];
    DLog(@"date from picker = %@",dateString);
    [dateFormatter release];
    if (delegate) {
        [delegate dateSelected:dateString];
    }

}
@end
