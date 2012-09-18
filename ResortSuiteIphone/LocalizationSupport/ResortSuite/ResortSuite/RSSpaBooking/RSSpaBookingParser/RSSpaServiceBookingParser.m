//
//  RSSpaServiceBookingParser.m
//  ResortSuite
//
//  Created by Cybage on 17/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaServiceBookingParser.h"


@implementation RSSpaServiceBookingParser
@synthesize serviceBooking;
- (id) init
{
    self = [super init];
    if (self) {
        
        serviceBooking = nil;   
        result = [[Result alloc]init];
		
    }
	
    return self;
}

- (void) parse:(NSData*)data
{
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
}


-(void)dealloc
{  
    [serviceBooking release];
    [result release];
    [super dealloc];
    
}

#pragma mark parser Delegate Method

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict
{
	
    if ([elementName isEqualToString:@"Result"])
    {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"])
        {
            result.resultValue = FAIL;
        }
        else
        {
            result.resultValue = SUCCESS;
            serviceBooking = [[RSSpaServiceBooking alloc]init];
            serviceBooking.serviceBookingResult.resultValue = SUCCESS;
        }
    }
	else
	{
        value = [[NSMutableString alloc]init];
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   	if(value && string && [string length]>0)
	{
		[value appendString:string];
	} 
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"Text"])   
    {
        result.resultText = value;
        serviceBooking.serviceBookingResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"SpaFolioId"]) 
    {
        serviceBooking.spaFolioId = value;
    }    
    else if ([elementName isEqualToString:@"SpaFolioItemId"]) 
    {
        serviceBooking.spaFolioItemId = value;
    }
    else if ([elementName isEqualToString:@"ErrorId"]) {
		result.ErrorID = [value intValue];
	}
    [value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL)
    {
        [self.delegate parsingComplete:result];
    }
    else
    {
        [self.delegate parsingComplete:serviceBooking];
    }
    
}

@end
