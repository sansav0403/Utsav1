//
//  RSSpaCustomerConflictBookingsParser.m
//  ResortSuite
//
//  Created by Cybage on 12/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaCustomerConflictBookingsParser.h"
#import "RSSpaCustomerConflictingBookings.h"


@implementation RSSpaCustomerConflictBookingsParser

@synthesize isError;
@synthesize errorResult;	
@synthesize spaCustConflictBookingsModel;


- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *spaCustConflictBookingsParser = [[NSXMLParser alloc] initWithData:data];
	spaCustConflictBookingsParser.delegate = self;
	[spaCustConflictBookingsParser parse];
	[spaCustConflictBookingsParser release];
}

-(void) dealloc
{
	[errorResult release];
	[spaCustConflictBookingsModel release];
	
	[super dealloc];
}


#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"s:FetchSpaCustomerConflictingBookingsResponse"]) {
		isError	= NO;
		if (self.spaCustConflictBookingsModel) {
			//[self.spaCustConflictBookingsModel release];
			self.spaCustConflictBookingsModel = nil;
		}
		spaCustConflictBookingsModel = [[RSSpaCustomerConflictingBookings alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.spaCustConflictBookingsModel.spaBookingResult) {
				//[self.spaCustConflictBookingsModel.spaBookingResult release];	
                self.spaCustConflictBookingsModel.spaBookingResult = nil;
			}
            Result * spaBookingResultObj = [[Result alloc] init];
			spaCustConflictBookingsModel.spaBookingResult = spaBookingResultObj;
            [spaBookingResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.spaCustConflictBookingsModel.spaBookingResult.resultValue= SUCCESS;
			}
			else {
				self.spaCustConflictBookingsModel.spaBookingResult.resultValue = FAIL;
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
	else if ([elementName isEqualToString:@"SpaBooking"]) {
		spaBooking = [[RSSpaBooking	alloc] init];
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
	if ([elementName isEqualToString:@"s:FetchSpaCustomerConflictingBookingsResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.spaCustConflictBookingsModel.spaBookingResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	//----------------------------------------------------------
	else if ([elementName isEqualToString:@"SpaBooking"]) {
		[self.spaCustConflictBookingsModel.spaBookings addObject:spaBooking];
		[spaBooking release];
		return;
	}
	else if ([elementName isEqualToString:@"ItemName"]) {
		spaBooking.itemName = value;
	}
	else if ([elementName isEqualToString:@"StartTime"]) {
		spaBooking.startTime = value;
	}
	else if ([elementName isEqualToString:@"EndTime"]) {
		spaBooking.endTime = value;
	}
	else if ([elementName isEqualToString:@"Location"]) {
		spaBooking.location = value;
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
		[self.delegate parsingComplete:self.spaCustConflictBookingsModel];
	}
}



@end
