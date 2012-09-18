//
//  RSGolfTeeTimesParser.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfTeeTimesParser.h"
#import "RSGolfTeeTimes.h"


@implementation RSGolfTeeTimesParser

@synthesize isError;
@synthesize errorResult;	
@synthesize golfTeeTimeModel;
@synthesize golfTeeTime;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfTeeTimeParser = [[NSXMLParser alloc] initWithData:data];
	golfTeeTimeParser.delegate = self;
	[golfTeeTimeParser parse];
	[golfTeeTimeParser release];
}

-(void) dealloc
{
	[errorResult release];
	[golfTeeTimeModel release];
	
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
			
	if ([elementName isEqualToString:@"g:FetchGolfTeeTimesResponse"]) {
		isError	= NO;
		if (self.golfTeeTimeModel) {
			//[self.golfTeeTimeModel release];
			self.golfTeeTimeModel = nil;
		}
		golfTeeTimeModel = [[RSGolfTeeTimes alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfTeeTimeModel.golfTeeTimeResult) {
				//[self.golfTeeTimeModel.golfTeeTimeResult release];					
                self.golfTeeTimeModel.golfTeeTimeResult = nil;
			}
            Result *golfTeeTimeResult = [[Result alloc] init];
			golfTeeTimeModel.golfTeeTimeResult = golfTeeTimeResult;
            [golfTeeTimeResult release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfTeeTimeModel.golfTeeTimeResult.resultValue= SUCCESS;
			}
			else {
				self.golfTeeTimeModel.golfTeeTimeResult.resultValue = FAIL;
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
	else if ([elementName isEqualToString:@"TeeTime"]) {
//		if (self.golfTeeTime) {
//			[self.golfTeeTime release];
//		}
		golfTeeTime = [[RSGolfTeeTime alloc] init];
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
			self.golfTeeTimeModel.golfTeeTimeResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	//----------------------------------------------------------
	else if ([elementName isEqualToString:@"TeeTime"]) {
		[self.golfTeeTimeModel.golfTeeTimes addObject:golfTeeTime];
        
		[golfTeeTime release];
		golfTeeTime = nil;
		return;
	}
	else if ([elementName isEqualToString:@"DateTime"]) {
		self.golfTeeTime.dateTime = value;
	}
	else if ([elementName isEqualToString:@"SlotsAvailable"]) {
		self.golfTeeTime.slotsAvailable = value;
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
		[self.delegate parsingComplete:self.golfTeeTimeModel];
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