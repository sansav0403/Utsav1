//
//  RSSelectedSpaLocation.m
//  ResortSuite
//
//  Created by Cybage on 29/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSelectedSpaLocation.h"

static RSSelectedSpaLocation *selectedSpaLocation=nil;



@implementation RSSelectedSpaLocation

@synthesize spaLocation;

+(RSSelectedSpaLocation *)sharedInstance
{
	@synchronized(self)
	{
		if(selectedSpaLocation==nil)
		{
			selectedSpaLocation=[[RSSelectedSpaLocation alloc]init];
        }
	}
	return selectedSpaLocation;
}

@end
