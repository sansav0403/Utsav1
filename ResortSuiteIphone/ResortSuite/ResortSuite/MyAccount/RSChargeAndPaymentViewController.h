//
//  RSChargeAndPaymentViewController.h
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 * view controller that give the user the option to check out his 
 *charges and payment.
 ================================================================================
 */
#import <UIKit/UIKit.h>


@interface RSChargeAndPaymentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSString *viewtitle;
	NSArray *constLabels;
	NSArray *dynamicLabels;
	NSArray *tableObjects;				//to store an array of the chare obj or payment obj;
	NSArray *tableChargeTitleTexts;
	NSArray *tablePaymentTitleTexts;

	int tableHeightOffset;

}
@property(nonatomic, copy) NSString *viewtitle;
@property(nonatomic, retain) NSArray *constLabels;
@property(nonatomic, retain) NSArray *dynamicLabels;
@property(nonatomic, retain) NSArray *tableObjects;		

-(id)initWithTitle:(NSString *)vTitle WithConstLabelText:(NSArray *)sLabelTexts DynamicTextLabels:(NSArray *)dLabelArray
objectArrays:(NSArray *)objectArray;

//-(float) calculateWidthForlabel:(NSString *)comments;
-(void)drawSeperatorImageAtYCord:(float)ycord AndDiffFactor:(float)diff;

/*!
 @method		stringFromDateWithoutYear
 @brief			Convert date into the string
 @details		Convert date into the string without adding year value
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDateWithoutYear:(NSDate *)date;
/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

/*!
 @method		addTotalLabelAtYcord
 @brief			Add the total label below the table
 @details		Add the total label below the table after getting the dynamic value of Y-cordinates
 @param			(CGFloat)Ycord, NSString *)labelText
 @return		(void)
 */
-(void)addTotalLabelAtYcord:(CGFloat)Ycord WithLabel:(NSString *)labelText;

/*!
 @method		createDetailsTable
 @brief			create Details Table 
 @details		create Details Table after getting the dynamic value of Y-cordinates
 @param			(CGFloat)coordinateY;
 @return		(void)
 */
-(void)createDetailsTable:(CGFloat)coordinateY;

/*!
 @method		createTitleLabel
 @brief			create Title Label 
 @details		create Title Label 
 @param			void
 @return		(void)
 */
-(void)createTitleLabel;

/*!
 @method		createInformationLabels
 @brief			createInformationLabels
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(void)createInformationLabels;

/*!
 @method		createDetailsTitles
 @brief			create Detail Table Titles
 @details		create Detail Table Titles  after getting the dynamic value of Y-cordinates
 @param			(NSArray *)tableTitleTexts, (CGFloat)coordinateY
 @return		(void)
 */
-(void)createDetailsTitles:(NSArray *)tableTitleTexts PositionY:(CGFloat)coordinateY;

/*!
 @method		createDetailsPageView
 @brief			To Do all the drawing in the view did load
 @details		To Do all the drawing in the view did load and changing the view depending upon charge/payment
 @param			(NSArray *)tableTitleTexts, (CGFloat)coordinateY, (NSString*) totalAmountLabel
 @return		(void)
 */
-(void)createDetailsPageView:(NSArray *)tableTitleTexts PositionY:(CGFloat)coordinateY TotalAmoutLabel:(NSString*) totalAmountLabel;

@end
