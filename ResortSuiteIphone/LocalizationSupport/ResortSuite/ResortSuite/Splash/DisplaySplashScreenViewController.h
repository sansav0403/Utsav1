//
//  DisplaySplashScreenViewController.h
//  ResortSuite
//
//  Created by Cybage on 11/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplaySplashScreenViewController : UIViewController {

	IBOutlet UIView *displaySplash;
	IBOutlet UIImageView *splashImageView;
	
	
}

@property (retain, nonatomic) IBOutlet UIImageView* splashImageView;
@property (retain, nonatomic) IBOutlet UIView *displaySplash;


/*!
 @method		removeScreen
 @brief			Remove the splash screen
 @details		This method will be called after the delay specified
 @param			nil
 @return		void
 */
 -(void)removeScreen;

@end

