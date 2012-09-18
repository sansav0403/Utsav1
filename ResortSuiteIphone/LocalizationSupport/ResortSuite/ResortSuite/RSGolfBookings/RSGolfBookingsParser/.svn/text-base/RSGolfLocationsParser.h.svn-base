//
//  RSGolfLocations.h
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSGolfLocations;
@class RSGolfLocation;

@interface RSGolfLocationsParser : RSParseBase <NSXMLParserDelegate> {
	RSGolfLocations *golfLocationsModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfLocation *golfLocation;
}


@property (nonatomic, retain) RSGolfLocations *golfLocationsModel;

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;

/*!
 @method		timeStringFromResponsedDateString
 @brief			get time from server responded date string
 @details		extract time from server responded date string
 @param			(NSString *)sreverRespondedString
 @return		NSString - time string (with am/pm)
 */
- (NSString *)timeStringFromResponsedDateString:(NSString *)sreverRespondedString;

@end
