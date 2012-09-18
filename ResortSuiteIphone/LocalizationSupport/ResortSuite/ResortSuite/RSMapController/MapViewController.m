//
//  MapViewController.m
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "MapViewController.h"
#import "DirectionViewController.h"

#import "RSGolfLocationsParser.h"
#import "RSGolfLocations.h"
#import "RSSpaLocationParser.h"
#import "RSSpaLocation.h"
#import "ErrorPopup.h"
#import "SoapRequests.h"

@implementation MapViewController

@synthesize mapView;
@synthesize locationArray;

@synthesize webSpaLocations;
@synthesize webGolfLocations;
@synthesize golfLocationsParser;
@synthesize spaLocationsParser;
@synthesize InfoButtonPageName;
@synthesize InfoButtonPageTitle;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

- (void)dealloc {
    [mapView release];  //was missing
    [locationArray release];
    
    [webSpaLocations release];
    [webGolfLocations release];
    [golfLocationsParser release];
    
    [spaLocationsParser release];
    [InfoButtonPageName release];
    [InfoButtonPageTitle release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	//Set the mapType
	mapView.mapType=MKMapTypeStandard;
    [mapView setDelegate:self];
    self.title = MapView_title;
	[self showAddress];
	
	#if defined(HOTEL_VERSION)
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
									   initWithTitle:Map_infoBUtton_title 
									   style:UIBarButtonItemStyleBordered
									   target:self
									   action:@selector(directionButtonAction:)
									   ];
	[[self navigationItem] setRightBarButtonItem:settingsButton];
	[settingsButton release];
	#elif defined(CLUB_VERSION)
	#endif
}

#if defined(HOTEL_VERSION)
/*!
 @method		directionButtonAction
 @brief		    Redirect to the DirectionViewController/Directions page
*/
-(void)directionButtonAction : (id)sender
{

    DirectionViewController *mDirectionViewController = [[DirectionViewController alloc] initWithContent:self.InfoButtonPageName];
    [mDirectionViewController setTitle:[self InfoButtonPageTitle]];
	[self.navigationController pushViewController:mDirectionViewController animated:YES];
	
	[mDirectionViewController release];
	
}
#elif defined(CLUB_VERSION)
#endif

//Adds the annotation for the address specified
-(void) showAddress
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.1;
	span.longitudeDelta=0.1;

    /*
        All the location are set from the plist file.
        The first location mentioned in the plist file will be set in the centre.
     */
    
    DLog(@"location description = %@",locationArray);
    if ([locationArray count] > 0) {
        for (int i = 0; i < [locationArray count]; i++) {
            //if address is given load map with address cords,else use lat and logitude
            
            NSString *Address = [[locationArray objectAtIndex:i] valueForKey:@"Address"];
            
            NSString *title = [NSString stringWithString:[[locationArray objectAtIndex:i] valueForKey:@"LocTitle"]];
            if (!([Address isEqualToString:@""])) {
                //when not  empty string
                CLLocationCoordinate2D location = [self addressLocation:Address];
                CSMapAnnotation *addAnnotation2 = [[CSMapAnnotation alloc] initWithCoordinate:location
                                                              annotationType:CSMapAnnotationTypeEnd title:title];
                [mapView addAnnotation:addAnnotation2];
                [mapView selectAnnotation:addAnnotation2 animated:YES];
                [addAnnotation2 release];
                if (i == 0) {
                    region.span=span;
                    region.center=location;

                }
            }
            else    //load anotation using cords
            {
            CLLocationCoordinate2D cord ;
            cord.latitude = [[[locationArray objectAtIndex:i] valueForKey:@"Latitude"] floatValue];
            cord.longitude  = [[[locationArray objectAtIndex:i] valueForKey:@"Longitude"] floatValue];
            
            
            CSMapAnnotation *addAnnotation1 = [[CSMapAnnotation alloc] initWithCoordinate:cord
                                                                            annotationType:CSMapAnnotationTypeEnd title:title];
            [mapView addAnnotation:addAnnotation1];
            [mapView selectAnnotation:addAnnotation1 animated:YES];
            [addAnnotation1 release];
                if (i == 0) {
                    region.span=span;
                    region.center=cord;
                    
                }
            }
        }
    }
    [mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
}


// Gets the address and converts it to the coordinate
-(CLLocationCoordinate2D) addressLocation:(NSString *)mapAddress
{
	NSError *error;
	CLLocationCoordinate2D coord;
	NSString *urlString = GoogleMap_url;
    
    NSString *strAddress = [self encodeURL:mapAddress];
	
	urlString  = [NSString stringWithFormat:urlString, strAddress];
	
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] 
														encoding:NSASCIIStringEncoding error:&error];
	if (locationString && [locationString length] > 0) 
	{
		NSArray *listItems = [locationString componentsSeparatedByString:@","];
		
		double latitude = 0.0;
		double longitude = 0.0;	
		
		//Check for the success with code 200 and get the lattitude and longitude
		if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"])
		{
			latitude = [[listItems objectAtIndex:2] doubleValue];
			longitude = [[listItems objectAtIndex:3] doubleValue];
		}
		else
		{
			DLog(@"performLocationFinder Error");
		}
		coord.latitude = latitude;
		coord.longitude = longitude;
	}
	
	return coord;
}

// Gets the address string and returns the encoded URL
//caller should free returned string
-(NSString*) encodeURL:(NSString *) addressStr
{
	
	NSString* stringAfterEncode = (NSString*)CFURLCreateStringByAddingPercentEscapes
    (  NULL,
																					  
     (CFStringRef) addressStr,
																					  
     NULL,
																					  
     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																					  
     kCFStringEncodingUTF8 );

	return [stringAfterEncode autorelease];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}


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

#pragma mark - mapview delegate

- (void)mapView:(MKMapView *)mapView1 didAddAnnotationViews:(NSArray *)views
{
    //Here
    [mapView1 selectAnnotation:[[mapView1 annotations] lastObject] animated:YES];
}
@end
