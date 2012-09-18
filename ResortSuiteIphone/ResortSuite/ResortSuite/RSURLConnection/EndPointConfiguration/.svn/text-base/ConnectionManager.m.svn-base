//
//  ConnectionManager.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

@synthesize delegate;

-(id)init
{
    self = [super init];
    if (self) {
        _connection = nil;  //initialize with nil, incase stop connection is called without initializing connection object
        _webData = nil;
        return self;
    }
    return nil;
}
-(void)startConnectionWithUrl:(NSString *)urlString
{
    [self stopConnection]; //stop any connection activity currently going on

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _connection = [[NSURLConnection alloc]initWithRequest:req delegate:self startImmediately:YES];
    if (_connection) {
        _webData = [[NSMutableData data]retain];
    }
}

-(void)startConnectionWithRequest:(NSURLRequest *)request
{
    [self stopConnection]; //stop any connection activity currently going on
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    if (_connection) {
        _webData = [[NSMutableData data]retain];
    }
}


-(void)stopConnection
{
    if (_connection) {
        [_connection cancel];
        [_connection release];
        _connection = nil;
    }
    if (_webData) {
        [_webData release];
        _webData = nil;
    }
    
}
#pragma mark - NSUrlConnection delegate method

- (void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
}

- (void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    [self stopConnection];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"configuration file recieved");
    NSString *_configXML = [[NSString alloc]initWithBytes:[_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"configuration file data = %@",_configXML);
    if (delegate) {
        [self.delegate configFileRecieved:_webData];  //send the config file to endpoint configuration
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible  = NO;
    [self stopConnection];
    [_configXML release];
}
#pragma mark Deal with self-signed certificates

//Sent to determine whether the delegate is able to respond to a protection space’s form of authentication.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

//Sent when a connection must authenticate a challenge in order to download its request.
/*called when the connetion recieves a challenge from the server*/
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
