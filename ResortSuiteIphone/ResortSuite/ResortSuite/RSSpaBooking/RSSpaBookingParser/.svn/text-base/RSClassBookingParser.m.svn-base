//
//  RSClassBookingParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
#import "RSClassBookingParser.h"


@implementation RSClassBookingParser

@synthesize classBooking;

- (id) init
{
    self = [super init];
    if (self) {
        
        classBooking = nil;   
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
    
    [classBooking release];
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
            classBooking = [[RSClassBooking alloc]init];
            classBooking.classBookingResult.resultValue = SUCCESS;
        }
    }
    else if ([elementName isEqualToString:@"SpaFolioItem"]) 
    {
        
        spaFolioItemTemp = [[RSSpaFolioItem alloc]init];
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
        classBooking.classBookingResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"SpaFolioItem"]) 
    {
        classBooking.spaFolioItem = spaFolioItemTemp;
        [spaFolioItemTemp release];
        
    }
    
    else if ([elementName isEqualToString:@"SpaFolioItemId"]) 
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaFolioItemTemp.spaFolioItemId = [temp intValue];
        [temp release];
        
    
    }
    else if ([elementName isEqualToString:@"BookStartTime"]) 
    {
        NSDate *tempDate = [self stringToDate:value withTime:YES];
        spaFolioItemTemp.bookStartTime = tempDate;
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
        
        [self.delegate parsingComplete:classBooking];
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
    
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];  //autoreleased
	[dateFormatter release];
	
	return date;
}

@end
