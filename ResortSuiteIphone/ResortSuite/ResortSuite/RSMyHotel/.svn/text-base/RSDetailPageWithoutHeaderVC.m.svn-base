//
//  RSDetailPageWithoutHeaderVC.m
//  ResortSuite
//
//  Created by Cybage on 5/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSDetailPageWithoutHeaderVC.h"
#import "URLCaching.h"
#import "ResortSuiteAppDelegate.h"
//#import "RSMainViewController.h"
@implementation RSDetailPageWithoutHeaderVC
@synthesize viewTitle;
@synthesize contentView;
@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil 
			   bundle:(NSBundle *)nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			  content:(NSString *) contentString
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.viewTitle = viewtitle;
        
		self.content = contentString;
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	[appDelegate.mainVC showUpdatedLoginButton:appDelegate.isLoggedIn onController:self];
	
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:self.viewTitle fontSize:nil];
	
	[ResortSuiteAppDelegate setBackGroundImageForController:self];
	
	contentView.backgroundColor= [UIColor clearColor];
    [self.view bringSubviewToFront:self.contentView];
	[contentView setOpaque:NO];
	contentView.delegate = self;
    
    self.title = self.viewTitle;
    
    [self.contentView setOpaque:NO];
    UIScrollView *scrollView = [contentView.subviews objectAtIndex:0];
    scrollView.bounces = NO;    //set the bouncing of the webView
    
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
			NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
//OceanSuite.html			else {//always display message incase netowrk is not available
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
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    contentView.delegate = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
//	self.navigationController.navigationBar.userInteractionEnabled = NO;
    
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

- (void)dealloc {
    NSLog(@"RSDetailPageViewController dealloc");
	[viewTitle release];

	[content release];
    contentView.delegate = nil;
	[contentView release];
	
    [super dealloc];
}
@end
