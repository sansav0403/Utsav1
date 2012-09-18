    //
//  RSMGByCategoryDetailScreenView.m
//  ResortSuite
//
//  Created by Cybage on 13/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMGByCategoryDetailScreenView.h"


@implementation RSMGByCategoryDetailScreenView
@synthesize GroupEvents;


- (id)initWithArray:(NSMutableArray *)GroupEventsArray
{
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super init];
    if (self) {
        // Custom initialization.
		self.GroupEvents = GroupEventsArray;
    }
    return self;
	
}

- (void)dealloc {
    [super dealloc];
	[GroupEvents release];
	[dateDictionary release];
	[sortedDateKeyArray release];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
	
	//soting the GroupEvents by time...
	
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"formatedStartTime" ascending:YES] ;
	
	sortDescriptors = [NSArray arrayWithObject:sortDescriptor];       //autorelease   
	sortedGroupEventObjectArray = [[NSArray alloc]initWithArray:[GroupEvents sortedArrayUsingDescriptors:sortDescriptors] ];
	
	//create a dictionry by date(day)
	dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	dateDictionary = [[NSMutableDictionary alloc]init];
	for(int objectIndex=0; objectIndex<[sortedGroupEventObjectArray count]; objectIndex++)
	{
		NSArray *lkeyArray = [dateDictionary allKeys];
		GroupEvent *groupEvent = [sortedGroupEventObjectArray objectAtIndex:objectIndex];//get the obj at index
		NSDate *keyDate = [self stringToDate:[self stringFromDate:[groupEvent formatedStartTime]]];	//to act as akey get only the date
	
		if ([lkeyArray containsObject:keyDate])
		{
			NSMutableArray *localEventArray = [dateDictionary objectForKey:keyDate];
			[localEventArray addObject:groupEvent];
			[dateDictionary setObject:localEventArray forKey:keyDate];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
			[dateDictionary setObject:localEventArray forKey:keyDate];
			[localEventArray release];
			[dateKeyArray addObject:keyDate];
		}
		
		
	}
	[sortedGroupEventObjectArray release];
	
	//sorting the key by date
	sortedDateKeyArray = [[NSArray alloc]initWithArray:[dateKeyArray sortedArrayUsingSelector:@selector(compare:)]];//check
	[dateKeyArray release];
	
	tableView = [[UITableView alloc]initWithFrame:Itinerary_TableSize style:UITableViewStylePlain];
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
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;	
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sortedDateKeyArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	NSDate *detailedDate = [sortedDateKeyArray objectAtIndex:section];
	[dateFormat setDateFormat:@"EEEE, MMMM d, yyyy"];
	
	UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 2, 240, 18)];
	sectionLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	sectionLabel.font = [UIFont boldSystemFontOfSize:FontSize_Date];
	sectionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	sectionLabel.backgroundColor = [UIColor clearColor];
	
	[dateFormat release];
	
	UIView * sectionHeaderView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)]autorelease];
	sectionHeaderView.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:DetailPageSectionBG]];
	[sectionHeaderView addSubview:sectionLabel];
	[sectionLabel release];
	return sectionHeaderView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:section]] count];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    RSMGByDateCustomCell *cell = (RSMGByDateCustomCell *)[tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSMGByDateCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	customAccesoryButton *dButton = [[customAccesoryButton alloc] initWithFrame:CellAccessoryImageSize];
	[dButton setBackgroundColor:[UIColor clearColor]];
	UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CellAccessoryImageSize];
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

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	RSGroupEventDescViewController *mRSGroupEventDescViewController = [[RSGroupEventDescViewController alloc]
                    initWithGroupEvent:
                    [[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]  ];
	[self.navigationController pushViewController:mRSGroupEventDescViewController animated:YES];
	mRSGroupEventDescViewController.navigationItem.title = GroupEventDesc_viewTitle;
	[mRSGroupEventDescViewController release];
	
}


-(void)checkThis:(id*)sender{
	customAccesoryButton *btn = (customAccesoryButton *)sender;
	NSIndexPath * indexPath	= btn.path;
	
	RSGroupEventDescViewController *mRSGroupEventDescViewController = [[RSGroupEventDescViewController alloc]
                        initWithGroupEvent:
                        [[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]  ];
	[self.navigationController pushViewController:mRSGroupEventDescViewController animated:YES];
	mRSGroupEventDescViewController.navigationItem.title = GroupEventDesc_viewTitle;
	[mRSGroupEventDescViewController release];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 20 * 3;
}

#define x						10
#define y						5
#define width					150
#define height					20

#define headerLabel1Cord		CGRectMake(x,y,width,height)
#define headerLabel2Cord		CGRectMake(x,y+(20 * 1),width,height)
#define headerLabel3Cord		CGRectMake(x,y+(20 * 2),width,height)

#define fieldLabel1Cord			CGRectMake(x+80,y,width,height)
#define fieldLabel2Cord			CGRectMake(x+80,y+(20 * 1),width,height)
#define fieldLabel3Cord			CGRectMake(x+80,y+(20 * 2),width,height)

//#define dot_height				2

#pragma mark setting celldata
-(void)setCellDataForCell:(RSMGByDateCustomCell *)cell ForIndexPath:(NSIndexPath *)indexPath
{
	[self resetDataIn:cell];
	
	GroupEvent *event = (GroupEvent *)[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	
	cell.headerLable1.frame = headerLabel1Cord;
	cell.headerLable2.frame = headerLabel2Cord;
	cell.headerLable3.frame = headerLabel3Cord;
	
	cell.fieldLabel1.frame = fieldLabel1Cord;

	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	NSDate *detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:@"hh:mm a"];
	NSString* startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	
	cell.headerLable1.text = [NSString stringWithFormat:@" %@",startTime];
	
	detailedDate = [event formatedEndTime];
	[dateFormat setDateFormat:@"hh:mm a"];	

	cell.headerLable2.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
	cell.fieldLabel1.text = [NSString stringWithFormat:@" %@ ",[event eventName]];
	
	cell.dotLine.frame = CGRectMake(x,y+(height * 2),dot_width,dot_height);
	[dateFormat release];
	
}
-(void) resetDataIn:(RSMGByDateCustomCell *)cell
{
	cell.headerLable1.text = @"";
	cell.headerLable2.text = @"";
	cell.headerLable3.text = @"";
	
	cell.fieldLabel1.text = @"";
	cell.fieldLabel1.text = @"";
	cell.fieldLabel1.text = @"";
	
}

#pragma mark date Functions
-(NSString *)stringFromDate:(NSDate *)date
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];
	return [dateFormatter stringFromDate:date];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];	
	[dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy"];  

	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	
	return date;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
