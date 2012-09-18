    //
//  Profile.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSProfile.h"


@implementation RSProfile

@synthesize constLabelText,dynamicLabelText,viewtitle;
@synthesize membershipTags,accountCustomerTags; 

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
-(id)initWithTitle:(NSString *)vTitle 
{
	self.viewtitle = vTitle;
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
	
	// to make the page scroll able add scroll view
	scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScrollLabel_YCord, Screen_Width, Screen_Height-ScrollLabel_YCord - 70)];
	[scrollView setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:scrollView];
	[scrollView release];
	
	[ResortSuiteAppDelegate setContactUsIcon:NO];
	label2Y_cord = ScrollLabel_YCord;
	
	//Account Details
	[self generateAccountDetails];
	[self createSectionHeader:AccountDetailHeader yPosition:0];
	[self createDescriptionBody:self.constLabelText dataArray:self.dynamicLabelText];
	[self displaySeperatorImage:label2Y_cord + ([self.constLabelText count])*(LabelCord_TwoLinesDifference - LabelCord_height)];

	//Current Membership
	label2Y_cord += [self.constLabelText count]*(LabelCord_TwoLinesDifference - LabelCord_height);
	[self createSectionHeader:CurrentMembershipHeader yPosition:label2Y_cord ];
	[self generateCurrentMembershipDetails];
	
	//Account Customers
	label2Y_cord += [self.membershipTags count]*(LabelCord_TwoLinesDifference - LabelCord_height);
	[self createSectionHeader:AccountCustomerHeader yPosition:label2Y_cord ];
	[self generateAccountCustomerDetails];
	
	[scrollView setContentSize:CGSizeMake(Screen_Width, label2Y_cord + ([self.constLabelText count] + [self.membershipTags count] + [self.accountCustomerTags count] - 6)*(LabelCord_TwoLinesDifference - LabelCord_height) )];	//label2Y_cord ll noew hold the latest y cord of the last label
}

-(void) generateAccountDetails
{
    NSArray *constlabeltxtArray = [[NSArray alloc]initWithObjects:AccountNoStaticText,
                                   AccountTypeStaticText,
                                   AccountOwnerStaticText,
                                   AccountMemberNoStaticText,
                                   AccountMemberIDStaticText,
                                   AccountMemberLevelStaticText,
                                   AccountAddressStaticText,
                                   AccountPhoneStaticText,
                                   AccountEmailAddressStaticText,
                                   nil];
	self.constLabelText = constlabeltxtArray;
    [constlabeltxtArray release];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *customerAdress = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@.", 
								appDelegate.myAccParser.clubAccounts.accCustomer.address.addressLine1,
								appDelegate.myAccParser.clubAccounts.accCustomer.address.addressLine2,
								appDelegate.myAccParser.clubAccounts.accCustomer.address.city,
								appDelegate.myAccParser.clubAccounts.accCustomer.address.province,
								appDelegate.myAccParser.clubAccounts.accCustomer.address.country,
								appDelegate.myAccParser.clubAccounts.accCustomer.address.postalCode
								];
    
    NSArray *dynamicLblTxtArray = [[NSArray alloc]initWithObjects:
                                   [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] accountId],
                                   [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] classType],
                                   [[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] statementCustomerName],
                                   
                                   appDelegate.myAccParser.clubAccounts.accCustomer.customerCode,
                                   appDelegate.myAccParser.clubAccounts.accCustomer.customerId,
                                   appDelegate.myAccParser.clubAccounts.accCustomer.VIPLevel,
                                   
                                   customerAdress,
                                   appDelegate.myAccParser.clubAccounts.accCustomer.phoneNumber,
                                   appDelegate.myAccParser.clubAccounts.accCustomer.emailAddress,
                                   nil];
	self.dynamicLabelText = dynamicLblTxtArray;
    [dynamicLblTxtArray release];
	
}

-(void) generateCurrentMembershipDetails
{
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *membershipTagArray = [[NSArray alloc]initWithObjects:
                                   MembershipType,
                                   MembershipName,
                                   MembershipStatus,
                                   MembershipEffectiveDate,
                                   MembershipExpiryDate,
                                   nil];
	self.membershipTags = membershipTagArray;
    [membershipTagArray release];
	
	
	for(int membershipIndex=0; membershipIndex< [[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] count]; membershipIndex++)
	{
		label2Y_cord += [self.constLabelText count]*(LabelCord_TwoLinesDifference - LabelCord_height);
		
		NSString *memberName = [NSString stringWithFormat:@"%@ %@ %@", [[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] salutation],
								[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] firstName],
								[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] lastName] ];
		
		NSArray* membershipValue = [[NSArray alloc]initWithObjects:
									[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] name],
									memberName,
									[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] status],
									[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] effectiveDate],
									[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] memberShips] objectAtIndex:membershipIndex] expiryDate],
									nil];
		
		[self createDescriptionBody:self.membershipTags dataArray:membershipValue];
		
		[self displaySeperatorImage:label2Y_cord + ([membershipValue count])*(LabelCord_TwoLinesDifference - LabelCord_height)];
        [membershipValue release];
    }
}

-(void) generateAccountCustomerDetails
{
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSArray *accountCustomerTagArray = [[NSArray alloc]initWithObjects:
                                       AccountName,
                                        AccountMemberShipLevel,
                                        nil];
    self.accountCustomerTags = accountCustomerTagArray;
    [accountCustomerTagArray release];
	
	
	for(int memberIndex=0; memberIndex< [[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] members] count]; memberIndex++)
	{
		label2Y_cord += [self.membershipTags count]*(LabelCord_TwoLinesDifference - LabelCord_height) + 15;
		
		NSString *memberName = [NSString stringWithFormat:@"%@ %@ %@", [[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] members] objectAtIndex:memberIndex] salutation],
								[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] members] objectAtIndex:memberIndex] firstName],
								[[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] members] objectAtIndex:memberIndex] lastName] ];
		
		NSArray* accountCustomerValue = [[NSArray alloc]initWithObjects:
										 memberName,
										 [[[[appDelegate.myAccParser.clubAccounts.accounts objectAtIndex:appDelegate.currentAccountID] members] objectAtIndex:memberIndex] VIPLevel],
										 nil];
		
		[self createDescriptionBody:self.accountCustomerTags dataArray:accountCustomerValue];
		[accountCustomerValue release];
		[self displaySeperatorImage:label2Y_cord + ([self.membershipTags count])*(LabelCord_TwoLinesDifference - LabelCord_height)];
	}
}

-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue;

{
	for (int tagIndex = 0; tagIndex < [tagsTitle count]; tagIndex++)
	{
		
		//CGRectMake(Label1Cord_x, label2Y_cord, LabelCord_width, LabelCord_height)
		UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectZero]; //
		UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectZero];
		
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor blackColor];
		[label1 setFont:[UIFont boldSystemFontOfSize:12]];
		
		if ([tagsTitle objectAtIndex:tagIndex] != nil)
		{
			[label1 setText:[tagsTitle objectAtIndex:tagIndex]];
			
			if (tagIndex == 0) {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);	//Label1Cord_y dont need to use it as now we are addin them to scrool view
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + tagIndex* (LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
			}
			
		}
		else 
		{
			[label1 setText:DataNotAvailable];
			if (tagIndex == 0) {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + tagIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
			}
			
		}
		// work for dynamic label--- label2
		label2.backgroundColor = [UIColor clearColor];
		label2.opaque = YES;
		label2.textColor = [UIColor blackColor];
		[label2 setFont:[UIFont systemFontOfSize:12]];
		
		if (tagIndex < [tagsValue count] && [tagsValue objectAtIndex:tagIndex] != nil)
		{
			
			int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:[tagsValue objectAtIndex:tagIndex]]];
			if (tagIndex == 0) {
				label2.lineBreakMode = UILineBreakModeWordWrap;
				label2.numberOfLines = 0;
				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:[tagsValue objectAtIndex:tagIndex]];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
				
			}
			else {
				label2.lineBreakMode = UILineBreakModeWordWrap;
				label2.numberOfLines = 0;
				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord + tagIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:[tagsValue objectAtIndex:tagIndex]];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			}
			
		}
		else 
		{
			int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:DataNotAvailable]];
			if (tagIndex == 0) {
				label2.lineBreakMode = UILineBreakModeWordWrap;
				label2.numberOfLines = 0;
				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:DataNotAvailable];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
				
			}
			else {
				label2.lineBreakMode = UILineBreakModeWordWrap;
				label2.numberOfLines = 0;
				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord + tagIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:DataNotAvailable];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			}
			
		}
		
		[scrollView addSubview:label1];
		[scrollView addSubview:label2];		
		
		[label1 release];
		[label2	 release];
		
	}
}

-(void) displaySeperatorImage:(float)yCoordinate;
{
	UIImageView* seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, yCoordinate + 3, Screen_Width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[scrollView addSubview:seperatorImage];
	[seperatorImage release];
}

-(void) createSectionHeader:(NSString*)headerTitle yPosition:(float)yCoordinate
{
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, yCoordinate + 8, titleLabelCord_width, titleLabelCord_height)];
	titleLabel.backgroundColor = [UIColor whiteColor];
	titleLabel.opaque = YES;
	titleLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
	[titleLabel setText:[NSString stringWithFormat:@"    %@", headerTitle]];
	[scrollView addSubview:titleLabel];
	[titleLabel release];
	
}

-(CGFloat) calculateWidthForlabel:(NSString *)comments
{
	CGSize size = [comments sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(800,160) lineBreakMode:UILineBreakModeWordWrap];
	return size.width + 10;
}

-(int)calculateNoOfLinesForLineWidth:(CGFloat)lineWidth
{
	//assumein the label width to be 130
	if(lineWidth/100 > 1) 
	{
		return floor(lineWidth/100);
	}
	else {
		return 1;
	}

}
-(CGFloat)calculateNextY_CordFromPreviousY_cord:(float)y_cord andNumOfLine:(int)noOfLine
{
	return y_cord + ((noOfLine) * LabelCord_height);
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
//     Release any retained subviews of the main view.
//     e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[constLabelText release];
	[membershipTags release];
	[accountCustomerTags release];
	
	[dynamicLabelText release];
}


@end
