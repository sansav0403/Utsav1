//
//  RSDailySpaClassesParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
#import "RSDailySpaClassesParser.h"


@implementation RSDailySpaClassesParser
@synthesize rsDailySpaClasses;

- (id) init
{
    self = [super init];
    if (self) {
        rsDailySpaClasses = nil;   
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
    [rsDailySpaClasses release];
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
            rsDailySpaClasses = [[RSDailySpaClasses alloc]init];
            rsDailySpaClasses.spaClassResult.resultValue = SUCCESS;
        }
    }
    
    
    else if ([elementName isEqualToString:@"SpaClass"])
    {
        spaClass = [[RSSpaClass alloc]init];
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
        rsDailySpaClasses.spaClassResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"Date"])
    {
       
        rsDailySpaClasses.date = value;
    
    }
    else if ([elementName isEqualToString:@"SpaClass"])
    {
        
        [rsDailySpaClasses.spaClasses addObject:spaClass];
        
        [spaClass release];
    }
    else if ([elementName isEqualToString:@"SpaClassId"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.spaClassId =  [teststring intValue];
        [teststring release];

    }
    else if ([elementName isEqualToString:@"SpaItemId"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.spaItemId =  [teststring intValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"SpaItemName"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.spaItemName =  teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"ItemDescription"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.itemDescription =  teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"ClientInstructions"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.clientInstruction =  teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"Price"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.price =  [teststring floatValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"SpaRoomId"])   
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.spaRoomId =  teststring;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"ServiceTime"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.serviceTime =  [teststring floatValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"StartTime"])
    {
       
        spaClass.startTime = value ;
    }
    else if ([elementName isEqualToString:@"EndTime"])
    {
        
        spaClass.endTime = value;
    }
    else if ([elementName isEqualToString:@"AvailSlots"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.availSlots =  [teststring intValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"SpaStaffId"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.spaStaffId =  [teststring intValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"IsProgramHeader"])
    {
        if ([value isEqualToString:@"Y"]) {
            spaClass.isProgramHeader = YES;
        }
        else
        {
            spaClass.isProgramHeader = NO;
        }
    }
    else if ([elementName isEqualToString:@"NumClasses"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.numClasses =  [teststring intValue];
        [teststring release];
    }
    else if ([elementName isEqualToString:@"TotalPrice"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.totalPrice =  [teststring floatValue];
        [teststring release];
    }
    //
    else if ([elementName isEqualToString:@"ItemCategory"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.itemCategory =  teststring;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"ItemSubcategory"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaClass.itemSubCategory =  teststring;
        [teststring release];
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
        
        [self.delegate parsingComplete:rsDailySpaClasses];
    }
    
}


#pragma string to date funtion
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
