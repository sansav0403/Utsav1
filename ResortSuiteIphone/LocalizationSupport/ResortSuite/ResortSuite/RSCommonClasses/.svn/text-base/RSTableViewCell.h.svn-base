//
//  RSTableViewCell.h
//  ResortSuite
//
//  Created by Cybage on 6/2/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSTableViewCell : UITableViewCell {
	UILabel *cellLable;
	UIImageView* cellImageView;
	UIImageView* cellMaskImageView;
    
}

@property (nonatomic,retain) UILabel *cellLable;
@property (nonatomic,retain) UIImageView* cellImageView;
@property (nonatomic,retain) UIImageView* cellMaskImageView;

/*!
 @method		DoMaskingOnCellImage
 @brief			It will add view into the custom view of cell
 @details		-
 @param			-
 @return		void
 */
-(void) DoMaskingOnCellImage;

//Do nothing
+(void) DoMaskingOnSelectedCellImage:(UITableViewCell*)cellFromTVC;

/*!
 @method		EditAccessoryView
 @brief			Update accessory view with circular arrow button
 @details		-
 @param			-
 @return		void
 */
-(void) EditAccessoryView;
@end
