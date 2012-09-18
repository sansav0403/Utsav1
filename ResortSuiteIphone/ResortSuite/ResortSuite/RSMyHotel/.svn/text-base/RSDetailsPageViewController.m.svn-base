//
//  RSDetailsPageViewController.m
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSDetailsPageViewController.h"
//#import "RSMIMainScreenViewController.h"
//#import "RSTableView.h"
#import "URLCaching.h"
//#import "RSMainViewController.h"

@implementation RSDetailsPageViewController

@synthesize viewTitle;
@synthesize viewImage;
@synthesize content;
@synthesize contentView;


#pragma mark -
#pragma mark View lifecycle

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil 
			   bundle:(NSBundle *)nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			viewImage:(NSString *) viewimage 
			  content:(NSString *) contentString {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	// Custom initialization.
		self.viewTitle = viewtitle;
		self.viewImage = viewimage;
		self.content = contentString;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:self.viewTitle fontSize:nil];
	
	[ResortSuiteAppDelegate setCurrentScreenImage:self.viewImage controller:self];
	
	contentView.backgroundColor= [UIColor clearColor];
    [self.view bringSubviewToFront:contentView];
	[contentView setOpaque:NO];
	contentView.delegate = self;
		
	NSString *path = [[NSBundle mainBundle] pathForResource:self.content ofType:nil];
	
	if (path !=nil) //It will display static content
	{
		NSURL *url = [NSURL fileURLWithPath:path];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[contentView loadRequest:request];
	}
	else  //It will display Web page
	{
		URLCaching *urlCache = [URLCaching instance];
		
		NSString *fileString = [[[NSString alloc] init] autorelease];
		
		if (appDelegate.connectedToInternet) {
			NSURL *url = [NSURL URLWithString:self.content];
			//NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
			[contentView loadRequest:request];
			
			BOOL isFileCached = [urlCache addRemoteFileToCache:self.content withString:fileString];
			if(isFileCached)
			{
				DLog(@"File Cached");
			}
		}
		else {			
			if ([urlCache isRemoteFileCached:self.content]) {
				fileString = [urlCache getCachedRemoteFile:self.content];
				[contentView loadHTMLString:fileString baseURL:nil];
			}
//			else {//always display message incase netowrk is not available
				UIAlertView *errorAlert = [[UIAlertView alloc]
										   initWithTitle:POPUP_Error
										   message:POPUP_No_Network
										   delegate:nil
										   cancelButtonTitle:POPUP_Button_Ok
										   otherButtonTitles:nil];
				[errorAlert show];
				[errorAlert release];
//			}	
		}
	}

    UIScrollView *scrollView = [contentView.subviews objectAtIndex:0];
    scrollView.bounces = NO;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    contentView.delegate = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)dealloc {
    NSLog(@"RSDetailPageViewController dealloc");
	[viewTitle release];
	[viewImage release];
	[content release];
    contentView.delegate = nil;
	[contentView release];
	
    [super dealloc];
}

#pragma mark Web view delegates

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	//CAPTURE USER LINK-CLICK.
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		NSURL *URL = [request URL];   
		if ([[URL scheme] isEqualToString:@"http"] || [[URL scheme] isEqualToString:@"https"] || [[URL scheme] isEqualToString:@"mailto"]) {
			[[UIApplication sharedApplication] openURL:URL];
			return NO;
		}
	}        
	return YES;  
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"webViewDidStartLoad");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	//[self.view addSubview:appDelegate.activityIndicator.view];
	[self.navigationController.view addSubview:appDelegate.activityIndicator.view];
    [appDelegate.activityIndicator.activity startAnimating];

	//self.navigationController.navigationBar.userInteractionEnabled = NO;

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"webViewDidFinishLoad");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	[appDelegate.activityIndicator.activity stopAnimating];
	[appDelegate.activityIndicator.view removeFromSuperview];
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	[appDelegate.activityIndicator.activity stopAnimating];
	[appDelegate.activityIndicator.view removeFromSuperview];
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:POPUP_Error
                               message:POPUP_No_Network
                               delegate:nil
                               cancelButtonTitle:POPUP_Button_Ok
                               otherButtonTitles:nil];
    [errorAlert show];
    [errorAlert release];
}

@end

