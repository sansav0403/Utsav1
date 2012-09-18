//
//  RSMainScreenButton.m
//  ResortSuite
//
//  Created by Cybage on 7/19/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSMainScreenButton.h"


@implementation RSMainScreenButton

enum MainScreenButtonIcon
{
	FirstButton,
	
	#if !defined CLUB_VERSION_TWO_MYACCOUNT
		SecondButton,
	#endif
	
	#if !defined (HOTEL_VERSION_TWO_BUTTONS)
		ThirdButton
	#endif
};

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}

-(void) setButtonsLabels:(NSString*)text frame:(CGRect)framePosition fontSize:(CGFloat)textSize
{
	UILabel* buttonLable = [[UILabel alloc] initWithFrame:framePosition];
	buttonLable.backgroundColor = [UIColor clearColor];
	buttonLable.opaque = YES;
	buttonLable.textColor = [UIColor blackColor];
	#if defined HOTEL_VERSION_TWO_BUTTONS || defined CLUB_VERSION_TWO_MYACCOUNT
		buttonLable.textAlignment = UITextAlignmentCenter;
	#endif	
	[buttonLable setFont:[UIFont boldSystemFontOfSize:textSize]];
	[buttonLable setText:text];
	[self addSubview:buttonLable];
	[buttonLable release];
}

-(void) setImageOnMenuButtons:(int) menuButtonIndex
{//
#if defined HOTEL_VERSION_TWO_BUTTONS || defined CLUB_VERSION_TWO_MYACCOUNT
    UIImageView* mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 12, 87, 60)];
#else
    UIImageView* mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 12, 92, 48)];
#endif
    
#if defined(HOTEL_VERSION)
    switch (menuButtonIndex)
    {
        case FirstButton:
            [mainImageView setImage:[UIImage imageNamed:Hotel_MyHotel_Icon] ];
            break;
        case SecondButton:
            [mainImageView setImage:[UIImage imageNamed:Hotel_MyItinerary_Icon] ];
            break;
		#if !defined (HOTEL_VERSION_TWO_BUTTONS)
        case ThirdButton:
            [mainImageView setImage:[UIImage imageNamed:Hotel_MyGroup_Icon] ];
            break;
		#endif
        default:
            [mainImageView setImage:[UIImage imageNamed:Hotel_MyHotel_Icon] ];
            break;
    }
#elif defined(CLUB_VERSION)
    switch (menuButtonIndex)
    {
        case FirstButton:
            [mainImageView setImage:[UIImage imageNamed:Club_MyClub_Icon] ];
            break;
			
		#if !defined CLUB_VERSION_TWO_MYACCOUNT
        case SecondButton:
            [mainImageView setImage:[UIImage imageNamed:Club_MyItinerary_Icon] ];
            #if defined ALL_VERSIONS_SECOND_STATIC_MYACCOUNT//new flow
            [mainImageView setImage:[UIImage imageNamed:Club_MyItinerary_Icon] ];   //image for static centr butn
            #endif
            break;
		#endif
			
		#if !defined (HOTEL_VERSION_TWO_BUTTONS)
        case ThirdButton:
            [mainImageView setImage:[UIImage imageNamed:Club_MyAccount_Icon] ];
            break;
		#endif
			
        default:
            [mainImageView setImage:[UIImage imageNamed:Club_MyClub_Icon] ];
            break;
    }
#endif
    
    mainImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:mainImageView];
    [mainImageView release];
 
}

-(void) setLayoutImageOnMenuButtons
{
    UIImageView* layoutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, MenuButtonLayout_Width, MenuButtonLayout_Height)];
    [layoutImageView setImage:[UIImage imageNamed:MenuButtonLayout]];
    layoutImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:layoutImageView];
    [layoutImageView release];

}

-(void) setNameOnMenuButtons:(int) menuButtonIndex
{
#if defined(HOTEL_VERSION)
    switch (menuButtonIndex)
    {
        case FirstButton:
            [self setButtonsLabels:Hotel_Button1_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
			#if (defined CLUB_VERSION_TWO_MYACCOUNT || defined HOTEL_VERSION_TWO_BUTTONS)
			#else
				[self setButtonsLabels:Hotel_Button1_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
            break;
        case SecondButton:
            [self setButtonsLabels:Hotel_Button2_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
			#if (defined CLUB_VERSION_TWO_MYACCOUNT	|| defined HOTEL_VERSION_TWO_BUTTONS)
			#else
				[self setButtonsLabels:Hotel_Button2_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
            break;
		#if !defined (HOTEL_VERSION_TWO_BUTTONS)
        case ThirdButton:
            [self setButtonsLabels:Hotel_Button3_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
            #if defined CLUB_VERSION_TWO_MYACCOUNT
			#else
				[self setButtonsLabels:Hotel_Button3_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
            break;
		#endif
        default:
            break;
    }
    
#elif defined(CLUB_VERSION)
    switch (menuButtonIndex)
    {
        case FirstButton:
            [self setButtonsLabels:Club_Button1_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
			#if (!defined CLUB_VERSION_TWO_MYACCOUNT || !defined HOTEL_VERSION_TWO_BUTTONS)
				[self setButtonsLabels:Club_Button1_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
            break;
			
		#if !defined CLUB_VERSION_TWO_MYACCOUNT
        case SecondButton:
            [self setButtonsLabels:Club_Button2_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
			#if (!defined HOTEL_VERSION_TWO_BUTTONS)
                #if defined ALL_VERSIONS_SECOND_STATIC_MYACCOUNT//new flow
            [self setButtonsLabels:@"Static" frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
                #else
				[self setButtonsLabels:Club_Button2_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
             #endif
            break;
		#endif
			
		#if !defined (HOTEL_VERSION_TWO_BUTTONS)
        case ThirdButton:
            [self setButtonsLabels:Club_Button3_Title1 frame:MenuButton_Title1_BoxSize fontSize:MenuButton_Title1_TextSize];
			#if (!defined CLUB_VERSION_TWO_MYACCOUNT)
				[self setButtonsLabels:Club_Button3_Title2 frame:MenuButton_Title2_BoxSize fontSize:MenuButton_Title2_TextSize];
			#endif
            break;
		#endif
			
        default:
            break;
    }
    
#endif
}

-(void) createCustomMenuButtons:(int) menuButtonIndex
{
	self.frame = CGRectMake(0 + menuButtonIndex*MenuButtonLayout_Width, 44, MenuButtonLayout_Width, MenuButtonLayout_Height);
	self.tag = menuButtonIndex;
		
    [self setImageOnMenuButtons:menuButtonIndex];
    [self setLayoutImageOnMenuButtons];
    [self setNameOnMenuButtons:menuButtonIndex];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
