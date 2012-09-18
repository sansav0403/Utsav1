//
//  EmailVerificationParser.h
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailVerificationParser : RSParseBase <NSXMLParserDelegate> {
    
    BOOL isError;
	Result *verificationResult;
	NSMutableString *value;
}
@property(nonatomic) BOOL isError;
@property (nonatomic, retain) Result *verificationResult;

@end
