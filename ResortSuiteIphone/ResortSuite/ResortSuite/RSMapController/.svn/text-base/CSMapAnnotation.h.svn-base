//
//  CSMapAnnotation.h
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

/////////////////////////////////////////////////////////////////////////
// This is a class which provide annotation views 
////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

// types of annotations for which we will provide annotation views. 
typedef enum {
	CSMapAnnotationTypeStart = 0,
	CSMapAnnotationTypeEnd   = 1,
	CSMapAnnotationTypeImage = 2
} CSMapAnnotationType;

@interface CSMapAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	CSMapAnnotationType    _annotationType;
	NSString*              _title;
	NSString*              _userData;
	NSURL*                 _url;
}

/*!
 @method		initWithCoordinate
 @brief		    Coordinate initialization	
 @details		Initializing the coordinate with type and title
 @param			coordinate, annotationType, title
 @return		id
 */
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate 
		  annotationType:(CSMapAnnotationType) annotationType
				   title:(NSString*)title;

@property CSMapAnnotationType _annotationType;
@property (nonatomic, copy) NSString* _title;
@property (nonatomic, copy) NSString* _userData;
@property (nonatomic, copy) NSURL* _url;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
