    //
//  RSSpaClassDescVC.m
//  ResortSuite
//
//  Created by Cybage on 03/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaClassDescVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaClassTableViewController.h"
#import "RSSpaCustConflictingBookingsVC.h"

@implementation RSSpaClassDescVC

@synthesize selectedClass;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(id)initWithSelectedClass:(RSSpaClass *)selClass
{
    self = [super init];
    if (self) {
        self.selectedClass = selClass;
    }
    return self;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	valForClassOrService = 2;       //one for spaService
	if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}    
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",location.spaLocation.locationName] fontSize:nil];
	
    [self createTitleHeader:ClassActivityCellText yPosition:TitleHeaderYcord];  
   
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamic label text
    
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:ClassActivityCellText,ClassServiceDesc_DescriptionLbl, ClassServiceDesc_NoOfClassLbl, 
								  ClassServiceDesc_StartTimeLbl, ClassServiceDesc_DurationLbl,ClassServiceDesc_PriceLbl,ClassServiceDesc_ClientInstructionLbl, nil]autorelease];
    
    NSMutableString *descString = [NSMutableString stringWithFormat:@"%@",selectedClass.itemDescription]; //autoreleased
	if ([descString isEqualToString:@""])
    {
        [descString setString:DataNotAvailable];
    }
    
    NSMutableString *instructionString = [NSMutableString stringWithFormat:@"%@",selectedClass.clientInstruction];  //autoreleased

	
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                   selectedClass.spaItemName,
                                   descString,//selectedClass.itemDescription
								   [NSString stringWithFormat:@"%d", selectedClass.numClasses],
								   [self getDateTimeFromString:selectedClass.startTime format:@"Time"],
								   
								   [NSString stringWithFormat:@"%.0f", selectedClass.serviceTime],
                                   [NSString stringWithFormat:@"%.02f", selectedClass.price],
                                   instructionString,
                                   nil
                                   ] autorelease];
   	if ([instructionString isEqualToString:@""])
    {
        [staticLabelTexts removeObjectAtIndex:6];
        [DynamicLabelTexts removeObjectAtIndex:6];
    }
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
   
	//Add Book Now button
	bookButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
	[bookButton setBackgroundColor:[UIColor clearColor]];	

    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Select_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Select_button];
    
    [bookButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
    [bookButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    [bookButton addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookButton];	
	

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[selectedClass release];
	
    [super dealloc];
}

#pragma mark Book button action
-(void)bookAction:(id)sender
{
  DLog(@"In bookAction");

    [[NSNotificationCenter defaultCenter] postNotificationName:@"spaClassSelected" object:self.selectedClass];
	//Navigate to the Date selection view

    if (appDelegate.bookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.bookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }

}

#pragma mark Date formatting
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *) dateOrTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM dd, yyyy hh:mm a"];	
	
	NSDate *startTime = nil;
	
	if([dateOrTime isEqualToString:@"Time"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:@"HH:mm a"];
	}
	else if([dateOrTime isEqualToString:@"Date"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:@"MMMM dd, yyyy"];
	}			 
	
	NSString *startDateOrTime = [dateFormatter stringFromDate:startTime];
	[dateFormatter release];
	
	return startDateOrTime;
}

@end
