//
//  RSSpaServiceParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSSpaService.h"
#import "RSFolio.h"
@interface RSSpaServiceParser : RSParseBase <NSXMLParserDelegate>
{
    NSMutableString *value;
    
    RSSpaService *spaService;
    
  
    
    Result *result;
    
    RSSpaServices *rsSpaServices;
}

@property(nonatomic, retain) RSSpaServices *rsSpaServices;


@end

