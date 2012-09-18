//
//  RSMGByCategoryViewController.h
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTableView.h"

@interface RSMGByCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *GroupEventArray;	
	
	NSMutableArray *categoryKeyArray;
	NSMutableDictionary *categoryDictionary;
	NSArray *sortedcategoryKeyArray;
	
	RSTableView * mainTableView;
}

@end
