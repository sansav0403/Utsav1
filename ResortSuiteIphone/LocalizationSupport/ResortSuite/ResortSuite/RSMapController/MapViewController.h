//
//  MapViewController.h
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CSMapAnnotation.h"
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSLocation.h"
@class RSGolfLocationsParser;
@class RSGolfLocations;

@class RSSpaLocations;
@class RSSpaLocationParser;
@interface MapViewController : UIViewController <MKMapViewDelegate>{

	IBOutlet MKMapView *mapView;
	CSMapAnnotation *addAnnotation;
    NSArray *locationArray;
    ResortSuiteAppDelegate *appDelegate;
    
	RSSpaLocations *webSpaLocations;
    RSGolfLocations *webGolfLocations;
	RSGolfLocationsParser *golfLocationsParser;	
	RSSpaLocationParser *spaLocationsParser;
    
    NSString *InfoButtonPageName;       //to display the static html page with static content.
    NSString *InfoButtonPageTitle;      //to display the custom tite on the info page
}
@property (nonatomic,retain) RSGolfLocations *webGolfLocations;
@property (nonatomic,retain) RSSpaLocations *webSpaLocations;
@property (nonatomic,retain) RSGolfLocationsParser *golfLocationsParser;
@property (nonatomic,retain) RSSpaLocationParser *spaLocationsParser;

@property (nonatomic,retain) NSArray *locationArray;
@property (nonatomic,retain) IBOutlet MKMapView *mapView;
@property (nonatomic,copy) NSString *InfoButtonPageName;
@property (nonatomic,copy) NSString *InfoButtonPageTitle;

/*!
 @method		showAddress
 @brief		    show the map as per mapAnnotation
 @details		-
 @param			-
 @return		void
 */
-(void) showAddress;

/*!
 @method		addressLocation
 @brief		    Gets the address and converts it to the coordinate
 @details		Gets the address in string and using Google API, converts it to coordinate
 @param			-
 @return		Obj of CLLocationCoordinate2D
 */
-(CLLocationCoordinate2D) addressLocation:(NSString *)mapAddress;

/*!
 @method		encodeURL
 @brief		    encode the url string from the input string parameter
 @details		-
 @param			(NSString *) addressStr
 @return		(NSString*)
 */
-(NSString*) encodeURL:(NSString *) addressStr;

@end
