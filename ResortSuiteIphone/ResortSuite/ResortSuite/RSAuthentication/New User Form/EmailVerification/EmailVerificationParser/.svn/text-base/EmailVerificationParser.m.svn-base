//
//  EmailVerificationParser.m
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EmailVerificationParser.h"

@implementation EmailVerificationParser
@synthesize isError;
@synthesize verificationResult;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *createCustomerParser = [[NSXMLParser alloc] initWithData:data];
	createCustomerParser.delegate = self;
	[createCustomerParser parse];
	[createCustomerParser release];
}

-(void) dealloc
{
	[verificationResult release];		
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
    //Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"rsapp:CheckCustomerEmailResponse"]) {
        isError	= NO;
		return;
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
        
        if (self.verificationResult) {
            self.verificationResult = nil;
        }
        verificationResult = [[Result alloc] init];
        
        if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
            self.verificationResult.resultValue= SUCCESS;
            isError	= NO;
        }
        else if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]){
            self.verificationResult.resultValue = FAIL;
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
	if ([elementName isEqualToString:@"rsapp:CheckCustomerEmailResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		self.verificationResult.resultText = value;	
	}	
	else if ([elementName isEqualToString:@"ErrorId"]) {
		self.verificationResult.ErrorID = [value intValue];
	}  
	
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
    if (isError)
    {
        [self.delegate parsingComplete:self.verificationResult];
    }
    else
    {
        [self.delegate parsingComplete:self];
    }
}



@end
