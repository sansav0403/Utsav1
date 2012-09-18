//
//  RSMyAccountParser.h
//  ResortSuite
//
//  Created by Cybage on 06/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSParseBase.h"
#import "RSClubAccounts.h"

@interface RSMyAccountParser : RSParseBase <NSXMLParserDelegate> {

	NSMutableString *value;
	
	RSClubAccounts *clubAccounts;
	Account *account;				
				
	BOOL isError;
	Result *errorResult;
	
	BOOL isCustomer;
	BOOL isMember;
	BOOL isMembership;
	
	Member *member;
	MemberShip *memberShip;
}

@property (nonatomic, retain) RSClubAccounts *clubAccounts;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;

@end
