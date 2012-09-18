//
//  CSMapAnnotation.m
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "CSMapAnnotation.h"


@implementation CSMapAnnotation

@synthesize coordinate;
@synthesize _annotationType;
@synthesize _title;
@synthesize _userData;
@synthesize _url;

-(id) initWithCoordinate:(CLLocationCoordinate2D)Coordinate 
		  annotationType:(CSMapAnnotationType) annotationType
				   title:(NSString*)title
{
	self = [super init];
    if (self) {
        coordinate = Coordinate;
        self._title      = title;
        self._annotationType = annotationType;
    }
return self;
}

- (NSString *)title
{
	return _title;
}

- (NSString *)subtitle
{
	NSString* subtitle = nil;

	return subtitle;
}

-(void) dealloc
{
	[_title    release];
	[_userData release];
	[_url      release];
	
	[super dealloc];
}

@end
