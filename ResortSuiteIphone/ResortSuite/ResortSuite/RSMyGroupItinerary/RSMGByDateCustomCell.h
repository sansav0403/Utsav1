//
//  RSMGByDateCustomCell.h
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSMGByDateCustomCell : UITableViewCell {

	UILabel *fieldLabel1;
	UILabel *fieldLabel2;
	UILabel *fieldLabel3;

	UILabel *headerLable1;
	UILabel *headerLable2;
	UILabel *headerLable3;
	UILabel *dotLine;
	
}

@property(nonatomic,retain) UILabel *headerLable1;
@property(nonatomic,retain) UILabel *headerLable2;
@property(nonatomic,retain) UILabel *headerLable3;

@property(nonatomic,retain) UILabel *fieldLabel1;
@property(nonatomic,retain) UILabel *fieldLabel2;
@property(nonatomic,retain) UILabel *fieldLabel3;

@property(nonatomic,retain) UILabel *dotLine;
@end
