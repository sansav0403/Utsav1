//
//  RSResetPasswordParser.m
//  ResortSuite
//
//  Created by Cybage on 1/9/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSResetPasswordParser.h"

@implementation RSResetPasswordParser
@synthesize isError;
@synthesize resetPasswordResult;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *changePasswordParser = [[NSXMLParser alloc] initWithData:data];
	changePasswordParser.delegate = self;
	[changePasswordParser parse];
	[changePasswordParser release];
}

-(void) dealloc
{
	[resetPasswordResult release];		
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
    //Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"rsapp:ChangePasswordCustomerResponse"]) {
        isError	= NO;
		return;
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
        
        if (self.resetPasswordResult) {
            //[self.golfBookingResult release];					
            self.resetPasswordResult = nil;
        }
        resetPasswordResult = [[Result alloc] init];
        
        if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
            self.resetPasswordResult.resultValue= SUCCESS;
            isError	= NO;
        }
        else if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]){
            self.resetPasswordResult.resultValue = FAIL;
            //self.changePasswordResult.ErrorID = 
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
	if ([elementName isEqualToString:@"rsapp:ChangePasswordCustomerResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		self.resetPasswordResult.resultText = value;	
	}	
	else if ([elementName isEqualToString:@"ErrorId"]) {
		self.resetPasswordResult.ErrorID = [value intValue];
	}
	
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
    if (isError)
    {
        [self.delegate parsingComplete:self.resetPasswordResult];
    }
    else
    {
        [self.delegate parsingComplete:self];
    }
}

@end
