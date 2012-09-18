//
//  RSGolfCourse.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfCourses.h"


@implementation RSGolfCourse

@synthesize courseId;
@synthesize	courseName; 
@synthesize locationId;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
	}
	
    return self;
}


-(void) dealloc
{	
	[courseId release];
	[courseName release]; 
	[locationId release];
	
	[super dealloc];
}
-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"COURSE NAME = %@",self.courseName];
    return desc;
}
@end



@implementation RSGolfCourses

@synthesize golfCoursesResult;
@synthesize	golfCources;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
		golfCources = [[NSMutableArray	alloc] init];
	}
	
    return self;
}


-(void) dealloc
{	
	[golfCoursesResult release];
	
	[golfCources removeAllObjects];
	[golfCources release];
	
	[super dealloc];
}

@end
