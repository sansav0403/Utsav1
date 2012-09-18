//
//  RSTableView.m
//  ResortSuite
//
//  Created by Cybage on 6/1/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSTableView.h"


@implementation RSTableView
#define TableRow_Height						69
#define TableSectionHeader_Height			1
#define TableSectionFooter_Height			1

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(TableCell_X, TableCell_Y, TableCell_Width, TableCell_Height) style:UITableViewStylePlain];
    if (self) {
        // Initialization code.
		
		self.separatorStyle		= UITableViewCellSeparatorStyleNone; 
		self.backgroundColor	= [UIColor clearColor]; 
		self.rowHeight          = TableRow_Height;
		self.sectionHeaderHeight = TableSectionHeader_Height;
		self.sectionFooterHeight = TableSectionFooter_Height;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = YES;
		self.scrollEnabled = YES;
		self.bounces = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
