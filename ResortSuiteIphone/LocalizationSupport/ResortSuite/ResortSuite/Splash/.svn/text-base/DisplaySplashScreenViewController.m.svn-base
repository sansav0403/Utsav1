//
//  DisplaySplashScreenViewController.m
//  ResortSuite
//
//  Created by Cybage on 11/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "DisplaySplashScreenViewController.h"

@implementation DisplaySplashScreenViewController
@synthesize splashImageView, displaySplash;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [splashImageView release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	//Hide the nav bar and tab bar from Splash screen
	self.navigationController.navigationBar.hidden = YES;
	self.tabBarController.tabBar.hidden = YES;

	//Set Splash screen image
	splashImageView.image = [UIImage imageNamed:Application_SplashScreen];

	//Call the removeScreen method after 4 sec delay
//	[self performSelector:@selector(removeScreen) withObject:nil afterDelay:4.0];
}

-(void)removeScreen
{
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

@end
