//
//  URLCaching.h
//  ResortSuite
//
//  Created by Cybage on 05/08/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLCaching : NSObject {
	NSString *documentsDirectory;
	NSString *cacheFileUrl;
	NSMutableDictionary *dictCache;
}

@property (nonatomic, retain) NSString *documentsDirectory;
@property (nonatomic, retain) NSDictionary *dictCache;


/*!
 @method		instance
 @brief			Singleton instance of URLCaching class
 @details		....
 @param			nil
 @return		URLCaching class object
 */
+ (URLCaching *) instance;

/*!
 @method		isRemoteFileCached
 @brief			Checking whether the file with url is already exists in dictionary 
 @details		Returns YES if file already cached else returns NO
 @param			NSString url
 @return		BOOL
 */
- (BOOL) isRemoteFileCached:(NSString*)url;


/*!
 @method		getCachedRemoteFile
 @brief			Returns the file name from the Cache 
 @details		....
 @param			NSString url
 @return		NSString
 */
- (NSString *) getCachedRemoteFile:(NSString*)url;

/*!
 @method		addRemoteFileToCache
 @brief			Add the cached file to the dictionary
 @details		....
 @param			NSString url, NSString content
 @return		BOOL
 */
- (BOOL) addRemoteFileToCache:(NSString*)url withString:(NSString *)content;

@end