    //
//  Gallery.m
//  Resort-Suite
//
//  Created by Cybage on 31/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "Gallery.h"


@implementation Gallery
@synthesize imageArray ,costumView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

#define ImagesInAppBundle 10            //change this as number of images increases for gallery
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:MyItinerary_HI controller:self];
	
	imageArray = [[NSMutableArray alloc]init];
	[self setTitle:RsGallaryTitle];
	for (int imageIndex = 1; imageIndex <= ImagesInAppBundle; imageIndex++) {
		StoreImageObj *imageObj = [[StoreImageObj alloc]initWithImageName:[NSString stringWithFormat:@"GalleryImage%d.jpg",imageIndex]];
		[imageObj description];
		[imageArray addObject:imageObj];
		[imageObj release];
	}
	
	CustomView *customView = [CustomView alloc];
	[customView setImageArray:imageArray];
	customView = [customView initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
	[customView setDelegate:self];
	UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
	[scrollView setContentSize:CGSizeMake(Screen_Width, Screen_Height)];
	UIEdgeInsets inset = {40.0,0.0,50.0,0.0};
	[scrollView setContentInset:inset];
	[scrollView setContentOffset:CGPointMake(0, -40)];
	scrollView.scrollEnabled = NO;
	if ([imageArray count] > 12) {
		[scrollView setScrollEnabled:YES];
	}
	[scrollView addSubview:customView];
	[self.view addSubview:scrollView];
	[customView release];
	[scrollView release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark touchedImageInfoDelegate
-(void)imageTouchedAtIndexInfo:(int)index
{
	PhotoViewController *photoViewController = [[PhotoViewController alloc]initWithNibName:@"PhotoViewController" 
														bundle:[NSBundle mainBundle] imageArray:[self imageArray] index:index];
	
	[photoViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
	[photoViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
	[photoViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
	[photoViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
	
	[self.navigationController pushViewController:photoViewController animated:YES];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	[photoViewController release];
}

- (void)dealloc {
	[imageArray release];
	[costumView release];
    [super dealloc];
}


@end
