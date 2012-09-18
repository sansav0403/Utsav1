//
//  RSMGByCategoryViewController.h
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request to view the itinerary segregated by the event category.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSTableView.h"

@interface RSMIByCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *GroupEventArray;	
	
	NSMutableArray *categoryKeyArray;
	NSMutableDictionary *categoryDictionary;
	NSArray *sortedcategoryKeyArray;
	

	
	RSTableView * mainTableView;
}

@end
