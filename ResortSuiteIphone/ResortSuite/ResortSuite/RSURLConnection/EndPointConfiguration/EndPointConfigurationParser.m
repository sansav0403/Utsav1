//
//  EndPointConfigurationParser.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EndPointConfigurationParser.h"

@implementation EndPointConfigurationParser
-(void)dealloc
{
    [super dealloc];
}

- (void) parse:(NSData*)data
{
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
}
#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"Config"]) {
        
		return;
	}
    else if ([elementName isEqualToString:@"RSMobile"]) {
        
        
        if ([[attributeDict valueForKey:@"Version"]isEqualToString:AppVersion] ) {
            rsmobileConfiguration = [[RSMobile alloc]init]; //allocate memory to the rsmobile object
            rsmobileConfiguration.version= AppVersion;
            rsmobileConfiguration.status= [attributeDict valueForKey:@"Status"];
            
            value =[[NSMutableString alloc] init];  //alocate memory only when the version is matched
        }
    
    }
	

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(value && string && [string length]>0)
	{
		[value appendString:string];    //enters wen the value is allocated memory
	}
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{ 	
    if (value && [elementName isEqualToString:@"EndPoint"])
    {
        rsmobileConfiguration.endPointUrl = value;
        
    [value release];
    value = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (delegate) {
        [self.delegate parsingComplete:rsmobileConfiguration]; //send the rsmobile config obj that match the hardcoded version in the application. if for the app version status is depricated notify the user to updated to latest version.
    }
    [rsmobileConfiguration release];
    rsmobileConfiguration = nil;
}
@end
