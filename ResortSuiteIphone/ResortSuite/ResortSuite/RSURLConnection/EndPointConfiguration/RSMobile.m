//
//  RSMobile.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMobile.h"

@implementation RSMobile
@synthesize version = _version;
@synthesize status = _status;
@synthesize endPointUrl = _endPointUrl;

-(id)init
{
    self = [super init];
    if (self) { //assign the string with empty strings
        _version = [[NSMutableString alloc]initWithFormat:@""];
        _status = [[NSMutableString alloc]initWithFormat:@""];
        _endPointUrl = [[NSMutableString alloc]initWithFormat:@""];
        return self;
    }
    return nil; //if object is not created
}

-(void)dealloc
{
    [_version release];
    [_status release];
    [_endPointUrl release];
    [super dealloc];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"version = %@ status = %@ endpoint url = -%@-",_version,_status,_endPointUrl];
}
@end
