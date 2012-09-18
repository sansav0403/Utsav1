//
//  RSGolfCourseBookingVC.m
//  ResortSuite
//
//  Created by Cybage on 10/4/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSGolfCourseBookingVC.h"
#import "RSBookingTableView.h"
#import "SoapRequests.h"
#import "ErrorPopup.h"
#import "SoapRequests.h"
#import "RSBookingTableViewCell.h"
#import "RSGolfCoursesParser.h"
#import "RSGolfCourses.h"

#import "RSGolfBookingFormVC.h"


@implementation RSGolfCourseBookingVC

@synthesize golfLocationID;
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

-(id)initWithGolflocationID:(int)locationID
{
    self =[super init];
    if (self) {
        self.golfLocationID = locationID;
        DLog(@"location id = %d",self.golfLocationID);
    }
    return self;
}
- (void)dealloc
{
    [TableDataArray release];
    [golfCourseArray release];
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

   	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:GolfCourse_ViewTilte fontSize:nil];
    
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    //create array to store all the Golf Courses
    golfCourseArray = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    TableDataArray = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    //callthe Golf course service
    
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:FetchGolfCoursesRequest>"
                             "<Source>IPHONE</Source>"
                             "<LocationId>%@</LocationId>"
                             "</rsap:FetchGolfCoursesRequest>",
                             [NSString stringWithFormat:@"%d",golfLocationID] //Locatiojn id from Spa Location service
                             ];
    
    [self fetchDataForRequestWithBody:requestBody];
    

    
    //Crete a table from custom table view
	if (mainTableView) {
		[mainTableView release];
	}
	mainTableView = [[RSBookingTableView alloc] init];
	mainTableView.delegate = self;
	mainTableView.dataSource = self;
	[self.view addSubview:mainTableView];
	[mainTableView release];
	
    [self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    if (self.navigationController.delegate == nil) {
		[self.navigationController setDelegate:self];
	}
    

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
//#pragma mark navigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:viewController];	
//}

#pragma mark Common method for creating soap request and make a connection with WS 
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	RSConnection *connection = [RSConnection sharedInstance];
	connection.delegate = self;
	
	[connection	postDataToServer:soapString];
}

#pragma mark RSConnection delegate
-(void)responseReceived:(NSMutableData *)dataFromWS
{
	NSString *responseString = [[NSString alloc] initWithData:dataFromWS encoding:NSUTF8StringEncoding];
    
    DLog(@"responseString: %@", responseString);
	
	//If Ws response is of type spaService
	if ([responseString rangeOfString:@"FetchGolfCoursesResponse"].length > 0)
    {
        golfCoursesParser = [[RSGolfCoursesParser alloc] init];
        golfCoursesParser.delegate = self;                
        [golfCoursesParser parse:dataFromWS];	
    }
    [responseString release];
	//If Ws response is of type SpaLocationsResponse
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if([appDelegate.activityIndicator.activity isAnimating])
    {
		[appDelegate.activityIndicator.activity stopAnimating];
		[appDelegate.activityIndicator.view removeFromSuperview];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        
	}	
	
	if ([parserModelData isKindOfClass:[Result class]])
    {
		//[self showErrorMessage:parserModelData];
        Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSGolfCourses class]])
    {
		//If the data received is of type RSSpaServices fill the service into array
        RSGolfCourses *golfCoursesModel = (RSGolfCourses *)parserModelData;
        
        
        [golfCourseArray removeAllObjects];
        [golfCourseArray addObjectsFromArray:golfCoursesModel.golfCources];
        
        [TableDataArray removeAllObjects];
        [TableDataArray addObjectsFromArray:golfCourseArray];
        
        [mainTableView reloadData];
        [golfCoursesParser release];
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	

    
}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	
	appDelegate.myItineraryParser.errorResult = (Result *) parserModelData;
	
	if (appDelegate.connectedToInternet) {
		NSString *errorMessage = [NSString stringWithFormat:@"%@", appDelegate.myItineraryParser.errorResult.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [TableDataArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
	RSBookingTableViewCell *cell = (RSBookingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RSBookingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
    DLog(@"table data array = %d",[TableDataArray count]);
	if (([TableDataArray count] == 1) &&([[TableDataArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])) {
        cell.textLabel.text = [TableDataArray objectAtIndex:indexPath.row]; //older crash
    }
    else
    {
    RSGolfCourse *golfCourse = (RSGolfCourse *)[TableDataArray objectAtIndex:indexPath.row];
	cell.textLabel.text = golfCourse.courseName;	
    }
	//Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
	
    //Set the accessory view
	[cell setAccessoryViewImage:YES];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
      
    RSGolfCourse *golfCourse = (RSGolfCourse *)[TableDataArray objectAtIndex:indexPath.row];
    RSGolfBookingFormVC *golfBookingForm = [[RSGolfBookingFormVC alloc]initWithCourseId:golfCourse.courseId];

    [self.navigationController pushViewController:golfBookingForm animated:YES];
    [golfBookingForm release];
}
@end
