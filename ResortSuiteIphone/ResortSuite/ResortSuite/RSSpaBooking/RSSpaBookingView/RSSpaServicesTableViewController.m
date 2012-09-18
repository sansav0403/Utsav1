//
//  RSSpaServicesTableViewController.m
//  ResortSuite
//
//  Created by Cybage on 9/27/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaServicesTableViewController.h"
#import "RSChargeTableCellLabel.h"
#import "RSSpaServiceTableCell.h"

#import "RSSpaServiceParser.h"
#import "RSSpaService.h"
#import "ErrorPopup.h"
#import "SoapRequests.h"
#import "RSDetailsPageViewController.h"
#import "RSSpaServiceDescVC.h"
#import "RSMainViewController.h"

#import "customAccesoryButton.h"

#import "RSSpaLocation.h"
#import "RSSelectedSpaLocation.h"

#define SeriveTableColLabelYcord  titleLabelCord_y+titleLabelCord_height
#define serviceTableYcord  SeriveTableColLabelYcord + 48

@implementation RSSpaServicesTableViewController

@synthesize spaServiceArray;


-(id)initWithSpaServiceArray:(NSArray *)spaServices
{
    self = [super init];
    if (self) {
        self.spaServiceArray = spaServices;
    }
    return self;
}

- (void)dealloc
{
    [spaServiceArray release];
    
    
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

    if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
    

    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
    [ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:[NSString stringWithFormat:@"Book %@",location.spaLocation.locationName] fontSize:nil];

    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    
	[ResortSuiteAppDelegate setContactUsIcon:NO];
    
    [self createTitleLabelWithTitle:SpaServiceTable_HeaderTitle];   //draw title
    
    tableColumnTitles = [[NSArray alloc]initWithObjects:SpaServiceTableCol_ServiceLbl, SpaServiceTableCol_PriceLbl,SpaServiceTableCol_TimeLbl, nil];
    
    [self drawTableColumnTitleWithTitleArray:tableColumnTitles AtYCord: SeriveTableColLabelYcord];   //width of searchbar
    [self drawSeperatorImageAtYCord:serviceTableYcord-dot_height];
    [self createServiceTable:serviceTableYcord];
    
    [self AddSelectButtonWithTag:0];
    selectButton.enabled = NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];

    [appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self];	
}

-(void)createServiceTable:(CGFloat)coordinateY
{

	serviceTable = [[UITableView alloc]initWithFrame:CGRectMake(0, coordinateY, Screen_Width, serviceTableHeight)];
	[serviceTable setDelegate:self];
	[serviceTable setDataSource:self];
	serviceTable.allowsSelection = YES;
    serviceTable.showsVerticalScrollIndicator = YES;

	[serviceTable setBounces:YES];
	[serviceTable setBackgroundColor:[UIColor clearColor]];
	[serviceTable setSeparatorColor:[UIColor clearColor]];
	[self.view addSubview:serviceTable];
	[serviceTable release];
}

-(void)drawSeperatorImageAtYCord:(float)ycord 
{
	UIImageView *seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - dot_width)/2,  ycord, dot_width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[self.view addSubview:seperatorImage];
	[seperatorImage release];
}

-(void)drawTableColumnTitleWithTitleArray:(NSArray *)titleArray AtYCord:(float)ycord
{

    //run a loop and set each frame and text from array
    for (int i = 0; i< [titleArray count]; i++)
    {
         RSChargeTableCellLabel *label = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
        if (i == 0) {
            label.frame = CGRectMake(10, ycord, label1Width, label3_4Height); //label3_4Height 30
            label.numberOfLines = 1;
        }

        else if (i == 1) {
            label.frame = CGRectMake(label3_XCord, ycord, label3Width, label3_4Height); 
            label.numberOfLines = 1;
            [label setTextAlignment:UITextAlignmentRight];    //for price
        }
        else if (i == 2) {
            label.frame = CGRectMake(label4_XCord, ycord, label4Width, label3_4Height*1.5); 
            label.numberOfLines = 2;
        }
        label.text = [titleArray objectAtIndex:i];
        [self.view addSubview:label];
        [label release];
    }
    
}


-(void)createTitleLabelWithTitle:(NSString *)title
{
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, titleLabelCord_y, titleLabelCord_width, titleLabelCord_height)];
	titleLabel.backgroundColor = [UIColor whiteColor];
	titleLabel.opaque = YES;
	titleLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
	[titleLabel setText:[NSString stringWithFormat:@"  %@", title]];
	[self.view addSubview:titleLabel];
	[titleLabel release];
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
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [spaServiceArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSSpaServiceTableCell *locationCell = (RSSpaServiceTableCell *)[tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (locationCell == nil) {
        locationCell = [[[RSSpaServiceTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secondField:NO] autorelease];
	}
    if ([spaServiceArray count] <= 1) {
        locationCell.fieldLabel1.text = [spaServiceArray objectAtIndex:0];
        
    }
    else
    {
        locationCell.fieldLabel1.text = [(RSSpaService *)[spaServiceArray objectAtIndex:indexPath.row] itemName];
        locationCell.fieldLabel3.text = [NSString stringWithFormat:@"%.02f",[(RSSpaService *)[spaServiceArray objectAtIndex:indexPath.row] price]];
        locationCell.fieldLabel4.text = [NSString stringWithFormat:@"%d",[(RSSpaService *)[spaServiceArray objectAtIndex:indexPath.row] serviceTime]];
        

        // Configure the cell...
        
        customAccesoryButton *dButton = [[customAccesoryButton alloc] initWithFrame:CellAccessoryImageSize];
        [dButton setBackgroundColor:[UIColor clearColor]];
        UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CellAccessoryImageSize ];
        btnImage.image  = [UIImage imageNamed:CellAccessoryImageCircular];
        [dButton addSubview:btnImage];
        [btnImage release];
        
        dButton.path = indexPath;
        [dButton addTarget:self action:@selector(checkThis:) forControlEvents:UIControlEventTouchDown];
        
        [locationCell setAccessoryView:dButton];	
        [dButton release];
    }
    
    UIImageView *selectionBackground = [[UIImageView alloc] init];
	selectionBackground.image = [UIImage imageNamed:accessoryBlankImage];
	locationCell.selectedBackgroundView = selectionBackground;
	[selectionBackground release];

    return locationCell;
}

-(void)checkThis:(id)sender
{
    customAccesoryButton *button = (customAccesoryButton *)sender;
    NSIndexPath *indexPath = button.path;
    
    RSSpaServiceDescVC *spaServiceDescVC = [[RSSpaServiceDescVC alloc]initWithSelectedService:[spaServiceArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:spaServiceDescVC animated:YES];
    [spaServiceDescVC release];
}
 
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{       
    //set the selected spaservice//or set tag as the indexpath.row
    selectButton.tag = indexPath.row;
    selectButton.enabled = YES;
}

-(void)AddSelectButtonWithTag:(int)rowinfo
{
    // add booking button note new y is already calculated
	selectButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, actionButtonYcord, actionButtonWidth, actionButtonHeight)];
	[selectButton setBackgroundColor:[UIColor clearColor]];	
    selectButton.tag = rowinfo;
     
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Select_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Select_button];
	
	[selectButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[selectButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    //
    [selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    [selectButton release];
    
}

-(void)selectAction:(id)sender     //post notification
{
    UIButton *tempButton = (UIButton *)sender;
    NSLog(@"ttempButton tag = %d",tempButton.tag);
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"spaServiceSelected" object:[spaServiceArray objectAtIndex:tempButton.tag]];    //send the object as notification obj
   
    if (appDelegate.bookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.bookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }
    
    
}

#pragma mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
}
@end
