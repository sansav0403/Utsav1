//
//  RSListViewNode.m
//  ResortSuite
//
//  Created by Cybage on 27/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSListViewNode.h"


@implementation RSListViewNode

@synthesize nodeTitle;
@synthesize nodeHeader_Image;
@synthesize nodeIcon_Image;
@synthesize nodeDictionaryArray;

-(id)initWithTitle:(NSString *)title HeaderImage:(NSString *)imgName IConImage:(NSString *)iconName NodeArray:(NSArray *)nodeArray
{
	self = [super init];
	if (self) {
		self.nodeTitle = title;
		self.nodeHeader_Image = imgName;
		self.nodeIcon_Image = iconName;
		self.nodeDictionaryArray = nodeArray;
	}
	return self;
}

-(void)dealloc
{
	[nodeTitle release];
	[nodeHeader_Image release];
	[nodeIcon_Image release];
	[nodeDictionaryArray release];
	[super dealloc];
}
@end
