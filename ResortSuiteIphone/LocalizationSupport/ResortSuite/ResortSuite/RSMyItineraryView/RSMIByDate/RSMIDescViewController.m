    //
//  RSMIDescViewController.m
//  ResortSuite
//
//  Created by Cybage on 15/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMIDescViewController.h"


@implementation RSMIDescViewController
@synthesize folio;

-(id)initWithFolio:(RSFolio *)rsFolio
{
	self = [super init];
	if(self)
	{
		self.folio = rsFolio;
	}
	return self;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
#define x						10
#define y						45
#define width					100
#define height					20

#define titleLabelCord			CGRectMake(x,y,width,height)
#define locationLabelCord		CGRectMake(x,y ,width+100,height)

#define headerLabel1Cord		CGRectMake(x,y+(20 * 1),width+50,height)
#define headerLabel2Cord		CGRectMake(x,y+(20 * 2),width+50,height)

#define headerLabel3Cord		CGRectMake(x,y+(20 * 3),width+50,height)
#define headerLabel4Cord		CGRectMake(x,y+(20 * 4),width+50,height)
#define headerLabel5Cord		CGRectMake(x,y+(20 * 5),width+50,height)

#define fieldLabel1Cord			CGRectMake(x+120,y+(20 * 1),width+100,height)
#define fieldLabel2Cord			CGRectMake(x+120,y+(20 * 2),width+100,height)

#define fieldLabel3Cord			CGRectMake(x+120,y+(20 * 3),width+50,height)
#define fieldLabel4Cord			CGRectMake(x+120,y+(20 * 4),width+50,height)
#define fieldLabel5Cord			CGRectMake(x+120,y+(20 * 5),width+50,height)

#define headerLabel1CordL		CGRectMake(x,y+(20 * 2),width+50,height)
#define headerLabel2CordL		CGRectMake(x,y+(20 * 3),width+50,height)
#define headerLabel3CordL		CGRectMake(x,y+(20 * 4),width+50,height)
#define headerLabel4CordL		CGRectMake(x,y+(20 * 5),width+50,height)
#define headerLabel5CordL		CGRectMake(x,y+(20 * 6),width+50,height)

#define fieldLabel1CordL		CGRectMake(x+120,y+(20 * 2),width+100,height)
#define fieldLabel2CordL		CGRectMake(x+120,y+(20 * 3),width+100,height)
#define fieldLabel3CordL		CGRectMake(x+120,y+(20 * 4),width+100,height)
#define fieldLabel4CordL		CGRectMake(x+120,y+(20 * 5),width+100,height)
#define fieldLabel5CordL		CGRectMake(x+120,y+(20 * 6),width+100,height)

//#define dot_height				2
/****************************************************************/


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationItem.backBarButtonItem.title = BackButtonTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];

	UIImageView *imageViewBackgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	imageViewBackgroud.image = [UIImage imageNamed:Application_BackgroundScreen];
	[self.view addSubview:imageViewBackgroud];
	[imageViewBackgroud release];

	UIImageView *imageViewBackgroudOverLay = [[UIImageView alloc] initWithFrame:CGRectMake(0,44, 320, 400)];
	imageViewBackgroudOverLay.image = [UIImage imageNamed:ScreenWhiteOverLay];
	[self.view addSubview:imageViewBackgroudOverLay];
	[imageViewBackgroudOverLay release];
	
	locationLabel = [[UILabel alloc]initWithFrame:CGRectZero];
	fieldLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
	fieldLabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
	fieldLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
	fieldLabel4 = [[UILabel alloc]initWithFrame:CGRectZero];
	fieldLabel5 = [[UILabel alloc]initWithFrame:CGRectZero];
	
	headerLable1 = [[UILabel alloc]initWithFrame:CGRectZero];
	headerLable2 = [[UILabel alloc]initWithFrame:CGRectZero];
	headerLable3 = [[UILabel alloc]initWithFrame:CGRectZero];
	headerLable4 = [[UILabel alloc]initWithFrame:CGRectZero];
	headerLable5 = [[UILabel alloc]initWithFrame:CGRectZero];
	dotLine = [[UILabel alloc]initWithFrame:CGRectZero];
	
	locationLabel.backgroundColor = [UIColor clearColor];
	locationLabel.opaque = YES;
	locationLabel.textColor = [UIColor blackColor];
	[locationLabel setFont:[UIFont boldSystemFontOfSize:14]];
	
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
/////////////////////////////////////	
	fieldLabel1.backgroundColor = [UIColor clearColor];
	fieldLabel1.opaque = YES;
	fieldLabel1.textColor = [UIColor blackColor];
	[fieldLabel1 setFont:[UIFont systemFontOfSize:12]];
	
	fieldLabel2.backgroundColor = [UIColor clearColor];
	fieldLabel2.opaque = YES;
	fieldLabel2.textColor = [UIColor blackColor];
	[fieldLabel2 setFont:[UIFont systemFontOfSize:12]];
	
	fieldLabel3.backgroundColor = [UIColor clearColor];
	fieldLabel3.opaque = YES;
	fieldLabel3.textColor = [UIColor blackColor];
	[fieldLabel3 setFont:[UIFont systemFontOfSize:12]];
	
	fieldLabel4.backgroundColor = [UIColor clearColor];
	fieldLabel4.opaque = YES;
	fieldLabel4.textColor = [UIColor blackColor];
	[fieldLabel4 setFont:[UIFont systemFontOfSize:12]];
	
	fieldLabel5.backgroundColor = [UIColor clearColor];
	fieldLabel5.opaque = YES;
	fieldLabel5.textColor = [UIColor blackColor];
	[fieldLabel5 setFont:[UIFont systemFontOfSize:12]];
	
	dotLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]];
	dotLine.opaque = YES;

	[self.view addSubview:locationLabel];
	
	[self.view addSubview:fieldLabel1];
	[self.view addSubview:fieldLabel2];
	[self.view addSubview:fieldLabel3];
	[self.view addSubview:fieldLabel4];
	[self.view addSubview:fieldLabel5];
	
	[self.view addSubview:headerLable1];
	[self.view addSubview:headerLable2];
	[self.view addSubview:headerLable3];
	[self.view addSubview:headerLable4];
	[self.view addSubview:headerLable5];
	
	[self.view addSubview:dotLine];
	
	[locationLabel release];
	[fieldLabel1 release];
	[fieldLabel2 release];
	[fieldLabel3 release];
	[fieldLabel4 release];
	[fieldLabel5 release];
	
	[headerLable1 release];
	[headerLable2 release];
	[headerLable3 release];
	[headerLable4 release];
	[headerLable5 release];
	[dotLine release];
	

	switch ([folio appType]) {
		case Hotel:
		{
			self.title = Hotel_Itinerary_Title;
			HotelFolio *hfolio = (HotelFolio *)folio;
			
			
			locationLabel.frame = locationLabelCord;
			
			
			locationLabel.text = [hfolio location];
			
			headerLable1.frame = headerLabel1CordL;
			headerLable2.frame = headerLabel2CordL;
			headerLable3.frame = headerLabel3CordL;
			headerLable4.frame = headerLabel4CordL;
			headerLable5.frame = headerLabel5CordL;
			

            
			headerLable1.text = Hotel_Reservation;
			headerLable2.text = Hotel_Arival_Date;
			headerLable3.text = Hotel_Departure_Date;
			headerLable4.text = Hotel_Total_Guest;
			headerLable5.text = Hotel_Room_Number;
			
			
			fieldLabel1.frame = fieldLabel1CordL;
			fieldLabel2.frame = fieldLabel2CordL;
			fieldLabel3.frame = fieldLabel3CordL;
			fieldLabel4.frame = fieldLabel4CordL;
			fieldLabel5.frame = fieldLabel5CordL;
			
			fieldLabel1.text = [NSString stringWithFormat:@" %d",[hfolio appFolioId]]; 
			fieldLabel2.text = [NSString stringWithFormat:@" %@",[hfolio startDate]];
			fieldLabel3.text = [NSString stringWithFormat:@" %@",[hfolio finishDate]];
			fieldLabel4.text = [NSString stringWithFormat:@" %d",[hfolio totalGuests]];;
			fieldLabel5.text = [NSString stringWithFormat:@" %@",[hfolio roomNumber]];
					
			
			//cell.textLabel.text = @"Hotel";
			dotLine.frame = CGRectMake(x,y+(height * 7),300,dot_height);
		}
			break;
		case Spa:
		{
			self.title = Hotel_SPA_Title;
			SpaFolio *lfolio = (SpaFolio *)folio;
        

			
			headerLable1.frame = headerLabel1Cord;
			headerLable2.frame = headerLabel2Cord;
			headerLable3.frame = headerLabel3Cord;
			headerLable4.frame = headerLabel4Cord;
			headerLable5.frame = headerLabel5Cord;

            
			headerLable1.text = Spa_Location;
			headerLable2.text = Spa_Service;
			headerLable3.text = Spa_Time;
			headerLable4.text = Spa_Performed_By;
			headerLable5.text = Spa_Room;
			
			fieldLabel1.frame = fieldLabel1Cord;
			fieldLabel2.frame = fieldLabel2Cord;
			fieldLabel3.frame = fieldLabel3Cord;
			fieldLabel4.frame = fieldLabel4Cord;
			fieldLabel5.frame = fieldLabel5Cord;
			
			fieldLabel1.text = [NSString stringWithFormat:@" %@",[lfolio location]];
			fieldLabel2.text = [NSString stringWithFormat:@" %@",[lfolio details]];
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			NSString* startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
			
			detailedDate = [lfolio formatedFinishDate];
			[dateFormat setDateFormat:@"hh:mm a"];	
			
			fieldLabel3.text = [NSString stringWithFormat:@" %@ - %@",startTime,[dateFormat stringFromDate:detailedDate]];
			fieldLabel4.text = [NSString stringWithFormat:@" %@",[lfolio staff]];
			fieldLabel5.text = [NSString stringWithFormat:@" %@",[lfolio room]];
			
			dotLine.frame = CGRectMake(x,y+(height * 6),300,dot_height);
			[dateFormat release];
		}
			break;
		case Golf:
		{
			self.title = Hotel_GOLF_Title;
			RSFolio *lfolio = folio;
			

			
			headerLable1.frame = headerLabel1Cord;
			headerLable2.frame = headerLabel2Cord;
			
			headerLable1.text = Golf_Course;
			headerLable2.text = Golf_Tee_Time;
			
			fieldLabel1.frame = fieldLabel1Cord;
			fieldLabel2.frame = fieldLabel2Cord;
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			fieldLabel1.text = [NSString stringWithFormat:@" %@",[lfolio details]];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			
			fieldLabel2.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
			
			dotLine.frame = CGRectMake(x,y+(height * 3),300,dot_height);
			[dateFormat release];
		}
			break;
		case Dining:
		{
			self.title = Hotel_Dining_Title;
			RSFolio *lfolio = folio;
			
			
			headerLable1.frame = headerLabel1Cord;
			headerLable2.frame = headerLabel2Cord;
			headerLable3.frame = headerLabel3Cord;

			headerLable1.text = Dining_Venue;
			headerLable2.text = Dining_Time;
            
			headerLable3.text = [NSString stringWithFormat:@" %@",[lfolio details]];
			
			fieldLabel1.frame = fieldLabel1Cord;
			fieldLabel2.frame = fieldLabel2Cord;

			fieldLabel1.text = [NSString stringWithFormat:@" %@",[lfolio location]];
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			
			fieldLabel2.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];

			dotLine.frame = CGRectMake(x,y+(height * 4),300,dot_height);
			[dateFormat release];
		}
			break;
		case Transportation:
		{
			self.title = Hotel_Transportation_Title;

			RSFolio *lfolio = folio;
			

			
			headerLable1.frame = headerLabel1Cord;
			headerLable2.frame = headerLabel2Cord;
			headerLable3.frame = headerLabel3Cord;
			headerLable4.frame = headerLabel4Cord;
            

			headerLable1.text = Transportation_Departure_location;
			headerLable2.text = Transportation_Departure_Time;
			headerLable3.text = Transportation_Arrival_Location;
			headerLable4.text = Transportation_Arrival_Time;
			
			fieldLabel1.frame = fieldLabel1Cord;
			fieldLabel2.frame = fieldLabel2Cord;
			fieldLabel3.frame = fieldLabel3Cord;
			fieldLabel4.frame = fieldLabel4Cord;
			
			
			fieldLabel1.text = [NSString stringWithFormat:@" %@",[lfolio location]];
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			fieldLabel2.text  = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
			
			detailedDate = [lfolio formatedFinishDate];
			[dateFormat setDateFormat:@"hh:mm a"];	
			
			fieldLabel4.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
			
			fieldLabel3.text = [NSString stringWithFormat:@" %@",[lfolio details]];
			
			dotLine.frame = CGRectMake(x,y+(height * 5),300,dot_height);
			[dateFormat release];
		}
			break;
		default:
			break;
	}
	
	
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
	[folio release];
    [super dealloc];
}


@end
