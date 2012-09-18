//
//  SoapRequests.h
//  ResortSuite
//
//  Created by Cybage on 22/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SoapRequests : NSObject {

}

/*
 @method		createSoapRequestForBody
 @brief			Create whole soap request with header, body and suffix 
 @param			NSString
 @return		NSString
 */
-(NSString *) createSoapRequestForBody:(NSString *) bodyString;

@end
