//
//  RSSpaBookingParser.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaLocationParser.h"
#import "RSSpaLocation.h"


@implementation RSSpaLocationParser

@synthesize rsSpaLocations;
- (id) init
{
    self = [super init];
    if (self) {

        rsSpaLocations = nil;   
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
    
    [rsSpaLocations release];
    [result release];
    [super dealloc];

}
#pragma mark parser Delegate Method

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict

{
   
    //to check the fail success condition
    if ([elementName isEqualToString:@"Result"])
    {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"])
        {
            result.resultValue = FAIL;
        }
        else
        {
            result.resultValue = SUCCESS;
            rsSpaLocations = [[RSSpaLocations alloc]init];
            rsSpaLocations.spaLocationResult.resultValue = SUCCESS;
        }
    }
    else if ([elementName isEqualToString:@"SpaLocation"])
    {
        spaLocation = [[RSSpaLocation alloc]init];
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
        rsSpaLocations.spaLocationResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"SpaLocation"])
    {
        
        [rsSpaLocations.spaLocations addObject:spaLocation];
       
        [spaLocation release];
        spaLocation = nil;
    }
    else if ([elementName isEqualToString:@"LocationName"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.locationName = teststring;
        [teststring release];
    }

    else if ([elementName isEqualToString:@"LocationId"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.locationID = [teststring intValue];
        [teststring release];
    }
    //
    else if ([elementName isEqualToString:@"Address"])
    {
        RSLocation *currentSpaLocation = [[RSLocation alloc]init];
        spaLocation.location = currentSpaLocation;
        [currentSpaLocation release];
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.address = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"City"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.city = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"StateProv"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.stateProv = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"Country"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.country = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"PostalCode"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.postalCode = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"Phone"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.phone = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"Fax"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.fax = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"Email"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.emailAddress = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"WebAddress"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.location.webAddress = teststring ;
        [teststring release];
    }
    else if ([elementName isEqualToString:@"ImageURL"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaLocation.imageUrl = teststring ;
        [teststring release];
    }
    //
    else if ([elementName isEqualToString:@"AllowGender"])
    {
        if ([value isEqualToString:@"Y"]) {
            spaLocation.allowGender = YES;
        }
        else
        {
            spaLocation.allowGender = NO;
        }
        
       
    }
    
    else if ([elementName isEqualToString:@"AllowStaff"])
    {
        if ([value isEqualToString:@"Y"]) {
            spaLocation.allowStaff = YES;
        }
        else
        {
            spaLocation.allowStaff = NO;
        }
    }
    
    else if ([elementName isEqualToString:@"AllowOverbook"])
    {
        if ([value isEqualToString:@"Y"]) {
            spaLocation.allowOverBook = YES;
        }
        else
        {
            spaLocation.allowOverBook = NO;
        }
    }
     //bookingType   
    else if ([elementName isEqualToString:@"BookingType"])
    {
        spaLocation.bookingType = value;
    }
    
    else if ([elementName isEqualToString:@"MondayStart"])
    {
       
        spaLocation.mondayStart = [self timeStringFromResponsedDateString:value];
    }

    else if ([elementName isEqualToString:@"MondayEnd"])
    {
       
        spaLocation.mondayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"TuesdayStart"])
    {
        
        spaLocation.tuesdayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"TuesdayEnd"])
    {
        
        spaLocation.tuesdayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"WednesdayStart"])
    {
       
        spaLocation.wednesdayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"WednesdayEnd"])
    {
       
        spaLocation.wednesdayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"ThursdayStart"])
    {
       
        spaLocation.thrusdayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"ThursdayEnd"])
    {
        
        spaLocation.thrusdayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"FridayStart"])
    {
        
        spaLocation.fridayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"FridayEnd"])
    {
        
        spaLocation.fridayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"SaturdayStart"])
    {
       
        spaLocation.saturdayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"SaturdayEnd"])
    {
       
        spaLocation.saturdayEnd = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"SundayStart"])
    {
       
        spaLocation.sundayStart = [self timeStringFromResponsedDateString:value];
    }
    
    else if ([elementName isEqualToString:@"SundayEnd"])
    {
        
        spaLocation.sundayEnd = [self timeStringFromResponsedDateString:value];
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
    
        [self.delegate parsingComplete:rsSpaLocations];
    }
    
}

-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	if(flag)
	{
		[dateFormatter setDateFormat:@"HH:mm"];  
        [dateFormatter setTimeZone: [NSTimeZone timeZoneWithName:@""]]; //finalize it
	}
	else
	{
		[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];  
	}
    
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];  //autoreleased
	[dateFormatter release];
	
	return date;
}

- (NSString *)timeStringFromResponsedDateString:(NSString *)sreverRespondedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
    //convert server responded dateString into and NSDate object 
    [dateFormatter setDateFormat:kServerRespondedDateTimeFormat];		
	NSDate *convertedDate = [dateFormatter dateFromString:sreverRespondedString];
    
    //get time form date string
    [dateFormatter setDateFormat:khh_mm_aFormat];
    NSString *convertedString = [dateFormatter stringFromDate:convertedDate];
    
	return convertedString;
}

@end
