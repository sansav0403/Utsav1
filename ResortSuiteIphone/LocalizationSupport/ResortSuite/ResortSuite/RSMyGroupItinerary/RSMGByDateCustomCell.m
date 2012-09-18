//
//  RSMGByDateCustomCell.m
//  ResortSuite
//
//  Created by Cybage on 09/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMGByDateCustomCell.h"


@implementation RSMGByDateCustomCell
@synthesize fieldLabel1,fieldLabel2,fieldLabel3;
@synthesize headerLable1,headerLable2,headerLable3,dotLine;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];

		headerLable1 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable2 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable3 = [[UILabel alloc]initWithFrame:CGRectZero];
		dotLine = [[UILabel alloc]initWithFrame:CGRectZero];
		
		headerLable1.backgroundColor = [UIColor clearColor];
		headerLable1.opaque = YES;
		headerLable1.textColor = [UIColor blackColor];
		[headerLable1 setFont:[UIFont boldSystemFontOfSize:12]];
				
		headerLable2.backgroundColor = [UIColor clearColor];
		headerLable2.opaque = YES;
		headerLable2.textColor = [UIColor blackColor];
		[headerLable2 setFont:[UIFont boldSystemFontOfSize:12]];
				
		headerLable3.backgroundColor = [UIColor clearColor];
		headerLable3.opaque = YES;
		headerLable3.textColor = [UIColor blackColor];
		[headerLable3 setFont:[UIFont boldSystemFontOfSize:12]];
				
		dotLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]];
		dotLine.opaque = YES;
				
		[self.contentView addSubview:headerLable1];
		[self.contentView addSubview:headerLable2];
		[self.contentView addSubview:headerLable3];
		[self.contentView addSubview:dotLine];
		
		[headerLable1 release];
		[headerLable2 release];
		[headerLable3 release];
		[dotLine release];
		
		//-----------------------------dynamic label-----------------
		fieldLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];

		fieldLabel1.backgroundColor = [UIColor clearColor];
		fieldLabel1.opaque = YES;
		fieldLabel1.textColor = [UIColor blackColor];
		[fieldLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
			
		fieldLabel2.backgroundColor = [UIColor clearColor];
		fieldLabel2.opaque = YES;
		fieldLabel2.textColor = [UIColor blackColor];
		[fieldLabel2 setFont:[UIFont boldSystemFontOfSize:12]];
		
		fieldLabel3.backgroundColor = [UIColor clearColor];
		fieldLabel3.opaque = YES;
		fieldLabel3.textColor = [UIColor blackColor];
		[fieldLabel3 setFont:[UIFont boldSystemFontOfSize:12]];

		[self.contentView addSubview:fieldLabel1];
		[self.contentView addSubview:fieldLabel2];
		[self.contentView addSubview:fieldLabel3];
		
		[fieldLabel1 release];
		[fieldLabel2 release];
		[fieldLabel3 release];
		
		
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
