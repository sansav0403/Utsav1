//
//  RSGolfCoursesParser.h
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSGolfCourses;
@class RSGolfCourse;

@interface RSGolfCoursesParser : RSParseBase <NSXMLParserDelegate> {
	RSGolfCourses *golfCoursesModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfCourse *golfCourse;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfCourses *golfCoursesModel;

@end
