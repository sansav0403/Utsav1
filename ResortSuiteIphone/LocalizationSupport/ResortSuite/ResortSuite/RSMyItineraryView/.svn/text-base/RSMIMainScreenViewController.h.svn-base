//
//  RSMIMainScreenViewController.h
//  ResortSuite
//
//  Created by Cybage on 5/30/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 * view controller that present the user with the option to view information segregated by
 * Date
 * category
 * all 
 ================================================================================
 */
#import <UIKit/UIKit.h>

@class RSTableView;
@class ResortSuiteAppDelegate;

enum MISections {
	ByDateSection,
	ByCategorySection,
	AllSection
};

@interface RSMIMainScreenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate>{
	NSMutableArray          *mainFieldArray;
	RSTableView             *mainTableView;
	
	RSMainViewController    *mainVC;
	ResortSuiteAppDelegate  *appDelegate;
}

@end
