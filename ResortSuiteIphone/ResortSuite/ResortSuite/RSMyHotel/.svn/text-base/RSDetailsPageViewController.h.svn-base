//
//  RSDetailsPageViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSTableView;

@interface RSDetailsPageViewController : UIViewController<UIWebViewDelegate>{
	NSMutableArray* mainFieldArray;

	NSString *viewTitle;
	NSString *viewImage;
	NSString *content;
	
	UIWebView *contentView;
	ResortSuiteAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSString *viewTitle;
@property (nonatomic, retain) NSString *viewImage;
@property (nonatomic, retain) NSString *content;

@property (nonatomic, retain) IBOutlet UIWebView *contentView;

/*!
 @method		initWithNibName
 @brief			Initialize the view with image, title and detil string
 @details		-
 @param			(NSString *) nibNameOrNil,(NSBundle *) nibBundleOrNil, (NSString *) viewtitle, 
				(NSString *) viewimage, (NSString *) contentString;
 @return		id
 */
- (id)initWithNibName:(NSString *) nibNameOrNil 
			   bundle:(NSBundle *) nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			viewImage:(NSString *) viewimage 
			  content:(NSString *) contentString;

@end
