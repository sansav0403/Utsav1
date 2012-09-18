//
//  CustomImageView.m
//  Resort-Suite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "CustomImageView.h"


@implementation CustomImageView

@synthesize index,delegate;



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (delegate) {
		[delegate imageTouchedAtIndex:[self index]];
	}
}

-(void)dealloc
{
	[super dealloc];
}
@end
