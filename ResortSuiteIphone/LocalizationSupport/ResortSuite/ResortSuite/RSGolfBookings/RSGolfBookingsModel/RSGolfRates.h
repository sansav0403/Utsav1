//
//  RSGolfRates.h
//  ResortSuite
//
//  Created by Cybage on 09/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSGolfRates : NSObject {
	Result *golfRatesResult;
	NSString *price;
	NSString *itemName;
	NSString *itemId;
}

@property (nonatomic, retain) Result *golfRatesResult;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSString *itemId;

@end
