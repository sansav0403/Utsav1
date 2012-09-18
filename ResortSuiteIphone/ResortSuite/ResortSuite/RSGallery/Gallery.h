//
//  Gallery.h
//  Resort-Suite
//
//  Created by Cybage on 31/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import "PhotoViewController.h"
#import "StoreImageObj.h"

@interface Gallery : UIViewController <touchedImageInfoDelegate>{
	NSMutableArray *imageArray;
	CustomView *costumView;
}

@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) CustomView *costumView;
@end
