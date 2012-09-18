//
//  RSMIDateScreenCustomCell.h
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *custom uitableviewCell to handle the UI requirment of the date detail screen table view
 
 ================================================================================
 */
#import <UIKit/UIKit.h>


@interface RSMIDateScreenCustomCell : UITableViewCell {

	
	UILabel *titleLabel;		//to diplay the folio type
	UILabel *locationLabel;		//only for hotel location
	UILabel *fieldLabel1;
	UILabel *fieldLabel2;
	UILabel *fieldLabel3;
	UILabel *fieldLabel4;
	UILabel *fieldLabel5;
	
	UILabel *headerLable1;
	UILabel *headerLable2;
	UILabel *headerLable3;
	UILabel *headerLable4;
	UILabel *headerLable5;
	
	UILabel *dotLine;
}

@property(nonatomic,retain) UILabel *headerLable1;
@property(nonatomic,retain) UILabel *headerLable2;
@property(nonatomic,retain) UILabel *headerLable3;
@property(nonatomic,retain) UILabel *headerLable4;
@property(nonatomic,retain) UILabel *headerLable5;

@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UILabel *locationLabel;

@property(nonatomic,retain) UILabel *fieldLabel1;
@property(nonatomic,retain) UILabel *fieldLabel2;
@property(nonatomic,retain) UILabel *fieldLabel3;
@property(nonatomic,retain) UILabel *fieldLabel4;
@property(nonatomic,retain) UILabel *fieldLabel5;

@property(nonatomic,retain) UILabel *dotLine;

@end
