//
//  RSClubStatementParser.m
//  ResortSuite
//
//  Created by Cybage on 08/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSClubStatementParser.h"

@implementation RSClubStatementParser

@synthesize clubStatement;
@synthesize isError;
@synthesize errorResult;


- (void) parse:(NSData*)data
{
	NSXMLParser *clubStmtParser = [[NSXMLParser alloc] initWithData:data];
	clubStmtParser.delegate = self;
	[clubStmtParser parse];
	[clubStmtParser release];
}

-(void) dealloc
{
	[clubStatement release];
	[errorResult release];
	
	[super dealloc];
}


#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	if ([elementName isEqualToString:@"FetchClubStatementResponse"] || 
		[elementName isEqualToString:@"n:FetchClubStatementResponse"]) {
		isError = YES;
	}
	if ([elementName isEqualToString:@"tns:FetchClubStatementResponse"]) {
		if (self.clubStatement) {
			//[self.clubStatement release];
            self.clubStatement = nil;
		}
		clubStatement = [[RSClubStatement alloc] init];
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}	
		if (isError) {
			if (self.errorResult) {
				//[self.errorResult release];
                self.errorResult = nil;
			}
			errorResult = [[Result alloc] init];
			errorResult.resultValue = FAIL;
		}
		else {
			if (self.clubStatement.clubStmtResult) {
				//[self.clubStatement.clubStmtResult release];
                self.clubStatement.clubStmtResult = nil;
			}
            Result *resultObj = [[Result alloc] init];
			clubStatement.clubStmtResult = resultObj;
            [resultObj release];
			self.clubStatement.clubStmtResult.resultValue = SUCCESS;
		}		
		return;
	}
	else if ([elementName isEqualToString:@"Account"]) {
		if (self.clubStatement.stmtAccount) {
			//[self.clubStatement.stmtAccount release];
            self.clubStatement.stmtAccount = nil;
		}
        StatementAccount *stmtAccountObj = [[StatementAccount alloc] init];
		clubStatement.stmtAccount = stmtAccountObj;
        [stmtAccountObj release];
		self.clubStatement.stmtAccount.stmtAccId = [attributeDict valueForKey:@"Id"];
		self.clubStatement.stmtAccount.stmtClass = [attributeDict valueForKey:@"Class"];
		self.clubStatement.stmtAccount.stmtCustName = [attributeDict valueForKey:@"StatementCustomerName"];
		return;
	}
	else if ([elementName isEqualToString:@"Customer"]) {
		if (self.clubStatement.stmtAccount.stmtAccCustomer) {
			//[self.clubStatement.stmtAccount.stmtAccCustomer release];
            self.clubStatement.stmtAccount.stmtAccCustomer = nil;
		}
        AccCustomer *accCustomerObj = [[AccCustomer alloc] init];
		clubStatement.stmtAccount.stmtAccCustomer = accCustomerObj;
        [accCustomerObj release];
		return;
	}	
	else if ([elementName isEqualToString:@"Address"]) {
        Address *addressObj = [[Address alloc] init];
		clubStatement.stmtAccount.stmtAccCustomer.address = addressObj;
        [addressObj release];
		return;
	}	
	else if ([elementName isEqualToString:@"BillingPeriod"]) {
		if (self.clubStatement.stmtAccount.stmtBillingPeriod) {
			//[self.clubStatement.stmtAccount.stmtBillingPeriod release];
            self.clubStatement.stmtAccount.stmtBillingPeriod = nil;
            
		}
        StmtBillingPeriod * stmtBillingPeriodObj = [[StmtBillingPeriod alloc] init];
		clubStatement.stmtAccount.stmtBillingPeriod = stmtBillingPeriodObj;
        [stmtBillingPeriodObj release];
		return;
	}
	else if ([elementName isEqualToString:@"FolioItem"]) {
		if (folioItem) {
			[folioItem release];
		}
		folioItem =[[FolioItem alloc] init];
		folioItem.ItemId = [[attributeDict valueForKey:@"Id"] intValue];
		isFolioItem = YES;		
		return;
	}	
	else if ([elementName isEqualToString:@"PostingItem"]) {		
		if (postingItem) {
			[postingItem release];
		}
		postingItem = [[PostingItem alloc] init];
		postingItem.ItemId = [[attributeDict valueForKey:@"Id"] intValue];
		isFolioItem = NO;
		return;
	}
	else if ([elementName isEqualToString:@"Item"]) {
		if (item) {
			[item release];
		}
		item = [[Item alloc] init];
		
		item.itemId = [[attributeDict valueForKey:@"Id"] intValue];
		item.itemApp = [attributeDict valueForKey:@"App"];
		item.itemFolioId = [[attributeDict valueForKey:@"FolioId"] intValue];
		
		isItem = YES;

		return;
	}
	else if ([elementName isEqualToString:@"FolioPayment"]) {
		if (folioPayment) {
			[folioPayment release];
		}
		folioPayment =[[FolioPayment alloc] init];
		folioPayment.ItemId = [[attributeDict valueForKey:@"Id"] intValue];
		isFolioPayment = YES;
		
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
			self.clubStatement.clubStmtResult.resultText = value;
		}
	}	
	
	//------------------- Customer -------------------------------
	
	else if ([elementName isEqualToString:@"CustomerId"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.customerId = value;
	}
	else if ([elementName isEqualToString:@"CustomerGUID"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.customerGUID = value;
	}
	else if ([elementName isEqualToString:@"Salutation"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.salutation = value;
	}
	else if ([elementName isEqualToString:@"FirstName"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.firstName = value;
	}
	else if ([elementName isEqualToString:@"LastName"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.lastName = value;
	}
	
	//------------------- Address -------------------------------
	
	else if ([elementName isEqualToString:@"AddressLine1"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.addressLine1 = value;
	}
	else if ([elementName isEqualToString:@"AddressLine2"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.addressLine2 = value;
	}
	else if ([elementName isEqualToString:@"City"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.city = value;
	}
	else if ([elementName isEqualToString:@"Province"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.province = value;
	}
	else if ([elementName isEqualToString:@"Country"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.country = value;
	}
	else if ([elementName isEqualToString:@"PostalCode"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.address.postalCode = value;
	}
	else if ([elementName isEqualToString:@"EmailAddress"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.emailAddress = value;
	}
	else if ([elementName isEqualToString:@"PhoneNumber"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.phoneNumber = value;
	}
	else if ([elementName isEqualToString:@"CustomerCode"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.customerCode = value;
	}
	else if ([elementName isEqualToString:@"VIPLevel"]) {
		self.clubStatement.stmtAccount.stmtAccCustomer.VIPLevel = value;
	}
	
	//------------------- Stmt BillingPeriod -------------------------------
	
	else if ([elementName isEqualToString:@"BillDate"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.billDate = value;
	}
	else if ([elementName isEqualToString:@"PeriodStartDate"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.periodStartDate = value;
	}
	else if ([elementName isEqualToString:@"PaymentDueDate"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.paymentDueDate = value;
	}
	else if ([elementName isEqualToString:@"PreviousBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.previousBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:Club_Payments]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.payments = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:Club_Charges]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.charges = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"AccountBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.accountBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"CurrentBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.currentBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"LateFee"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.lateFee = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"ThirtyDayBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.thirtyDayBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"SixtyDayBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.sixtyDayBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"NinetyDayBalance"]) {
		self.clubStatement.stmtAccount.stmtBillingPeriod.ninetyDayBalance = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	
	//------------------- FolioItem -------------------------------	
	else if ([elementName isEqualToString:@"FolioItem"]) {
		[self.clubStatement.stmtAccount.folioItems addObject:folioItem];
		[folioItem release];
		folioItem = nil;
		isFolioItem = NO;
		
		return;
	}
	else if ([elementName isEqualToString:@"Name"]) {
		if (isItem) {
			item.name = value;
		}
		else if (isFolioItem)
		{
			folioItem.name = value;
		}
	}
	else if ([elementName isEqualToString:@"Date"]) {
		if (isFolioItem)
		{
			folioItem.folioDate = value;
			folioItem.folioFormatedDate = [self stringToDate:value];
		}
		else if(isItem)
		{
			item.itemDate = value;
			item.itemFormatedDate = [self stringToDate:value]; 
		}
		else if(isFolioPayment)
		{
			folioPayment.folioDate = value;
			folioPayment.folioFormatedDate = [self stringToDate:value];
		}			
	}
	else if ([elementName isEqualToString:@"Price"]) {
		folioItem.price = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"Quantity"]) {
		folioItem.quantity = value;
	}
	else if ([elementName isEqualToString:@"Discount"]) {
		folioItem.discount = value;
	}
	else if ([elementName isEqualToString:@"ExtPrice"]) {
		folioItem.extPrice = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"TotalPrice"]) {
		folioItem.totalPrice = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"PostingItem"]) {
		[folioItem.postingItems addObject:postingItem];
		[postingItem release];
		postingItem = nil;
		isFolioItem = YES;
		
		return;
	}
	else if ([elementName isEqualToString:@"Item"]) {
		[postingItem.items addObject:item];
		[item release];
		item = nil;
		isItem = NO;

		return;
	}
	
	//------------------- FolioPayment -------------------------------
	
	else if ([elementName isEqualToString:@"FolioPayment"]) {
		[self.clubStatement.stmtAccount.folioPayments addObject:folioPayment];
		[folioPayment release];
		//folioPayment = nil;
		isFolioPayment = NO;
		
		return;		
	}
	else if ([elementName isEqualToString:@"Type"]) {
		folioPayment.type = value;
	}
	else if ([elementName isEqualToString:@"Label"]) {
		folioPayment.label = value;
	}
	else if ([elementName isEqualToString:@"Amount"]) {
		if (isItem) {
			item.amount = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
		}
		else if (isFolioPayment)
			folioPayment.amount = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
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
		[self.delegate parsingComplete:self.clubStatement];
	}
}

#pragma mark date Functions
-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateFormat:@"MMMM d, yyyy"];
	
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	return date;
}

@end
