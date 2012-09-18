//
//  RSSelectedGolfLocation.m
//  ResortSuite
//
//  Created by Cybage on 10/7/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSelectedGolfLocation.h"

static RSSelectedGolfLocation *selectedGolfLocation=nil;

@implementation RSSelectedGolfLocation

@synthesize golfLocation;

+(RSSelectedGolfLocation *)sharedInstance
{
	@synchronized(self)
	{
		if(selectedGolfLocation==nil)
		{
			selectedGolfLocation=[[RSSelectedGolfLocation alloc]init];
        }
	}
	return selectedGolfLocation;
}

@end

