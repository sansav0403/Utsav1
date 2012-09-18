//
//  RSSpaStaffParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaStaffParser.h"


@implementation RSSpaStaffParser
@synthesize rsSpaStaffs;

- (id) init
{
    self = [super init];
    if (self) {
        rsSpaStaffs = nil;
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
    [rsSpaStaffs release];
    [super dealloc];
    
}

#pragma mark Parser delegateMethods

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
            rsSpaStaffs = [[RSSpaStaffs alloc]init];
            rsSpaStaffs.spaStaffResult.resultValue = SUCCESS;
        }
    }    
    else if ([elementName isEqualToString:@"SpaStaff"])
    {
        spaStaff = [[RSSpaStaff alloc]init];
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
        rsSpaStaffs.spaStaffResult.resultText = value;
    }
    
    else if ([elementName isEqualToString:@"SpaStaff"])
    {
        //add in the spalocation Array before release
        [rsSpaStaffs.spaStaffs addObject:spaStaff];
        [spaStaff release];
    }
    else if ([elementName isEqualToString:@"SpaStaffId"])
    {
        spaStaff.spaStaffID = [value intValue];
    }
    else if ([elementName isEqualToString:@"SpaStaffName"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaStaff.spaStaffName = teststring;
        [teststring release];
    }
    
    else if ([elementName isEqualToString:@"Gender"])
    {
        if ([value isEqualToString:@"F"]) {
            spaStaff.gender = SpaBookingStaffFemale;
        }
        else
        {
             spaStaff.gender = SpaBookingStaffMale;
        }
      
    }
    [value release];
	value = nil;	
}

//at the end of parsing call the delegate method
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaStaffs];
    }

}


@end
