//
//  SoapRequests.m
//  ResortSuite
//
//  Created by Cybage on 22/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "SoapRequests.h"


@implementation SoapRequests

-(NSString *) createSoapRequestForBody:(NSString *) bodyString
{
	NSString *prefix = [NSString stringWithFormat:
						@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rsap=\"http://www.resortsuite.com/RSAPP\">"
						"<soapenv:Header>"
						"<o:Security soapenv:mustUnderstand=\"1\" xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
						"<o:UsernameToken>"
                        //"<Source>IPHONE</Source>"
						"<o:Username>resortsuite</o:Username>"
						"<o:Password>resortsuite</o:Password>"
						"</o:UsernameToken>"
						"</o:Security>"
						"</soapenv:Header>"
						"<soapenv:Body>"];
	
	NSString *suffix = [NSString stringWithFormat:
						@"</soapenv:Body>"
						"</soapenv:Envelope>"];
	
	NSString *soapRequest = [NSString stringWithFormat:@"%@%@%@",prefix, bodyString, suffix];

	return soapRequest;
}


@end
