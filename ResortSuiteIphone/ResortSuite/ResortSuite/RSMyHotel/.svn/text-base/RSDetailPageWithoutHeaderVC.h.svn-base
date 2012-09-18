//
//  RSDetailPageWithoutHeaderVC.h
//  ResortSuite
//
//  Created by Cybage on 5/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
//OceanSuiteHeader.jpg
//OceanSuite.html
@interface RSDetailPageWithoutHeaderVC : UIViewController<UIWebViewDelegate>
{
    
	NSString    *viewTitle;
    ResortSuiteAppDelegate *appDelegate;
}
@property (nonatomic,copy) NSString                 *viewTitle;
@property (nonatomic, retain)IBOutlet UIWebView     *contentView;
@property (nonatomic, copy) NSString                *content;

- (id)initWithNibName:(NSString *)nibNameOrNil 
			   bundle:(NSBundle *)nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			  content:(NSString *) contentString;

@end
