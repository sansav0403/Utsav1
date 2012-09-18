//
//  RSNavigationController.m
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSNavigationController.h"


@implementation RSNavigationController


- (id)initWithTitle:(NSString*)tabBarTitle tabBarItemImage:(NSString*)tabBarImage tabBarItemTag:(int)tabBarTag
{
    
    self = [super init];
    if (self) {
        // Initialization code.
		self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		self.navigationBar.alpha = 0.70;

		self.tabBarItem.title = tabBarTitle;
		self.tabBarItem.image = [UIImage imageNamed:tabBarImage];
		self.tabBarItem.tag = tabBarTag;
		
    }
    return self;
}

-(BOOL)setTitle:(NSString*)tabBarTitle tabBarItemImage:(NSString*)tabBarImage tabBarItemTag:(int)tabBarTag
{
    if (self) {
        // Initialization code.
		self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		self.navigationBar.alpha = 0.70;
        
		self.tabBarItem.title = tabBarTitle;
		self.tabBarItem.image = [UIImage imageNamed:tabBarImage];
		self.tabBarItem.tag = tabBarTag;
        return YES;
		
    }
    else
    {
        return NO;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)dealloc {
    [super dealloc];
}


@end
