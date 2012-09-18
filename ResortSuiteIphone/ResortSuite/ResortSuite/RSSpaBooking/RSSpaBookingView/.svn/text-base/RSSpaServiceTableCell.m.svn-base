//
//  RSSpaServiceTableCell.m
//  ResortSuite
//
//  Created by Cybage on 9/27/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaServiceTableCell.h"

#import "RSChargeTableCellLabel.h"





@implementation RSSpaServiceTableCell


@synthesize fieldLabel1,fieldLabel2,fieldLabel3,fieldLabel4;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier secondField:(BOOL) isSecondField
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.selectionStyle	= UITableViewCellSelectionStyleGray;
		self.backgroundColor = [UIColor clearColor];
        
		fieldLabel1 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
		fieldLabel3 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
		[fieldLabel3 setTextAlignment:UITextAlignmentRight];    //for price
        
        fieldLabel4 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
        
        //set frame and number of line for lb1-2
        fieldLabel1.numberOfLines = 2;
        fieldLabel3.numberOfLines = 2;
        fieldLabel4.numberOfLines = 2;
       
        fieldLabel1.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
		fieldLabel3.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
        fieldLabel4.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;

        fieldLabel3.frame = CGRectMake(label3_XCord, label_YCord, label3Width, label3_4Height);
        fieldLabel4.frame = CGRectMake(label4_XCord, label_YCord, label4Width, label3_4Height);
        
		if (isSecondField) {
			fieldLabel1.frame = CGRectMake(label1_XCord, label_YCord, 100, label1_2Height);
					
			fieldLabel2 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
			fieldLabel2.numberOfLines = 1;
			fieldLabel2.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
			fieldLabel2.frame = CGRectMake(110, label_YCord, 60, label1_2Height);
			[self.contentView addSubview:fieldLabel2];
			[fieldLabel2 release];
		}
		else {
			fieldLabel1.frame = CGRectMake(label1_XCord, label_YCord, label1Width, label1_2Height);
		}

		
		[self.contentView addSubview:fieldLabel1];
		[self.contentView addSubview:fieldLabel3];
        [self.contentView addSubview:fieldLabel4];
		
		[fieldLabel1 release];
		[fieldLabel3 release];
        [fieldLabel4 release];
    }
    return self;
}

-(void) EditAccessoryView
{
	//Insert custom Accessory View
	self.accessoryType = UITableViewCellAccessoryNone;
	UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CellAccessoryImageSize];//CGRectMake(0, 0, 18, 15)
	cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImageCircular];
	cellAccessoryImageView.backgroundColor = [UIColor clearColor];
	self.accessoryView = cellAccessoryImageView;
	[cellAccessoryImageView release];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [super dealloc];
}

@end
