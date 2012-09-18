    //
//  RSBookingTableView.m
//  ResortSuite
//
//  Created by Cybage on 26/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSBookingTableView.h"

@implementation RSBookingTableView

#define TableRow_Height	44


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, TableRow_Height, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    if (self) {
        // Initialization code.		
		self.separatorStyle		= UITableViewCellSeparatorStyleNone; 
		self.backgroundColor	= [UIColor clearColor]; 
        self.separatorColor     = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableColor.png"]];
		self.rowHeight          = TableRow_Height;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = YES;
		self.scrollEnabled = YES;
		self.bounces = NO;
    }
    return self;
}


- (id)initWithYCordinate:(int) Y {
    
    self = [super initWithFrame:CGRectMake(0, Y, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    if (self) {
        // Initialization code.		
		self.separatorStyle		= UITableViewCellSeparatorStyleNone; 
		self.backgroundColor	= [UIColor clearColor]; 
        self.separatorColor     = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableColor.png"]];		
		self.rowHeight          = TableRow_Height;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = YES;
		self.scrollEnabled = YES;
		self.bounces = NO;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
