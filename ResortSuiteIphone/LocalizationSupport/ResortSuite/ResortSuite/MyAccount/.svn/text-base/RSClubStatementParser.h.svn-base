//
//  RSClubStatementParser.h
//  ResortSuite
//
//  Created by Cybage on 08/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSParseBase.h"
#import "RSClubStatement.h"


@class FolioItem;

@interface RSClubStatementParser : RSParseBase <NSXMLParserDelegate> {

	RSClubStatement *clubStatement;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	FolioItem *folioItem;
	FolioPayment *folioPayment;
	PostingItem *postingItem;
	Item *item;
	
	BOOL isFolioItem;
	BOOL isFolioPayment;
	BOOL isItem;
}

@property (nonatomic, retain) RSClubStatement *clubStatement;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;

/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;


@end
