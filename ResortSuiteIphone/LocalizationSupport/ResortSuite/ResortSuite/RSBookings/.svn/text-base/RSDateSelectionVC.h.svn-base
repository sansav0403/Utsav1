//
//  RSDateSelectionVC.h
//  ResortSuite
//
//  Created by Cybage on 10/10/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Generic class to allow selection of date using UIDatePIcker
 * Able to display both time and date
 * displays time in the range possible of the given date.
 
 ================================================================================
 */

#import <UIKit/UIKit.h>

//Describes the picker type either Date or Time picker
enum PickerType {
	DatePicker = 1,
	TimePicker,	
};

//Describes the Golf picker type either Date or Time picker
enum golfPickerType
{
    golfDatePicker,
    golfTimePicker,
};

@class ResortSuiteAppDelegate;
@class RSBookingTableView;

@interface RSDateSelectionVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate> {

	RSBookingTableView              *mainTableView;
	UIDatePicker                    *datePicker;
	UIButton                        *searchButton;
	
	ResortSuiteAppDelegate          *appDelegate; 
	
	NSMutableArray                  *mainFieldArray, *subFieldArray;
	
	int                             selectedDateStartTime;
	int                             selectedDateEndTime;
	
	int                             pickerType;		//decides which picker to load
	NSString                        *dateString;
	NSString                        *timeString;
	BOOL                            isGolf;
    NSMutableArray                  * dayTimes;    //array to store theend and start time for the 
                                                //selected date and pass the info to the spabooking form as nottice
}

@property(nonatomic)         int pickerType;
@property(nonatomic, retain) NSString *dateString;
@property(nonatomic, retain) NSString *timeString;

@property(nonatomic, assign) BOOL isGolf;
/*!
 @method		initWithSection
 @brief			Initialization for type of picker depending on the parameters
 @details		....
 @param			int pickerType, NSString dateString
 @return		RSDateSelectionVC class object
 */
-(id) initWithSection:(int) pickerType dateString:(NSString *) dateString;

/*!
 @method		initWithSection
 @brief			Initialization for type of picker depending on the parameters
 @details		....
 @param			int pickerType, NSString dateString, NSString timeString.
 @return		RSDateSelectionVC class object
 */
-(id) initWithSection:(int) pickerType dateString:(NSString *) dateString timeString:(NSString *) timeString;

/*!
 @method		addControlsToView
 @brief			Add UI controls to the view
 @details		....
 @param			nil
 @return		void
 */
-(void) addControlsToView;

/*!
 @method		createSelectedDateTime
 @brief		    Create a start time and end time for day of the week from the given strings
 @details		....
 @param			(NSString *)startTimeOfDay, (NSString *)endTimeOfDay ;
 @return		void
 */
-(void) createSelectedDateTime:(NSString *)startTimeOfDay withEndTime:(NSString *)endTimeOfDay; 

/*!
 @method		dateFromString
 @brief		    Create a date format using the string parameter
 @details		....
 @param			NSString stringDate
 @return		NSDate
 */
-(NSDate *)dateFromString:(NSString *)stringDate;

/*!
 @method		convertTimeIn24Hour
 @brief		    Method converts the Time in 24 hr clock
 @details		....
 @param			int time
 @return		int
 */
-(int) convertTimeIn24Hour: (int) time;

/*!
 @method		setMinimumAndMaximumTimeForTheSelectedDate
 @brief		    Method which sets the min/max time for selected date
 @details		....
 @param			Date
 @return		void
 */
-(void)setMinimumAndMaximumTimeForTheSelectedDate:(NSDate *)selectedDate;
/*!
 @method		createStartAndEndTimeForGolfWithWeekday
 @brief			create Start And End Time For Golf for given Weekday
 @details		
 @param			
 @return		void
 */
-(void)createStartAndEndTimeForGolfWithWeekday:(NSInteger )weekday;
/*!
 @method		createStartAndEndTimeForSpaWithWeekday
 @brief			create Start And End Time For spa for given Weekday
 @details		
 @param			
 @return		void
 */
-(void)createStartAndEndTimeForSpaWithWeekday:(NSInteger )weekday;
@end
