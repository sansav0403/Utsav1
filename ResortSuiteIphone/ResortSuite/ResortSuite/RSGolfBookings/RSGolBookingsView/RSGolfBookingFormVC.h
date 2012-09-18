//
//  RSGolfBookingFormVC.h
//  ResortSuite
//
//  Created by Cybage on 10/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display golf booking form.
 * display the UIcontrolls related to the booking golf.
 * manages the connection and parsing of the booking action
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSSpaLocation.h"


enum MainTableSections {
	GolfDateSection,
	TeeTimeSection,
    PlayersCountSection
};
 
@class RSBookingTableView;
@class RSGolfTeeTimesParser;        //to parse rthe tee time services
@interface RSGolfBookingFormVC : UIViewController < UINavigationControllerDelegate,RSParserHandlerDelegate,
RSConnectionHandlerDelegate, UITableViewDelegate, UITableViewDataSource >{
    
    ResortSuiteAppDelegate  *appDelegate;
    
    RSBookingTableView      *mainTableView;
    UIButton                *checkAvailButton;
    
    UILabel                 *instructionLabel;
	UIDatePicker            *datePicker;
    
    NSString                *selectedCourseID;
    
    NSMutableArray          *mainFieldArray;
	NSMutableArray          *subFieldArray;
    
    int                     selectedSection;        //to store which section was selected
    
    bool                    isPickerJustDisable;
    
    RSGolfTeeTimesParser    *teeTimeParser;
    
}

@property(nonatomic, copy) NSString *selectedCourseID;
/*!
 @method		initWithCourseId
 @brief			init With CourseId   
 @details		
 @param			id
 @return		void
 */
-(id)initWithCourseId:(NSString *)CourseID;

/*!
 @method		shouldBookButtonEnabled
 @brief			put condition when the select button should be enabled   
 @details		
 @param			
 @return		void
 */
-(void) shouldBookButtonEnabled;
/*!
 @method		dateFromString
 @brief			get date object fron date string  
 @details		
 @param			NSString
 @return		NSDate
 */
-(NSDate *)dateFromString:(NSString *)stringDate;

//-(int) convertTimeIn24Hour: (int) time;
/*!
 @method		fetchTeeTime
 @brief			fetch Tee Time from we service 
 @details		
 @param			id
 @return		void
 */
-(void) fetchTeeTime;
/*!
 @method		fetchDataForRequestWithBody
 @brief			call web service for given soap body   
 @details		
 @param			id
 @return		void
 */
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
/*!
 @method		showErrorMessage
 @brief			show Error Message on error condition   
 @details		
 @param			id
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;
@end
