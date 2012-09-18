//
//  CustomView.m
//  Resort-Suite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "CustomView.h"
#import "StoreImageObj.h"

@implementation CustomView
@synthesize imageArray,delegate,arrayOfImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		arrayOfImageView = [[NSMutableArray alloc]init];
		
		for (int imageIndex = 0; imageIndex < [imageArray count] ; imageIndex++) {
			CustomImageView *imageView = [[CustomImageView alloc]initWithFrame:CGRectZero];
			
			UIImage *image = [UIImage imageNamed:[[imageArray objectAtIndex:imageIndex] imageName]];
			[imageView setImage:image];
			
			[imageView setIndex:imageIndex];
			[imageView setUserInteractionEnabled:YES];
			[imageView setDelegate:self];
			[self addSubview:imageView];
			
			[arrayOfImageView addObject:imageView];
			[imageView release];
		}
    }

    return self;
}

#define ImageViewWidth          75
#define ImageViewHeight         75
#define XDistanceBetweenImage   4
#define YDistanceBetweenImage   4

-(void)layoutSubviews
{
	int x ,y ,index = 0,count = [arrayOfImageView count],row = 1;
	
	for (int imageCount = 1; (index < count); imageCount++) 
	{
		UIImageView * view = [arrayOfImageView	objectAtIndex:index];
		
		x = (XDistanceBetweenImage*(imageCount -1) + ImageViewWidth*(imageCount -1));
		
		y =  (YDistanceBetweenImage *(row -1) + ImageViewHeight * (row -1));
		
		CGRect frame = CGRectMake(x+XDistanceBetweenImage, y+YDistanceBetweenImage, ImageViewWidth, ImageViewHeight);
		[view setFrame:frame];
		index++;
		if (imageCount==4) {
			
			row++;	//to set y
			imageCount=0;	//to set x
		}
	}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/
#pragma mark imageTouchedDelegate
-(void)imageTouchedAtIndex:(int)index
{
	if (delegate) {
		[delegate imageTouchedAtIndexInfo:index];
	}
}
- (void)dealloc {
    [super dealloc];
	[imageArray release];
	[arrayOfImageView release];
}


@end
