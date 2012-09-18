//
//  RSChargeTableCell.m
//  ResortSuite
//
//  Created by Cybage on 08/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSChargeTableCell.h"
#import "RSChargeTableCellLabel.h"

@implementation RSChargeTableCell
@synthesize fieldLabel1,fieldLabel2,fieldLabel3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		fieldLabel1 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
		fieldLabel2 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];

		fieldLabel3 = [[RSChargeTableCellLabel alloc]initWithFontSize:FONT_SIZE];
		[fieldLabel3 setTextAlignment:UITextAlignmentRight];
		 
		[self.contentView addSubview:fieldLabel1];
		[self.contentView addSubview:fieldLabel2];
		[self.contentView addSubview:fieldLabel3];
		
		[fieldLabel1 release];
		[fieldLabel2 release];
		[fieldLabel3 release];
    }

    return self;
}

-(void) EditAccessoryView
{
	//Insert custom Accessory View
	self.accessoryType = UITableViewCellAccessoryNone;
	UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 15)];
	cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImage];
	cellAccessoryImageView.backgroundColor = [UIColor clearColor];
	self.accessoryView = cellAccessoryImageView;
	[cellAccessoryImageView release];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}


- (void)dealloc {
    
	[super dealloc];
}


@end
