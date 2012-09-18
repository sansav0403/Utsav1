//
//  RSProfile.h
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *view controller to display the profile of the user under a given account.
 *gives the information about the account detais and membership information
 ================================================================================
 */
#import <UIKit/UIKit.h>


@interface RSProfile : UIViewController {
	NSString *viewtitle;
	NSArray *constLabelText;
	NSArray *dynamicLabelText;
	UIScrollView *scrollView;
	
	NSArray* membershipTags;
	NSArray* accountCustomerTags;
	
	float label2Y_cord ;
}

@property (nonatomic, retain) NSArray *constLabelText;
@property (nonatomic, retain) NSArray *dynamicLabelText;
@property (nonatomic, copy) NSString *viewtitle;
@property (nonatomic, retain) NSArray* membershipTags;
@property (nonatomic, retain) NSArray* accountCustomerTags;

/*!
 @method		initWithTitle
 @brief			init object With Title
 @details		
 @param			(NSString *)vTitle 
 @return		(id)
 */
-(id)initWithTitle:(NSString *)vTitle ;

/*!
 @method		calculateWidthForlabel
 @brief			calculate requird Width For label
 @details		Create a string object from a given date
 @param			(NSString *)comments
 @return		(float)
 */
-(float) calculateWidthForlabel:(NSString *)comments;

/*!
 @method		calculateNextY_CordFromPreviousY_cord
 @brief			calculate next label Y Co ordinate From Previous label Y Co ordinate
 @details		based on the previous label number of line calculate the next label cordinate
 @param			(float)y_cord , (int)noOfLine
 @return		(float)
 */
-(float)calculateNextY_CordFromPreviousY_cord:(float)y_cord andNumOfLine:(int)noOfLine;

/*!
 @method		calculateNoOfLinesForLineWidth
 @brief			calculate No Of Lines For Label
 @details		calculate No Of Lines For Label for the given width of label
 @param			(float)lineWidth;
 @return		(int)
 */
-(int)calculateNoOfLinesForLineWidth:(float)lineWidth;

/*!
 @method		createSectionHeader
 @brief			create Section Header label for each account type body
 @details		create Section Header label for each account type body at a given y co ordiante
 @param			(NSString*)headerTitle , (float)yCoordinate;
 @return		(void)
 */
-(void) createSectionHeader:(NSString*)headerTitle yPosition:(float)yCoordinate;

/*!
 @method		createDescriptionBody
 @brief			create  Description Body for each account type in profile
 @details		create  Description Body for each account type in profile at a given y co ordiante
 @param			(NSArray*)tagsTitle , (NSArray*)tagsValue
 @return		(void)
 */
-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue;

/*!
 @method		displaySeperatorImage
 @brief			display Seperator Image between the description body
 @details		Create a string object from a given date
 @param			(float)yCoordinate
 @return		(void)
 */
-(void) displaySeperatorImage:(float)yCoordinate;
-(void) generateAccountDetails;
-(void) generateCurrentMembershipDetails;
-(void) generateAccountCustomerDetails;

@end
