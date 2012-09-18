//
//  EndPointConfiguration.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EndPointConfiguration.h"
#import "EndPointConfigurationParser.h"

@implementation EndPointConfiguration
@synthesize mobileConfig;
@synthesize delegate;
-(void)dealloc
{
    
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
        return self;
    }
    return nil;
}

-(NSString *)getEndPOintUrlForVersion:(NSString *)version
{
    return self.mobileConfig.endPointUrl;
}

-(void)setWebConfiguration  //functiont o initiate the connection and parsing
{
    ConnectionManager *connection = [[ConnectionManager alloc]init];
    [connection setDelegate:self];
    [connection startConnectionWithUrl:EndPointConfigurationUrl];
}

#pragma mark - connectionManagerDelegate method
-(void)configFileRecieved:(NSData *)configFileData
{   
    //call the parser to parse the file.
    EndPointConfigurationParser *configFileParser = [[EndPointConfigurationParser alloc]init];
    configFileParser.delegate = self;
    [configFileParser parse:configFileData];
}

-(void)parsingComplete:(id)parserModelData
{
    self.mobileConfig  = (RSMobile *)parserModelData;   //retain the config object
    NSLog(@"rsmobile object parsed is \n%@",self.mobileConfig); 
    //once the parsing is done
    //check if the status is deprecated or not
    //we can directly set the endurl in the nsuser defaults
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (![self.mobileConfig.status isEqualToString:DeprecatedStatus]) {        
        [prefs setObject:self.mobileConfig.endPointUrl forKey:endPointUrlKey];
        [prefs setObject:self.mobileConfig.status forKey:configStatusKey];
        if (delegate) {
            [self.delegate endPointConfigurationDone];
        }
    }
    else
    {
        [prefs setObject:self.mobileConfig.status forKey:configStatusKey];
        
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:DeprecatedVersionAlertTitle message:DeprecatedVersionAlertMessage delegate:nil cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
    }

}
@end
