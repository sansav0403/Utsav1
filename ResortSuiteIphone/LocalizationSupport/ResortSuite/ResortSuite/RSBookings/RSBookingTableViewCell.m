    //
//  RSBookingTableViewCell.m
//  ResortSuite
//
//  Created by Cybage on 28/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSBookingTableViewCell.h"

#define CELL_FONT_SIZE               13

@implementation RSBookingTableViewCell

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
		
		//Create a lable to display the content in the cell
        self.textLabel.backgroundColor = [UIColor clearColor];
		self.textLabel.font = [UIFont boldSystemFontOfSize:CELL_FONT_SIZE];
        self.textLabel.highlightedTextColor = [UIColor blackColor];
        
		self.detailTextLabel.textColor = [UIColor blackColor];
		self.detailTextLabel.highlightedTextColor = [UIColor blackColor];
		self.detailTextLabel.font = [UIFont systemFontOfSize:CELL_FONT_SIZE];
	}	
	return self;
}

//Insert custom Accessory View
-(void) setAccessoryViewImage:(BOOL) isAccessoryImage
{
	self.accessoryType = UITableViewCellAccessoryNone;
	UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 15)];
	if(isAccessoryImage)
	{
		cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImage];
	}
	else {
		cellAccessoryImageView.image = [UIImage imageNamed:accessoryBlankImage];
	}
	cellAccessoryImageView.backgroundColor = [UIColor clearColor];
	self.accessoryView = cellAccessoryImageView;
	[cellAccessoryImageView release];
}


- (void) setBgForSelectedCell:(UITableView *) tableView forIndex:(NSIndexPath *) indexPath
{
	//Image setting for selected tableviewcell		
	UIImageView *selectionBackground = [[UIImageView alloc] init];
	NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	
	if (row == 0 && row == sectionRows - 1)
	{
		selectionBackground.image = [UIImage imageNamed:option_arrow_image];
	}
	else if (row == 0)
	{
		selectionBackground.image = [UIImage imageNamed:top_arrow_image];
	}
	else if (row == sectionRows - 1)
	{
		selectionBackground.image = [UIImage imageNamed:bottom_arrow_image];
	}
	else
	{
		selectionBackground.image = [UIImage imageNamed:mid_arrow_image];
	}
	
	self.selectedBackgroundView = selectionBackground;
	[selectionBackground release];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {

    [super dealloc];
}


@end
