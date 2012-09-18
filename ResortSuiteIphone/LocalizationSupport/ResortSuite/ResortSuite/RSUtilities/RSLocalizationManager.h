//
//  RSLocalizationManager.h
//  ResortSuite
//
//  Created by Cybage on 9/5/12.
//  Copyright (c) 2012 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLocalizationManager : NSObject

+ (RSLocalizationManager *)sharedInstance;
+ (NSString *)localizedStringForKey:(NSString *)stringKey;

@end
