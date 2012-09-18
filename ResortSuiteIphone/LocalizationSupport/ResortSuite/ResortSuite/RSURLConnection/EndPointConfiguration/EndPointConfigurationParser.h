//
//  EndPointConfigurationParser.h
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSMobile.h"

@interface EndPointConfigurationParser : RSParseBase <NSXMLParserDelegate>
{
    RSMobile            *rsmobileConfiguration;    //create this object when the attribute 
    NSMutableString     *value;                     //value matchs the harcoded version in application.
}

@end
