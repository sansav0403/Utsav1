//
//  RSMGMainScreenController.h
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>

enum GroupSections {
	ByDatesSection,
	ByCategoriesSecion,
	AllEventsSection
};

@class ResortSuiteAppDelegate;
@interface RSMGMainScreenController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate>{
	NSMutableArray* mainFieldArray;
	RSTableView* mainTableView;
	
	RSMainViewController *mainVC;
	ResortSuiteAppDelegate *appDelegate;
}

@end
