//
//  RSGolfTeeTimesParser.h
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>


@class RSGolfTeeTime;
@class RSGolfTeeTimes;

@interface RSGolfTeeTimesParser : RSParseBase <NSXMLParserDelegate> {
	RSGolfTeeTimes *golfTeeTimeModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfTeeTime *golfTeeTime;
}


@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfTeeTimes *golfTeeTimeModel;

@property (nonatomic, retain) RSGolfTeeTime *golfTeeTime;

@end
