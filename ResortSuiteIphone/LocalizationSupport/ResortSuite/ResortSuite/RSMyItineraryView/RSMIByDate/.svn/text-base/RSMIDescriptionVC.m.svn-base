//
//  RSMIDescriptionVC.m
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMIDescriptionVC.h"

@implementation RSMIDescriptionVC
@synthesize folio;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithFolio:(RSFolio *)rsFolio
{
	self = [super init];
	if(self)
	{
		self.folio = rsFolio;
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*change the scrollview frame for desc screen*/
    scrollView.frame = CGRectMake(0, sepratorImageYcord, Screen_Width, scrollViewHeight+40);
    valForClassOrService = 2; //client instruction is at 6th index for labels
    //----------------------------------------
    switch ([folio appType]) {
		case Hotel:
		{
			self.title = Hotel_Itinerary_Title;
            [self createTitleHeader:Hotel_Itinerary_Title yPosition:TitleHeaderYcord];
			[self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
            
            HotelFolio *hfolio = (HotelFolio *)folio;
            
            NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:Hotel_Reservation,Hotel_Arival_Date,Hotel_Departure_Date,Hotel_Total_Guest,Hotel_Room_Number, nil]autorelease];

            
            NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                           [NSString stringWithFormat:@" %d",[hfolio appFolioId]],
                                           [NSString stringWithFormat:@" %@",[hfolio startDate]],
                                           [NSString stringWithFormat:@" %@",[hfolio finishDate]],
                                           [NSString stringWithFormat:@" %d",[hfolio totalGuests]],
                                           [NSString stringWithFormat:@" %@",[hfolio roomNumber]],
                                           nil
                                           ] autorelease];
			
			[self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];

		}
			break;
		case Spa:
		{
			self.title = Hotel_SPA_Title;
            [self createTitleHeader:Hotel_SPA_Title yPosition:TitleHeaderYcord];
			[self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
            SpaFolio *lfolio = (SpaFolio *)folio;


            NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:Spa_Location,Spa_Service,Spa_Time,Spa_Performed_By, Spa_Room,Spa_Description, Spa_Client_instruction, nil]autorelease];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
			NSString* startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
            
            detailedDate = [lfolio formatedFinishDate];
			[dateFormat setDateFormat:@"hh:mm a"];
            
            NSMutableString *descString = [NSMutableString stringWithFormat:@"%@",lfolio.spaDescription];
            DLog(@"lfolio.spaDescription] ----------= %@",lfolio.spaDescription);
            if ([descString isEqualToString:@""])
            {
                [descString setString:DataNotAvailable];
            }
            
            NSMutableString *instructionString = [NSMutableString stringWithFormat:@"%@",lfolio.clientInstruction];
            

//get the desc and instruction
            //
            NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                           [NSString stringWithFormat:@" %@",[lfolio location]],
                                           [NSString stringWithFormat:@" %@",[lfolio details]],
                                           [NSString stringWithFormat:@" %@ - %@",startTime,[dateFormat stringFromDate:detailedDate]],
                                           [NSString stringWithFormat:@" %@",[lfolio staff]],
                                           [NSString stringWithFormat:@" %@",[lfolio room]],
                                           descString,
                                           instructionString,
                                           nil
                                           ] autorelease];
            //remove client instruction label if instruction not present
            if ([instructionString isEqualToString:@""])
            {
                [DynamicLabelTexts removeObjectAtIndex:6];
                [staticLabelTexts removeObjectAtIndex:6];
            }
			
            [dateFormat release];
			[self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
			//-------------

		}
			break;
		case Golf:
		{
			self.title = Hotel_GOLF_Title;
            [self createTitleHeader:Hotel_GOLF_Title yPosition:TitleHeaderYcord];
			[self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
            RSFolio *lfolio = folio;

            NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:Golf_Course,Golf_Tee_Time, nil]autorelease];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            NSDate *detailedDate = [lfolio formatedStartDate];
            [dateFormat setDateFormat:@"hh:mm a"];

            //get the desc and instruction
            //
            NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                           [NSString stringWithFormat:@" %@",[lfolio details]],
                                           [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]],                   nil
                                           ] autorelease];
			
            [dateFormat release];
			[self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
            //-------------------------
		}
			break;
		case Dining:
		{
			self.title = Hotel_Dining_Title;
            [self createTitleHeader:Hotel_Dining_Title yPosition:TitleHeaderYcord];
			[self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
            RSFolio *lfolio = folio;
            
            NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:Dining_Venue,Dining_Time,Dining_detail, nil]autorelease];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            NSDate *detailedDate = [lfolio formatedStartDate];
            [dateFormat setDateFormat:@"hh:mm a"];
            
            //get the desc and instruction
            //
            NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                           [NSString stringWithFormat:@" %@",[lfolio location]],
                                           [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]],
                                           [NSString stringWithFormat:@" %@",[lfolio details]],
                                           nil
                                           ] autorelease];
			
            [dateFormat release];
			[self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
            //-------------------------
		}
			break;
		case Transportation:
		{
			self.title = Hotel_Transportation_Title;
            [self createTitleHeader:Hotel_Transportation_Title yPosition:TitleHeaderYcord];
			[self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
            RSFolio *lfolio = folio;
            
            NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:Transportation_Departure_location,Transportation_Departure_Time,Transportation_Arrival_Location,Transportation_Arrival_Time, nil]autorelease];
            
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			NSDate *detailedDate = [lfolio formatedStartDate];
			[dateFormat setDateFormat:@"hh:mm a"];
            
            NSDate * detailedDate1 = [lfolio formatedFinishDate];
			[dateFormat setDateFormat:@"hh:mm a"];
            //get the desc and instruction
            //
            NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                           [NSString stringWithFormat:@" %@",[lfolio location]],
                                           [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]],
                                           [NSString stringWithFormat:@" %@",[lfolio details]],
                                           [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate1]],                                           
                                           nil
                                           ] autorelease];
			
            [dateFormat release];
			[self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
            //-------------------------
		}
			break;
		default:
			break;
	}
	
	
}

    //----------------------------------------



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
