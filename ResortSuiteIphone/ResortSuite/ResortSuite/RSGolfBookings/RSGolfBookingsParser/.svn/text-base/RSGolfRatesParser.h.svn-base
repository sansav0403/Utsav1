//
//  RSGolfRatesParser.h
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSGolfRates;

@interface RSGolfRatesParser : RSParseBase <NSXMLParserDelegate> {
	RSGolfRates *golfRatesModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfRates *golfRatesModel;

@end
