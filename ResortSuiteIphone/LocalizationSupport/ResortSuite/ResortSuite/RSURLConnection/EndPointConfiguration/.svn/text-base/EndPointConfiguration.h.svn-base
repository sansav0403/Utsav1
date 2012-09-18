//
//  EndPointConfiguration.h
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionManager.h"
#import "RSParseBase.h"
#import "RSMobile.h"
//create a delegate method to inform the appdelegate object that endpointconfiguration is done and remove the splash screen
@protocol endPointConfigurationDelegate <NSObject>

-(void)endPointConfigurationDone;

@end
@interface EndPointConfiguration : NSObject<ConnectionManagerDelegate,RSParserHandlerDelegate>
{
    id<endPointConfigurationDelegate>       delegate;
    RSMobile *mobileConfig;
}

@property (nonatomic, retain) RSMobile *mobileConfig;
@property (nonatomic, assign) id<endPointConfigurationDelegate>     delegate;
-(void)setWebConfiguration;

@end
