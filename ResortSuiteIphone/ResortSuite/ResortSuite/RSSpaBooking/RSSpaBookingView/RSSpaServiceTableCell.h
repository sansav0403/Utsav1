//
//  RSSpaServiceTableCell.h
//  ResortSuite
//
//  Created by Cybage on 9/27/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
Custom table cell to set frame of different label to dispaly service in the serivce table view.

 ================================================================================
 */
#import <UIKit/UIKit.h>

@class RSChargeTableCellLabel;

@interface RSSpaServiceTableCell : UITableViewCell {
    
	RSChargeTableCellLabel *fieldLabel1;
	RSChargeTableCellLabel *fieldLabel2;
	RSChargeTableCellLabel *fieldLabel3;
    RSChargeTableCellLabel *fieldLabel4;
}
@property(nonatomic,retain) RSChargeTableCellLabel *fieldLabel1;
@property(nonatomic,retain) RSChargeTableCellLabel *fieldLabel2;
@property(nonatomic,retain) RSChargeTableCellLabel *fieldLabel3;
@property(nonatomic,retain) RSChargeTableCellLabel *fieldLabel4;

/*!
 @method		EditAccessoryView
 @brief			Update accessory view with circular arrow button
 @details		-
 @param			-
 @return		void
 */
-(void) EditAccessoryView;

/*!
 @method		initWithStyle
 @brief			Cell initialization according to the no. of columns
 @details		isSecondField describes whether to add second column or not
 @param			UITableViewCellStyle style, NSString reuseIdentifier, BOOL isSecondField;
 @return		obj of RSSpaServiceTableCell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier secondField:(BOOL) isSecondField;


@end
