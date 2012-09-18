//
//  RsBookingCellBaseClass.m
//  ResortSuite
//
//  Created by Cybage on 9/16/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RsBookingCellBaseClass.h"



@implementation RsBookingCellBaseClass

@synthesize fieldLabel1;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor redColor];
        
        fieldLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];    //allocate memory to labels
        
		fieldLabel1.backgroundColor = [UIColor clearColor];         //set the view of label
		fieldLabel1.opaque = YES;
		fieldLabel1.textColor = [UIColor blackColor];
		[fieldLabel1 setFont:[UIFont boldSystemFontOfSize:cellLabelFontSize]];
        fieldLabel1.frame = cellLabelCord;
        
        [self.contentView addSubview:fieldLabel1];                  //add labels to view
		
		[fieldLabel1 release];                                      // release labels  
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
