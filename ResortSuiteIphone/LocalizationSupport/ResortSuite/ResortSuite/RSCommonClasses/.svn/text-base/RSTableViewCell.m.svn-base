//
//  RSTableViewCell.m
//  ResortSuite
//
//  Created by Cybage on 6/2/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSTableViewCell.h"

@implementation RSTableViewCell

@synthesize cellLable;
@synthesize cellImageView, cellMaskImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.selectionStyle	= UITableViewCellSelectionStyleGray;

        //Image setting for tableviewcell
        UIImageView *cellBGImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        cellBGImgView.image  = [UIImage imageNamed:CellBackgroudImage];
        self.backgroundView = cellBGImgView;
        [cellBGImgView release];
        
		//Image setting for selected tableviewcell
        UIImageView *viewSelected = [[UIImageView alloc] initWithFrame:CGRectZero];
        viewSelected.image = [UIImage imageNamed:CellSelectedBGImage];
        self.selectedBackgroundView = viewSelected;
        [viewSelected release];

		//Insert custom Accessory View
		self.accessoryType = UITableViewCellAccessoryNone;
		UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 15)];
		cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImage];
		cellAccessoryImageView.backgroundColor = [UIColor clearColor];
		self.accessoryView = cellAccessoryImageView;
		[cellAccessoryImageView release];
		
		//Create a lable to display the content in the cell
		cellLable = [[UILabel alloc] initWithFrame:TableCellLableSize];
		cellLable.backgroundColor = [UIColor clearColor]; 
		//cellLable.adjustsFontSizeToFitWidth = YES; 
		cellLable.numberOfLines = 2;
		[self.contentView addSubview:cellLable];

		cellImageView = [[UIImageView alloc] initWithFrame:TableCellImageSize];
		[self.contentView addSubview:cellImageView];

		cellMaskImageView = [[UIImageView alloc] initWithFrame:TableCellImageSize];
		cellMaskImageView.image = [UIImage imageNamed:CellThumbnailMaskImage];
		cellMaskImageView.backgroundColor = [UIColor clearColor];
        
   }
    return self;
	
}

//Use to do masking of cell image
-(void) DoMaskingOnCellImage
{
	[self.contentView addSubview:cellMaskImageView];
}


+(void) DoMaskingOnSelectedCellImage:(UITableViewCell*)cellFromTVC
{
/*    //UITableViewCell *cell = cellTVC;//[tableView cellForRowAtIndexPath:indexPath];
    cellSelectedMaskImageView = [[UIImageView alloc] initWithFrame:TableCellImageSize];
    cellSelectedMaskImageView.image = [UIImage imageNamed:CellSelectedThumbnailImage];
    cellSelectedMaskImageView.backgroundColor = [UIColor clearColor];
    [cellFromTVC.contentView addSubview:cellSelectedMaskImageView];
    [cellSelectedMaskImageView release];
  */  
}

//Update accessory view for custom image
-(void) EditAccessoryView
{
	self.accessoryType = UITableViewCellAccessoryNone;
	UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CellAccessoryImageSize];
	cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImageCircular];
	cellAccessoryImageView.backgroundColor = [UIColor clearColor];
	self.accessoryView = cellAccessoryImageView;
	[cellAccessoryImageView release];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[cellLable release];
	[cellImageView release];
	[cellMaskImageView release];

    [super dealloc];
}


@end
