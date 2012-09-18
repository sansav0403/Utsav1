//
//  CustomImageView.h
//  Resort-Suite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol imageTouchedDelegate

-(void)imageTouchedAtIndex:(int)index;

@end

@interface CustomImageView : UIImageView {
	int index;
	id<imageTouchedDelegate> delegate;
}

@property(nonatomic,assign)id<imageTouchedDelegate> delegate;
@property(nonatomic) int index;
@end
