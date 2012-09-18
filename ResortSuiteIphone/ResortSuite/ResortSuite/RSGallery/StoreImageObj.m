//
//  StoreImageObj.m
//  Community
//
//  Created by Cybage on 20/01/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "StoreImageObj.h"


@implementation StoreImageObj

@synthesize imageName;


-(id)initWithImageName:(NSString *)name {	
	self.imageName = name;//[name retain];
		
	return self;
}

- (void) dealloc
{
	[imageName release];
	[super dealloc];
}

-(NSString *)description{
	return [NSString stringWithFormat:@"Image name = %@ ",imageName];
}

@end
