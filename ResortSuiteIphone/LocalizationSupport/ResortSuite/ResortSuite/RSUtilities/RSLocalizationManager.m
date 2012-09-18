//
//  RSLocalizationManager.m
//  ResortSuite
//
//  Created by Cybage on 9/5/12.
//  Copyright (c) 2012 Cybage. All rights reserved.
//

#import "RSLocalizationManager.h"
static RSLocalizationManager* sharedInstance=nil;

@implementation RSLocalizationManager

/**
 *  @method     :-    sharedInstance 
 *  @parameter  :-    nil
 *  @return     :-    LocalizationManager Object
 *  @description:-    This will create and return LocalizationManager Shared Instance
 */
+ (RSLocalizationManager *)sharedInstance
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [[RSLocalizationManager alloc]init];
        }
    }
    return sharedInstance;
}

/**
 *  @method     :-    localizedStringForKey 
 *  @parameter  :-    stringKey
 *  @return     :-    Localized string for language set into iphone setting
 *  @description:-    This return Localized string
 */
+ (NSString *)localizedStringForKey:(NSString *)stringKey
{
    return NSLocalizedString(stringKey, @"");     
}

@end
