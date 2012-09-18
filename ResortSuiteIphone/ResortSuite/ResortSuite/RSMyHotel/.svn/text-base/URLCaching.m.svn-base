//
//  URLCaching.m
//  ResortSuite
//
//  Created by Cybage on 05/08/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "URLCaching.h"

#define kDefaultCacheFile @"UrlCache.plist"


@interface URLCaching (private)

- (NSString*) makeKeyFromUrl:(NSString*)url;

@end		//private URLCaching interface


static URLCaching *sharedInstance = nil;

@implementation URLCaching

@synthesize documentsDirectory;
@synthesize dictCache;

- (id)init
{
	if ( (self = [super init]) )
	{		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		
		self.documentsDirectory = [paths objectAtIndex:0];
		
		// the path to the cache map
		cacheFileUrl = [self.documentsDirectory stringByAppendingPathComponent:kDefaultCacheFile];
		[cacheFileUrl retain];
		
		dictCache = [[NSDictionary alloc] initWithContentsOfFile:cacheFileUrl];
		
		if ( dictCache == nil )
		{
			dictCache = [[NSMutableDictionary alloc] init];
		}
	}	
	return self;
}

- (void)dealloc
{
	[documentsDirectory release];
	
	[cacheFileUrl release];
	[dictCache release];
	[super dealloc];
}

////////////////////////////////////////////////////////////////////////////////

+ (URLCaching *) instance
{
	@synchronized(self)
	{
		if ( sharedInstance == nil )
		{
			sharedInstance = [[URLCaching alloc] init];
		}
	}
	return sharedInstance;
}
////////////////////////////////////////////////////////////////////////////////
#pragma mark File searching, getting file from cache and adding new file to cache

- (BOOL) isRemoteFileCached:(NSString*)url
{
	NSString *fileName = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	
	return (fileName != nil);
}

- (NSString *) getCachedRemoteFile:(NSString*)url
{
	NSString *fileName = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	NSString *fileContent = nil;
	
	if ( fileName != nil )
	{
		fileContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:nil];
	}
	
	return fileContent;
}

- (BOOL) addRemoteFileToCache:(NSString*)url withString:(NSString *)content
{
	BOOL result = NO;
	NSString *fileName = [url lastPathComponent];
	
	if ( fileName != nil )
	{
		// the path to the cached file
		NSString *cachedFileUrl = [self.documentsDirectory stringByAppendingPathComponent:[fileName stringByAppendingString:@".html"]];
		result = [content writeToFile:cachedFileUrl atomically:YES encoding:NSUTF8StringEncoding error:nil];
		
		if ( result == YES )
		{
			// add the cached file to the dictionary
			[dictCache setValue:cachedFileUrl forKey:[self makeKeyFromUrl:url]];
			[dictCache writeToFile:cacheFileUrl atomically:YES];
		}
	}
	
	return result;
}


#pragma mark -
#pragma mark Private Methods

- (NSString*) makeKeyFromUrl:(NSString*)url
{
	NSString *key = [url stringByReplacingOccurrencesOfString:@"/" withString:@"."];
	
	key = [key stringByReplacingOccurrencesOfString:@":" withString:@"."];
	return key;
}


@end