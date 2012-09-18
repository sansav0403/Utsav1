//
//  RSClubBillingHistoryParser.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSClubBillingHistoryParser.h"
#import "DateManager.h"

@implementation RSClubBillingHistoryParser


@synthesize clubBillingHistory;
@synthesize isError;
@synthesize errorResult;

- (void) parse:(NSData*)data
{
	NSXMLParser *myAccParser = [[NSXMLParser alloc] initWithData:data];
	myAccParser.delegate = self;
	[myAccParser parse];
	[myAccParser release];
}

-(void) dealloc
{
	[clubBillingHistory release];
	[errorResult release];
	
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	
	if ([elementName isEqualToString:@"FetchClubBillingHistoryResponse"] || 
		[elementName isEqualToString:@"n:FetchClubBillingHistoryResponse"]) {
		isError = YES;
	}
	if ([elementName isEqualToString:@"tns:FetchClubBillingHistoryResponse"]) {
		if (self.clubBillingHistory) {
			//[self.clubBillingHistory release];
            self.clubBillingHistory = nil;
		}
		clubBillingHistory = [[RSClubBillingHistory alloc] init];
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}	
		if (isError) {
			errorResult = [[Result alloc] init];
			self.errorResult.resultValue = FAIL;
		}
		else {
            Result *resultObj = [[Result alloc] init];
			self.clubBillingHistory.clubBillingResult = resultObj;
            [resultObj release];
			self.clubBillingHistory.clubBillingResult.resultValue = SUCCESS;
		}		
		return;
	}		
	else if ([elementName isEqualToString:@"BillingPeriod"]) {
		if (billingPeriod) {
			[billingPeriod release];
		}
		billingPeriod =[[BillingPeriod alloc] init];
		return;
	}	
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
	if ([elementName isEqualToString:@"tns:FetchClubBillingHistoryResponse"]) {	
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {		
		return;
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (isError) {
			self.errorResult.resultText = value;			
		}
		else {
			self.clubBillingHistory.clubBillingResult.resultText = value;
		}
	}	
	else if ([elementName isEqualToString:@"AccountId"]) {
		self.clubBillingHistory.accountId = value;
	}
	else if ([elementName isEqualToString:@"BillingPeriod"]) {
		
		[self.clubBillingHistory.billingPeriods addObject:billingPeriod];
		[billingPeriod release];
		billingPeriod = nil;
		return;
	}
	else if ([elementName isEqualToString:@"BillDate"]) {
		billingPeriod.billDate = [DateManager stringFromServerResponseString:value requiredFormat:MMMM_dd_yyyyFormat withTime:NO];
	}
	else if ([elementName isEqualToString:@"PeriodStartDate"]) {
		billingPeriod.periodStartDate  = [DateManager stringFromServerResponseString:value requiredFormat:MMMM_dd_yyyyFormat withTime:NO];
	}
	else if ([elementName isEqualToString:@"Frequency"]) {
		billingPeriod.frequency = value;
	}
	else if ([elementName isEqualToString:@"PaymentLeniency"]) {
		billingPeriod.paymentLeniency = value;
	}
	else if ([elementName isEqualToString:@"Balance"]) {
		billingPeriod.balance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"FolioDue"]) {
		billingPeriod.folioDue = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"Payment"]) {
		billingPeriod.payment = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"LateFeeApplied"]) {
		billingPeriod.lateFeeApplied = value;
	}
	else if ([elementName isEqualToString:@"LateFee"]) {
		billingPeriod.lateFee = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"BalanceDue"]) {
		billingPeriod.balanceDue = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}

	[value release];
	value = nil;	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //Here the delegate is the object of RSParserBase class.
	
	if (isError) {
		[self.delegate parsingComplete:self.errorResult];
	}
	else {
		[self.delegate parsingComplete:self.clubBillingHistory];
	}
}


@end
