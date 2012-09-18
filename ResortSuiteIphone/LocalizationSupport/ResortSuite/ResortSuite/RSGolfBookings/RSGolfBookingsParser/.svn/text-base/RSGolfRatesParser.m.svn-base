//
//  RSGolfRatesParser.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfRatesParser.h"
#import "RSGolfRates.h"

@implementation RSGolfRatesParser

@synthesize isError;
@synthesize errorResult;	
@synthesize golfRatesModel;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfRatesParser = [[NSXMLParser alloc] initWithData:data];
	golfRatesParser.delegate = self;
	[golfRatesParser parse];
	[golfRatesParser release];
}

-(void) dealloc
{
	[errorResult release];
	[golfRatesModel release];
	
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.

	if ([elementName isEqualToString:@"g:FetchGolfRatesResponse"]) {
		isError	= NO;
		if (self.golfRatesModel) {
			//[self.golfRatesModel release];
			self.golfRatesModel = nil;
		}
		golfRatesModel = [[RSGolfRates alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfRatesModel.golfRatesResult) {
				//[self.golfRatesModel.golfRatesResult release];	
                
				self.golfRatesModel.golfRatesResult = nil;
			}
            Result *golfRateResultObj = [[Result alloc] init];
			golfRatesModel.golfRatesResult = golfRateResultObj;
            [golfRateResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfRatesModel.golfRatesResult.resultValue= SUCCESS;
			}
			else {
				self.golfRatesModel.golfRatesResult.resultValue = FAIL;
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
	if ([elementName isEqualToString:@"g:FetchGolfRatesResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.golfRatesModel.golfRatesResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	else if ([elementName isEqualToString:@"Price"]) {
		self.golfRatesModel.price = value;
	}
	else if ([elementName isEqualToString:@"ItemName"]) {
		self.golfRatesModel.itemName = value;
	}
	else if ([elementName isEqualToString:@"ItemId"]) {
		self.golfRatesModel.itemId = value;
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
		[self.delegate parsingComplete:self.golfRatesModel];
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