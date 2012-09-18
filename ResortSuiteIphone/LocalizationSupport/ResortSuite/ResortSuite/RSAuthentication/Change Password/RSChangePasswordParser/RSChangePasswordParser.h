//
//  RSChangePasswordParser.h
//  ResortSuite
//
//  Created by Cybage on 1/9/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSChangePasswordParser : RSParseBase <NSXMLParserDelegate> {

    BOOL isError;
	Result *changePasswordResult;
	
	NSMutableString *value;
}
@property(nonatomic) BOOL isError;
@property (nonatomic, retain) Result *changePasswordResult;

@end
