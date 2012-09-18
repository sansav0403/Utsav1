//
//  RSMIDateScreenCustomCell.m
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIDateScreenCustomCell.h"


@implementation RSMIDateScreenCustomCell

@synthesize titleLabel,locationLabel,fieldLabel1,fieldLabel2,fieldLabel3,fieldLabel4, fieldLabel5, dotLine;
@synthesize headerLable1,headerLable2,headerLable3,headerLable4,headerLable5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		// Initialization code.
		titleLabel	= [[UILabel alloc]initWithFrame:CGRectZero];
		dotLine = [[UILabel alloc]initWithFrame:CGRectZero];
		locationLabel = [[UILabel alloc]initWithFrame:CGRectZero];
		
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.opaque = YES;
		titleLabel.textColor = [UIColor blackColor];
		[titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
		
		locationLabel.backgroundColor = [UIColor clearColor];
		locationLabel.opaque = YES;
		locationLabel.textColor = [UIColor blackColor];
		[locationLabel setFont:[UIFont boldSystemFontOfSize:15]];
	
		//		
		headerLable1 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable2 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable3 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable4 = [[UILabel alloc]initWithFrame:CGRectZero];
		headerLable5 = [[UILabel alloc]initWithFrame:CGRectZero];
		
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
		
		headerLable4.backgroundColor = [UIColor clearColor];
		headerLable4.opaque = YES;
		headerLable4.textColor = [UIColor blackColor];
		[headerLable4 setFont:[UIFont boldSystemFontOfSize:12]];
		
		headerLable5.backgroundColor = [UIColor clearColor];
		headerLable5.opaque = YES;
		headerLable5.textColor = [UIColor blackColor];
		[headerLable5 setFont:[UIFont boldSystemFontOfSize:12]];
		
		dotLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]];
		dotLine.opaque = YES;
		
		[self.contentView addSubview:headerLable1];
		[self.contentView addSubview:headerLable2];
		[self.contentView addSubview:headerLable3];
		[self.contentView addSubview:headerLable4];
		[self.contentView addSubview:headerLable5];
		[self.contentView addSubview:titleLabel];
		[self.contentView addSubview:dotLine];
		[self.contentView addSubview:locationLabel];
		
		[titleLabel release];
		[locationLabel release];
		[headerLable1 release];
		[headerLable2 release];
		[headerLable3 release];
		[headerLable4 release];
		[headerLable5 release];
		[dotLine release];
		
		
		//-----------------------------dynamic label-----------------
		fieldLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel4 = [[UILabel alloc]initWithFrame:CGRectZero];
		fieldLabel5 = [[UILabel alloc]initWithFrame:CGRectZero];
		
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
		
		fieldLabel4.backgroundColor = [UIColor clearColor];
		fieldLabel4.opaque = YES;
		fieldLabel4.textColor = [UIColor blackColor];
		[fieldLabel4 setFont:[UIFont boldSystemFontOfSize:12]];
		//		
		fieldLabel5.backgroundColor = [UIColor clearColor];
		fieldLabel5.opaque = YES;
		fieldLabel5.textColor = [UIColor blackColor];
		[fieldLabel5 setFont:[UIFont boldSystemFontOfSize:12]];
		
		[self.contentView addSubview:fieldLabel1];
		[self.contentView addSubview:fieldLabel2];
		[self.contentView addSubview:fieldLabel3];
		[self.contentView addSubview:fieldLabel4];
		[self.contentView addSubview:fieldLabel5];
		
		
		[fieldLabel1 release];
		[fieldLabel2 release];
		[fieldLabel3 release];
		[fieldLabel4 release];
		[fieldLabel5 release];
		
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
