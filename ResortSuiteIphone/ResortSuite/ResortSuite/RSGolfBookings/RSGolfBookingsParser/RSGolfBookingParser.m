//
//  RSGolfBookingParser.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfBookingParser.h"


@implementation RSGolfBookingParser

@synthesize golfBookingResult;
@synthesize golfBookingId;
@synthesize isError;
- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfBookingParser = [[NSXMLParser alloc] initWithData:data];
	golfBookingParser.delegate = self;
	[golfBookingParser parse];
	[golfBookingParser release];
}

-(void) dealloc
{
	[golfBookingResult release];
	[golfBookingId release];
	
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"g:CreateGolfBookingResponse"]) {
        isError	= NO;
		return;
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
	
			if (self.golfBookingResult) {
				//[self.golfBookingResult release];					
                self.golfBookingResult = nil;
			}
			golfBookingResult = [[Result alloc] init];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfBookingResult.resultValue= SUCCESS;
                isError	= NO;
			}
			else if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]){
				self.golfBookingResult.resultValue = FAIL;
                isError = YES;
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
	if ([elementName isEqualToString:@"g:CreateGolfBookingResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		self.golfBookingResult.resultText = value;	
	}	
	else if ([elementName isEqualToString:@"GolfBookingId"]) {
		self.golfBookingId = value;
	}
	
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
    if (isError)
    {
        [self.delegate parsingComplete:self.golfBookingResult];
    }
    else
    {
	[self.delegate parsingComplete:self];
    }
}

@end
