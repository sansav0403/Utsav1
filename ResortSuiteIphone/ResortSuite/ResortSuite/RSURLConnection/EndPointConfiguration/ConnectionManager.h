//
//  ConnectionManager.h
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionManagerDelegate <NSObject>

-(void)configFileRecieved:(NSData *)configFileData;            

@end

@interface ConnectionManager : NSObject
{
    id <ConnectionManagerDelegate>  delegate;
    NSMutableData                   *_webData;
    NSURLConnection                 *_connection;   
    
}

@property (nonatomic, assign) id <ConnectionManagerDelegate> delegate;
-(void)startConnectionWithUrl:(NSString *)urlString;
-(void)startConnectionWithRequest:(NSURLRequest *)request;
-(void)stopConnection;
@end
