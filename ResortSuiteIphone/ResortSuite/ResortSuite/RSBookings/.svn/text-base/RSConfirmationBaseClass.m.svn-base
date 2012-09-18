//
//  RSConfirmationBaseClass.m
//  ResortSuite
//
//  Created by Cybage on 9/20/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSConfirmationBaseClass.h"

#define CharWidth 5

@implementation RSConfirmationBaseClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    
    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, sepratorImageYcord, Screen_Width, scrollViewHeight)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    label2Y_cord = 5;      //releative to new scroll view
    valForClassOrService = 0; // DEFAULT VALUE

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - label cofigaration functions

-(CGFloat) calculateWidthForlabel:(NSString *)comments forFontSize:(float)fontsize
{
    int stringlenght = [comments length];
    float ReqCGWidth = stringlenght * CharWidth;         //pixel width of each char for 

    
    CGSize sizetest = [comments sizeWithFont:[UIFont systemFontOfSize:fontsize] forWidth:ReqCGWidth lineBreakMode:UILineBreakModeCharacterWrap];
    
    return sizetest.width;
}

-(int)calculateNoOfLinesForLineWidth:(CGFloat)lineWidth forLabelWidth:(float)labelWidth
{
	//assuming the label width to be 130
    int numLines = 1;
	if(lineWidth/RSCBDynamicLabelWidth > numLines) 
	{
        numLines = ceilf(lineWidth/RSCBDynamicLabelWidth);
	}
    return numLines;
}

-(CGFloat)calculateNextY_CordFromPreviousY_cord:(float)y_cord andNumOfLine:(int)noOfLine
{
	return y_cord + ((noOfLine) * LabelCord_height);
}

-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue
{
	for (int titleIndex = 0; titleIndex < [tagsTitle count]; titleIndex++)
	{
		UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectZero]; //
		UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectZero];
		
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor blackColor];
        
		[label1 setFont:[UIFont boldSystemFontOfSize:RSCBDynamicLabelFont]];
		
		if ([tagsTitle objectAtIndex:titleIndex] != nil)
		{
			[label1 setText:[tagsTitle objectAtIndex:titleIndex]];
			
			if (titleIndex == 0) {
                //Label1Cord_y dont need to use it as now we are addin them to scrool view
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);	
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
                ///-----
                if (valForClassOrService == 1) {        //for spa Service   valForClassOrService = 0 by default
                    if (titleIndex == 4) {
                        label1.textColor = [UIColor redColor];
                        
                        label1.numberOfLines = 2;
                        label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*2);
                    }
                }
                else if(valForClassOrService == 2) {    //for class
                    if (titleIndex == 6) {
                        label1.textColor = [UIColor redColor];
                        
                        label1.numberOfLines = 2;
                        label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*2);
                    }
                }
                ///-----
			}
			
		}
		else 
		{
			[label1 setText:DataNotAvailable];
			if (titleIndex == 0) {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
			}
			
		}
		// work for dynamic label--- label2
		label2.backgroundColor = [UIColor clearColor];
		label2.opaque = YES;
		label2.textColor = [UIColor blackColor];
        ///-----
        if (valForClassOrService == 1) {        //for spa Service
            if (titleIndex == 4) {
                label2.textColor = [UIColor redColor];
            }
        }
        else if(valForClassOrService == 2) {    //for class
            if (titleIndex == 6) {
                label2.textColor = [UIColor redColor];                
            }
        }
        ///-----
		[label2 setFont:[UIFont systemFontOfSize:RSCBDynamicLabelFont]];
		
		if (titleIndex < [tagsValue count] && [tagsValue objectAtIndex:titleIndex] != nil)
		{

            int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:[tagsValue objectAtIndex:titleIndex]forFontSize:RSCBDynamicLabelFont] forLabelWidth:RSCBDynamicLabelWidth];
			
            label2.lineBreakMode = UILineBreakModeWordWrap;
            label2.numberOfLines = 0;

			if (titleIndex == 0) {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord, label2Y_cord, RSCBDynamicLabelWidth, LabelCord_height*numOfLine);
				
			}
			else {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), RSCBDynamicLabelWidth, LabelCord_height*numOfLine);
                
			}
			
            [label2 setText:[tagsValue objectAtIndex:titleIndex]];
            
            //set the next y cord
            label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
		}
		else 
		{
            
            int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:DataNotAvailable forFontSize:RSCBDynamicLabelFont] forLabelWidth:RSCBDynamicLabelWidth];
            
			if (titleIndex == 0) {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord, label2Y_cord, RSCBDynamicLabelWidth, LabelCord_height*numOfLine);
				
			}
			else {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), RSCBDynamicLabelWidth, LabelCord_height*numOfLine);
                
			}
            [label2 setText:DataNotAvailable];
            //set the next y cord
            label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			
		}
		
		[scrollView addSubview:label1];
		[scrollView addSubview:label2];		
        
        if (label2Y_cord > 200) {       //new set up to enable scrolling
            [scrollView setContentSize:CGSizeMake(Screen_Width, label2Y_cord+50)];
        }
		
		[label1 release];
		[label2	 release];
		
	}
}
#pragma mark - draw header level

-(void) createTitleHeader:(NSString*)headerTitle yPosition:(float)yCoordinate
{
    
	UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, yCoordinate, titleLabelCord_width, titleLabelCord_height)];
	tLabel.backgroundColor = [UIColor whiteColor];
	tLabel.opaque = YES;
	tLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[tLabel setFont:[UIFont boldSystemFontOfSize:RSCBCTiltleLabelFont]];
	[tLabel setText:[NSString stringWithFormat:@"    %@", headerTitle]];
	[self.view addSubview:tLabel];
	[tLabel release];
	
}

-(void)drawSeperatorImageAtYCord:(float)ycord 
{
	UIImageView *seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - dot_width)/2,  ycord, dot_width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[self.view addSubview:seperatorImage];
	[seperatorImage release];
}

-(void) createMessage:(NSString *)messageString yPostion:(float)yCoordinate
{
    
    int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:messageString forFontSize:RSCBCMessageLabelFont]forLabelWidth:RSCBCMessageLabelWidth];
    
    UILabel *MLabel = [[UILabel alloc]initWithFrame:CGRectMake(RSCBCMessageXcord, yCoordinate, RSCBCMessageLabelWidth, RSCBCMessageLabelhieght * numOfLine)];
    
	MLabel.backgroundColor = [UIColor clearColor];
	MLabel.opaque = YES;
	MLabel.textColor = [UIColor blackColor];
    MLabel.lineBreakMode = UILineBreakModeWordWrap;
    MLabel.numberOfLines = 0;
	[MLabel setFont:[UIFont boldSystemFontOfSize:RSCBCMessageLabelFont]];
	[MLabel setText:[NSString stringWithFormat:@"%@", messageString]];
	[scrollView addSubview:MLabel];
	[MLabel release];
    
    label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:yCoordinate andNumOfLine:numOfLine];
}

#pragma mark - date functions
-(NSString *)stringFromDate:(NSDate *)date                  //date without time value
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    NSString * dateStr = [dateFormat stringFromDate:date];  
    [dateFormat release];
    return dateStr;
}

-(NSString *)timeStringFromDate:(NSDate *)date                  //date without time value
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString * dateStr = [dateFormat stringFromDate:date];  
    [dateFormat release];
    return dateStr;
}
@end
