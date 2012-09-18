    //
//  RSGroupEventDescViewController.m
//  ResortSuite
//
//  Created by Cybage on 10/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGroupEventDescViewController.h"

@implementation RSGroupEventDescViewController
@synthesize event;

-(id)initWithGroupEvent:(GroupEvent *)eventObject
{
	self = [super init];
	if (self) {
		self.event = eventObject;
	}
	return self;
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#define x						10 
#define navOffset				44
#define y						5 + 44
#define width					150
#define height					20

#define headerLabel1Cord		CGRectMake(x,y,width,height)
#define headerLabel2Cord		CGRectMake(x,y+(height * 1),width,height)
#define headerLabel3Cord		CGRectMake(x,y+(height * 2),width,height)
#define headerLabel4Cord		CGRectMake(x,y+(height * 3),width,height)

#define fieldLabel1Cord			CGRectMake(x+80,y,width+50,height)
#define fieldLabel2Cord			CGRectMake(x+80,y+(height * 1),width+50,height)
#define fieldLabel3Cord			CGRectMake(x+80,y+(height * 2),width+50,height)
#define fieldLabel4Cord			CGRectMake(x+80,y+(height * 3),width+50,height)

//#define dot_height				2
#define dot_lineCord			CGRectMake(x,y+(height * 4),300,dot_height)

#define descLabelCord			CGRectMake(x,y+(height * 5),300,40)
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
	
	headerLable1 = [[UILabel alloc]initWithFrame:headerLabel1Cord];
	headerLable2 = [[UILabel alloc]initWithFrame:headerLabel2Cord];
	headerLable3 = [[UILabel alloc]initWithFrame:headerLabel3Cord];
	headerLable4 = [[UILabel alloc]initWithFrame:headerLabel4Cord];
	dotLine = [[UILabel alloc]initWithFrame:dot_lineCord];
	
	headerLable1.backgroundColor = [UIColor clearColor];
	headerLable1.opaque = YES;
	headerLable1.textColor = [UIColor blackColor];
	[headerLable1 setFont:[UIFont boldSystemFontOfSize:12]];
	headerLable1.text =		GroupEventDesc_EventLbl;
	
	headerLable2.backgroundColor = [UIColor clearColor];
	headerLable2.opaque = YES;
	headerLable2.textColor = [UIColor blackColor];
	[headerLable2 setFont:[UIFont boldSystemFontOfSize:12]];
	headerLable2.text =	GroupEventDesc_LocationLbl;
	
	headerLable3.backgroundColor = [UIColor clearColor];
	headerLable3.opaque = YES;
	headerLable3.textColor = [UIColor blackColor];
	[headerLable3 setFont:[UIFont boldSystemFontOfSize:12]];
	headerLable3.text =	GroupEventDesc_DateLbl;
	
	headerLable4.backgroundColor = [UIColor clearColor];
	headerLable4.opaque = YES;
	headerLable4.textColor = [UIColor blackColor];
	[headerLable4 setFont:[UIFont boldSystemFontOfSize:12]];
	headerLable4.text =	GroupEventDesc_TimeLbl;
	
	dotLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]];
	dotLine.opaque = YES;
	
	[self.view addSubview:headerLable1];
	[self.view addSubview:headerLable2];
	[self.view addSubview:headerLable3];
	[self.view addSubview:headerLable4];
	[self.view addSubview:dotLine];
	
	[headerLable1 release];
	[headerLable2 release];
	[headerLable3 release];
	[dotLine release];
	
	//-----------------------------dynamic label-----------------
	fieldLabel1 = [[UILabel alloc]initWithFrame:fieldLabel1Cord];
	fieldLabel2 = [[UILabel alloc]initWithFrame:fieldLabel2Cord];
	fieldLabel3 = [[UILabel alloc]initWithFrame:fieldLabel3Cord];
	fieldLabel4 = [[UILabel alloc]initWithFrame:fieldLabel4Cord];
	
	fieldLabel4.backgroundColor = [UIColor clearColor];
	fieldLabel4.opaque = YES;
	fieldLabel4.textColor = [UIColor blackColor];
	[fieldLabel4 setFont:[UIFont boldSystemFontOfSize:12]];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	NSDate *detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:@"hh:mm a"];
	NSString* startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	
	detailedDate = [event formatedEndTime];
	[dateFormat setDateFormat:@"hh:mm a"];	
	
	fieldLabel4.text = [NSString stringWithFormat:@" %@ - %@",startTime,[dateFormat stringFromDate:detailedDate]];
	
	fieldLabel1.backgroundColor = [UIColor clearColor];
	fieldLabel1.opaque = YES;
	fieldLabel1.textColor = [UIColor blackColor];
	[fieldLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
	fieldLabel1.text = [NSString stringWithFormat:@" %@",event.eventName];

	
	fieldLabel2.backgroundColor = [UIColor clearColor];
	fieldLabel2.opaque = YES;
	fieldLabel2.textColor = [UIColor blackColor];
	[fieldLabel2 setFont:[UIFont boldSystemFontOfSize:12]];
	
	if (event.location == NULL) {
		fieldLabel2.text =	[NSString stringWithFormat:@" "];
	}
	else {
		fieldLabel2.text = [NSString stringWithFormat:@" %@",event.location];
	}

	
	fieldLabel3.backgroundColor = [UIColor clearColor];
	fieldLabel3.opaque = YES;
	fieldLabel3.textColor = [UIColor blackColor];
	[fieldLabel3 setFont:[UIFont boldSystemFontOfSize:12]];
	
	detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:@"EEEE, MMMM d, yyyy"];
	startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	fieldLabel3.text = [NSString stringWithFormat:@" %@",startTime];
	[dateFormat release];
	
	[self.view addSubview:fieldLabel1];
	[self.view addSubview:fieldLabel2];
	[self.view addSubview:fieldLabel3];
	[self.view addSubview:fieldLabel4];
	
	[fieldLabel1 release];
	[fieldLabel2 release];
	[fieldLabel3 release];

	//-----------text for the description------------------------------------
	
	descLabel = [[UILabel alloc]initWithFrame:descLabelCord];
	
	descLabel.backgroundColor = [UIColor clearColor];
	descLabel.opaque = YES;
	descLabel.textColor = [UIColor blackColor];
	[descLabel setFont:[UIFont boldSystemFontOfSize:12]];

	descLabel.numberOfLines = 3;
	
	[descLabel textRectForBounds:descLabelCord limitedToNumberOfLines:0];
	
	descLabel.text = [NSString stringWithFormat:@"%@",event.eventDesc];	

	[self.view addSubview:descLabel];
	[descLabel release];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.navigationItem.backBarButtonItem.title = BackButtonTitle;
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


- (void)dealloc {
    [event release];
	[super dealloc];
	
}


@end
