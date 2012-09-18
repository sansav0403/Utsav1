//
//  RSByDateDetailScreenViewController.m
//  ResortSuite
//
//  Created by Cybage on 08/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSByDateDetailScreenViewController.h"
#import "RSMIDateScreenCustomCell.h"
#import "RSFolio.h"
#import "customAccesoryButton.h"
#import "RSMIDescViewController.h"  //outdated class
#import "RSMIDescriptionVC.h"
@implementation RSByDateDetailScreenViewController
@synthesize folios;

#define x						10
#define y						5
#define width					100
#define height					20

#define locationLabelCord		CGRectMake(x,y ,width+100,height)

#define headerLabel1Cord		CGRectMake(x,y+(20 * 0),width,height)
#define headerLabel2Cord		CGRectMake(x,y+(20 * 1),width,height)


#define fieldLabel1Cord			CGRectMake(x+100,y+(20 * 0),width+50,height)
#define fieldLabel2Cord			CGRectMake(x+100,y+(20 * 1),width+50,height)


#define headerLabel1CordL		CGRectMake(x,y+(20 * 1),width,height)
#define headerLabel2CordL		CGRectMake(x,y+(20 * 2),width,height)

#define fieldLabel1CordL		CGRectMake(x+100,y+(20 * 1),width+50,height)
#define fieldLabel2CordL		CGRectMake(x+100,y+(20 * 2),width+50,height)


#pragma mark -
#pragma mark Initialization


- (id)initWithArray:(NSMutableArray *)folioArray{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super init];
    if (self) {
        // Custom initialization.
		folios = [[NSArray alloc] initWithArray:folioArray];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = item;
	[item release];
	
	UIImageView *imageViewBackgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	imageViewBackgroud.image = [UIImage imageNamed:Application_BackgroundScreen];
	[self.view addSubview:imageViewBackgroud];
	[imageViewBackgroud release];
	
	UIImageView *imageViewBackgroudOverLay = [[UIImageView alloc] initWithFrame:CGRectMake(0,44, 320, 400)];
	imageViewBackgroudOverLay.image = [UIImage imageNamed:ScreenWhiteOverLay];
	[self.view addSubview:imageViewBackgroudOverLay];
	[imageViewBackgroudOverLay release];
	

	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"formatedStartDate" ascending:YES] ;
	
	sortDescriptors = [NSArray arrayWithObject:sortDescriptor];          
	sortedFolioObjectArray = [[NSArray alloc]initWithArray:[folios sortedArrayUsingDescriptors:sortDescriptors] ];
	
	tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 54, 300, 360) style:UITableViewStylePlain];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[tableView setScrollEnabled:YES];

	tableView.backgroundColor = [UIColor clearColor];
	[tableView setDelegate:self];
	[tableView setDataSource:self];

	tableView.showsHorizontalScrollIndicator = NO;
	tableView.showsVerticalScrollIndicator = YES;
	tableView.bounces = NO;
	[self.view	 addSubview:tableView];
	[tableView release];
	
	[sortDescriptor release];

}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [sortedFolioObjectArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    RSMIDateScreenCustomCell *cell = (RSMIDateScreenCustomCell *)[tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSMIDateScreenCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	customAccesoryButton *dButton = [[customAccesoryButton alloc] initWithFrame:CellAccessoryImageSize];
	[dButton setBackgroundColor:[UIColor clearColor]];
	UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CellAccessoryImageSize ];
	btnImage.image  = [UIImage imageNamed:CellAccessoryImageCircular];
	[dButton addSubview:btnImage];
	[btnImage release];
	
	dButton.path = indexPath;
	[dButton addTarget:self action:@selector(checkThis:) forControlEvents:UIControlEventTouchDown];
	
	[cell setAccessoryView:dButton];	
	
	[self setCellDataForCell:cell ForIndexPath:indexPath];
	[dButton release];
    return cell;
}

-(void)checkThis:(id*)sender{
	customAccesoryButton *btn = (customAccesoryButton *)sender;
	NSIndexPath * indexPath	= btn.path;

    RSMIDescriptionVC *mRSMIDescriptionVC = [[RSMIDescriptionVC alloc]initWithFolio:[sortedFolioObjectArray objectAtIndex:indexPath.row] ];
    [self.navigationController pushViewController:mRSMIDescriptionVC animated:YES];
	[mRSMIDescriptionVC release];

	
}	
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch ([[sortedFolioObjectArray objectAtIndex:indexPath.row]appType]) {
		case Hotel:		
			return 20*2;
		case Spa:		
			return 20*3;
		case Golf:		
			return 20*2;
		case Dining:		
			return 20*2;
		case Transportation:		
			return 20*2;
	}
	return 0;
}


-(void)setCellDataForCell:(RSMIDateScreenCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath
{
	
	switch ([[sortedFolioObjectArray objectAtIndex:indexPath.row]appType]) {
		case Hotel:
		{
			[self resetDataIn:cell];
			HotelFolio *folio = (HotelFolio *)[folios objectAtIndex:indexPath.row];
			

			cell.locationLabel.frame = locationLabelCord;
			

			cell.locationLabel.text = [folio location];

			cell.dotLine.frame = CGRectMake(x,y+(height * 1.5),dot_width,dot_height);
		}
			break;
		case Spa:
		{
			[self resetDataIn:cell];
			SpaFolio *folio = (SpaFolio *)[sortedFolioObjectArray objectAtIndex:indexPath.row];

			cell.headerLable1.frame = headerLabel1Cord;
			cell.headerLable2.frame = headerLabel2Cord;

			cell.fieldLabel1.frame = fieldLabel1Cord;

			
			cell.fieldLabel1.text = [NSString stringWithFormat:@" %@",[folio details]];

			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			 NSDate *detailedDate = [folio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			NSString* startTime = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
			cell.headerLable1.text = startTime;
			
			detailedDate = [folio formatedFinishDate];
			[dateFormat setDateFormat:@"hh:mm a"];	
			
			cell.headerLable2.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];


			cell.dotLine.frame = CGRectMake(x,y+(height * 2.5),dot_width,dot_height);
			[dateFormat release];
		}
			break;
		case Golf:
		{
			[self resetDataIn:cell];
			RSFolio *folio = [sortedFolioObjectArray objectAtIndex:indexPath.row];

			cell.headerLable1.frame = headerLabel1Cord;

			cell.fieldLabel1.frame = fieldLabel1Cord;

			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			cell.fieldLabel1.text = [NSString stringWithFormat:@" %@",[folio details]];
			NSDate *detailedDate = [folio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			
			cell.headerLable1.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];

			cell.dotLine.frame = CGRectMake(x,y+(height * 1.5),dot_width,dot_height);
			[dateFormat release];
		}
			break;
		case Dining:
		{
			[self resetDataIn:cell];
			RSFolio *folio = [sortedFolioObjectArray objectAtIndex:indexPath.row];

			cell.headerLable1.frame = headerLabel1Cord;

			cell.fieldLabel1.frame = fieldLabel1Cord;

			cell.fieldLabel1.text = [NSString stringWithFormat:@" %@",[folio location]];
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [folio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			
			cell.headerLable1.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];

			cell.dotLine.frame = CGRectMake(x,y+(height * 1.5),dot_width,dot_height);
			[dateFormat release];
		}
			break;
		case Transportation:
		{
			[self resetDataIn:cell];
			RSFolio *folio = [sortedFolioObjectArray objectAtIndex:indexPath.row];

			cell.headerLable1.frame = headerLabel1Cord;

			cell.fieldLabel1.frame = fieldLabel1Cord;

			cell.fieldLabel1.text = [NSString stringWithFormat:@" %@",[folio location]];
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [folio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];

			cell.headerLable1.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];

			cell.dotLine.frame = CGRectMake(x,y+(height * 1.5),dot_width,dot_height);
			[dateFormat release];
		}
			break;
		default:
			break;
	}

	
}
-(void) resetDataIn:(RSMIDateScreenCustomCell *)cell
{
	cell.titleLabel.text = @"";
	cell.locationLabel.text = @"";
	
	cell.headerLable1.text = @"";
	cell.headerLable2.text = @"";
	cell.headerLable3.text = @"";
	cell.headerLable4.text = @"";
	cell.headerLable5.text = @"";
	
	cell.fieldLabel1.text = @"";
	cell.fieldLabel2.text = @"";
	cell.fieldLabel3.text = @"";
	cell.fieldLabel4.text = @"";
	cell.fieldLabel5.text = @"";
	
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    RSMIDescriptionVC *mRSMIDescriptionVC = [[RSMIDescriptionVC alloc]initWithFolio:[sortedFolioObjectArray objectAtIndex:indexPath.row] ];
    [self.navigationController pushViewController:mRSMIDescriptionVC animated:YES];
	[mRSMIDescriptionVC release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [folios release];

    if (sortedFolioObjectArray) {
        [sortedFolioObjectArray release];
    }
	[super dealloc];
}


@end

