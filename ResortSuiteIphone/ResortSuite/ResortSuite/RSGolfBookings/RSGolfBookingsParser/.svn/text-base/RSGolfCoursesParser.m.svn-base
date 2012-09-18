//
//  RSGolfCoursesParser.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfCoursesParser.h"
#import "RSGolfCourses.h"

@implementation RSGolfCoursesParser

@synthesize isError;
@synthesize errorResult;	
@synthesize golfCoursesModel;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfCoursesParser = [[NSXMLParser alloc] initWithData:data];
	golfCoursesParser.delegate = self;
	[golfCoursesParser parse];
	[golfCoursesParser release];
}

-(void) dealloc
{
	[errorResult release];
	[golfCoursesModel release];
	
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.

	if ([elementName isEqualToString:@"g:FetchGolfCoursesResponse"]) {
		isError	= NO;
		if (self.golfCoursesModel) {
			//[self.golfCoursesModel release];
			self.golfCoursesModel = nil;
		}
		golfCoursesModel = [[RSGolfCourses alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfCoursesModel.golfCoursesResult) {
				//[self.golfCoursesModel.golfCoursesResult release];
                
                self.golfCoursesModel.golfCoursesResult = nil;
			}
            Result *golfCourseResultObj = [[Result alloc] init];
			golfCoursesModel.golfCoursesResult = golfCourseResultObj;
            [golfCourseResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfCoursesModel.golfCoursesResult.resultValue= SUCCESS;
			}
			else {
				self.golfCoursesModel.golfCoursesResult.resultValue = FAIL;
			}
		}
		else {
			if (self.errorResult) {
				//[self.errorResult release];
				self.errorResult = nil;
			}
			errorResult = [[Result alloc] init];
			self.errorResult.resultValue = FAIL;
		}
	}	
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"GolfCourse"]) {
		golfCourse = [[RSGolfCourse	alloc] init];
	}
	//-----------------------------------------------------------
	else {
		value =[[NSMutableString alloc] init];
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(value && string && [string length]>0)
	{
		[value appendString:string];
	}
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{   
	if ([elementName isEqualToString:@"g:FetchGolfCoursesResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.golfCoursesModel.golfCoursesResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	//----------------------------------------------------------
	else if ([elementName isEqualToString:@"GolfCourse"]) {
		[self.golfCoursesModel.golfCources addObject:golfCourse];
		[golfCourse release];
		return;
	}
	else if ([elementName isEqualToString:@"CourseId"]) {
		golfCourse.courseId = value;
	}
	else if ([elementName isEqualToString:@"CourseName"]) {
		golfCourse.courseName = value;
	}
	else if ([elementName isEqualToString:@"LocationId"]) {
		golfCourse.locationId = value;
	}
		
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
	if (isError) {
		[self.delegate parsingComplete:self.errorResult];
	}
	else {
		[self.delegate parsingComplete:self.golfCoursesModel];
	}
}


#pragma mark Date conversions

-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if(flag)
	{
		[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy hh:mm a"];	
	}
	else
	{
		[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];  
	}
	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	
	return date;
}


@end