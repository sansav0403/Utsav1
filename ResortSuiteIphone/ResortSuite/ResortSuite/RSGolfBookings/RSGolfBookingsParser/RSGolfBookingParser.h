//
//  RSGolfBookingParser.h
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSGolfBookingParser : RSParseBase <NSXMLParserDelegate> {
    
    BOOL isError;
	Result *golfBookingResult;
	NSString *golfBookingId;
	
	NSMutableString *value;
}
@property(nonatomic) BOOL isError;
@property (nonatomic, retain) Result *golfBookingResult;
@property (nonatomic, retain) NSString *golfBookingId;

@end