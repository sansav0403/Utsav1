//
//  RSSpaServiceParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaServiceParser.h"


@implementation RSSpaServiceParser

@synthesize rsSpaServices;
- (id) init
{
    self = [super init];
    if (self) {

        rsSpaServices =nil;
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
    [rsSpaServices release];
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
            rsSpaServices = [[RSSpaServices alloc]init];
            rsSpaServices.spaServiceResult.resultValue = SUCCESS;
        }
    }    
    if ([elementName isEqualToString:@"SpaService"])
    {
        spaService = [[RSSpaService alloc]init];
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
        rsSpaServices.spaServiceResult.resultText = value;
    }
    
    else if ([elementName isEqualToString:@"SpaService"])
    {
        [rsSpaServices.spaServices addObject:spaService];
        [spaService release];
        spaService = nil;

    }
    //----------------------

    else if ([elementName isEqualToString:@"SpaItemId"])
    {

        spaService.spaItemID = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"Location"])
    {
       
        spaService.location = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"ItemName"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemName = temp;
        [temp release];
    }
    
    else if ([elementName isEqualToString:@"ItemDesc"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemDesc = temp;
        [temp release];
    }
    else if ([elementName isEqualToString:@"ClientInstructions"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.clientInstruction = temp;
        [temp release];
    }
    
    else if ([elementName isEqualToString:@"Price"])
    {
        spaService.price = [value floatValue];
    }
    
    else if ([elementName isEqualToString:@"ServiceTime"])      
    {
        spaService.serviceTime = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"SameGender"])
    {
        if ([value isEqualToString:@"Y"])
        {
            spaService.sameGender = YES;
        }
        else
        {
            spaService.sameGender = NO;
        }
    }
    else if ([elementName isEqualToString:@"ItemCategory"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemCategory = temp;
        [temp release];
    }
    else if ([elementName isEqualToString:@"ItemSubcategory"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemSubCategory = temp;
        [temp release];
    }
    [value release];
	value = nil;	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaServices];
    }

}


@end
