//
//  RSChargeObject.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSChargeObject.h"


@implementation RSChargeObject

@synthesize objectLabels,chargeDescription;

-(id)initWtihObjectLabels:(NSArray *)labels withChargeDescription:(NSString *)desc
{
	self.objectLabels = labels;
	if (desc != nil) {
		self.chargeDescription = desc;
	}
	else {
		self.chargeDescription = @"no description";
	}
	return self;
}
-(void)dealloc
{
	[objectLabels release];
	[chargeDescription release];
	[super dealloc];
}
@end
