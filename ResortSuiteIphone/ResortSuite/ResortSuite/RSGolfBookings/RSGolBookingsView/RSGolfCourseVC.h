//
//  RSGolfCourseVC.h
//  ResortSuite
//
//  Created by Cybage on 23/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class RSBookingTableView;
@class ResortSuiteAppDelegate;

@interface RSGolfCourseVC : UIViewController <RSParserHandlerDelegate,RSConnectionHandlerDelegate, 
UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource> { 
	NSMutableArray* mainFieldArray;
	RSBookingTableView* mainTableView;
	
	ResortSuiteAppDelegate *appDelegate;
}

@end
