//
//  RSSpaStaffParser.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RSSpaStaff.h"
#import "RSFolio.h"
@interface RSSpaStaffParser : RSParseBase <NSXMLParserDelegate>
{
    NSMutableString *value;
    
    RSSpaStaff *spaStaff;
    
    Result *result;
    
    RSSpaStaffs *rsSpaStaffs;
}

@property(nonatomic, retain)  RSSpaStaffs *rsSpaStaffs;


@end
