//
//  RSBookingInfoBaseClass.m
//  ResortSuite
//
//  Created by Cybage on 9/16/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSBookingInfoBaseClass.h"


@implementation RSBookingInfoBaseClass

@synthesize infoArray;

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
    [infoArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];

    /*
     costumise the sort any in the implementing class
     add the table view to the view
    */
	
    [self createTableView];
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

#pragma mark -
#pragma mark Table view creation
-(void) createTableView
{
    tableView = [[UITableView alloc]initWithFrame:Itinerary_TableSize style:UITableViewStylePlain];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[tableView setScrollEnabled:YES];
	tableView.backgroundColor = [UIColor clearColor];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	tableView.showsHorizontalScrollIndicator = NO;
	tableView.showsVerticalScrollIndicator = YES;
	tableView.bounces = NO;
	[self.view	 addSubview:tableView];
	[tableView release];
}
#pragma mark -
#pragma mark Table view Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
