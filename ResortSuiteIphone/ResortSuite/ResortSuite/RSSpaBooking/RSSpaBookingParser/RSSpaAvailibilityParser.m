//
//  RSSpaAvailibilityParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaAvailibilityParser.h"
#import "RSSpaAvailibility.h"

@implementation RSSpaAvailibilityParser

@synthesize rsSpaAvailibilties;

- (id) init
{
    self = [super init];
    if (self) {

        rsSpaAvailibilties = nil;
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
    [rsSpaAvailibilties release];
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
            rsSpaAvailibilties = [[RSSpaAvailibilties alloc]init];
            rsSpaAvailibilties.spaAvailibilityResult.resultValue = SUCCESS;
        }
    }

    else if ([elementName isEqualToString:@"SpaAvailability"])
    {
        spaAvailibility = [[RSSpaAvailibility alloc]init];
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
    }
    
    else if ([elementName isEqualToString:@"SpaAvailability"])
    {
        [rsSpaAvailibilties.spaAvailibilities addObject:spaAvailibility];
        
        [spaAvailibility release];

    }
    //----------------------
    else if ([elementName isEqualToString:@"StartTime"])
    {
        
        spaAvailibility.startTime = value;
    }
    
    else if ([elementName isEqualToString:@"AvailabilityId"])
    {
        spaAvailibility.availibilityID = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"SpaStaffId"])      
    {
        spaAvailibility.spaStaffID = [value intValue];
    }
    
}

//at the end of parsing call the delegate method
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaAvailibilties];
    }

}


-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if(flag)
	{
		[dateFormatter setDateFormat:@"yyyy-MM-ddHHmmss"];
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
