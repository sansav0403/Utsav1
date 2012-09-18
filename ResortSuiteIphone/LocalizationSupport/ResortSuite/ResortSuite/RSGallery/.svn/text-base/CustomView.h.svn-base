//
//  CustomView.h
//  Resort-Suite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@protocol touchedImageInfoDelegate

-(void)imageTouchedAtIndexInfo:(int)index;

@end

@interface CustomView : UIView <imageTouchedDelegate>{

	NSArray *imageArray;
	id<touchedImageInfoDelegate> delegate;
	NSMutableArray *arrayOfImageView;
}

@property(nonatomic, retain) NSArray *imageArray;
@property(nonatomic, retain) NSMutableArray *arrayOfImageView;
@property(nonatomic, assign) id<touchedImageInfoDelegate> delegate;
@end
