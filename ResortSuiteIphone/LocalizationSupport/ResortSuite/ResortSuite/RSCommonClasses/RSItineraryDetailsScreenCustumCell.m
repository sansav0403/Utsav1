//
//  RSItineraryDetailsScreenCustumCell.m
//  ResortSuite
//
//  Created by Cybage on 02/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSItineraryDetailsScreenCustumCell.h"


@implementation RSItineraryDetailsScreenCustumCell
@synthesize dateLabel,fieldLabel1,fieldLabel2,fieldLabel3,fieldLabel4, fieldLabel5, dotLine;
@synthesize headerLable1,headerLable2,headerLable3,headerLable4,headerLable5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		dateLabel	= [[UILabel alloc]initWithFrame:dateLabelcords];
		dotLine = [[UILabel alloc]initWithFrame:dotLineLabelcords];
		dotLine.frame = CGRectMake(label_x, label_y +(label_height * 2+10 ),300 , label_height-5);
		
		dateLabel.backgroundColor = [UIColor clearColor];
		dateLabel.opaque = YES;
		dateLabel.textColor = [UIColor blackColor];
		[dateLabel setFont:[UIFont boldSystemFontOfSize:15]];
	
		headerLable1 = [[UILabel alloc]initWithFrame:serviceLabelcords];
		headerLable2 = [[UILabel alloc]initWithFrame:timeLabelcords];
		headerLable3 = [[UILabel alloc]initWithFrame:performedByLabelcords];
		headerLable4 = [[UILabel alloc]initWithFrame:roomLabelcords];
		headerLable5 = [[UILabel alloc]initWithFrame:Labelcords5];
		
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
		[self.contentView addSubview:dateLabel];
		[self.contentView addSubview:dotLine];
		
//-----------------------------dynamic label-----------------
		fieldLabel1 = [[UILabel alloc]initWithFrame:DyserviceLabelcords];
		fieldLabel2 = [[UILabel alloc]initWithFrame:DytimeLabelcords];
		fieldLabel3 = [[UILabel alloc]initWithFrame:DyperformedByLabelcords];
		fieldLabel4 = [[UILabel alloc]initWithFrame:DyroomLabelcords];
		fieldLabel5 = [[UILabel alloc]initWithFrame:DyLabelcords5];
		
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

-(void)layoutSubviews
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:NO];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[dateLabel release];
	[headerLable1 release];
	[headerLable2 release];
	[headerLable3 release];
	[headerLable4 release];
	[headerLable5 release];
	[dotLine release];
	
    [super dealloc];

	}


@end
