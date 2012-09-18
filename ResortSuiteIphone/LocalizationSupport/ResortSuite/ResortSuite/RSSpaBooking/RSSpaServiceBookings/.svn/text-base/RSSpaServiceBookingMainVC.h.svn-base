//
//  RSSpaServiceBookingMainVC.h
//  ResortSuite
//
//  Created by Cybage on 27/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display the form to filled to book a spa service.
 * Creates the disctionary based on the category of the spa service.
 * Hit the webservice to check for the available staff for the selected service and gender.
 * Also checks for availiblity for the selected service.
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"
#import "RSSpaLocation.h"

//Describes the table sections
enum MainTableSections {
	SpaServiceSection,
	DateSection,
	TimeSection,
	PrefStaffGenderSection,
	PrefStaffSection
};

@class RSBookingTableView;
@class RSSpaStaffParser;
@class RSSpaStaffs;
@class RSSpaService;

@class RSSpaServiceParser;      //parse in view did load and create dictionary
@class RSSpaAvailibilityParser;

@interface RSSpaServiceBookingMainVC : UIViewController <UINavigationControllerDelegate,RSParserHandlerDelegate,
									RSConnectionHandlerDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate> 
{
	NSString *viewTitle;
	ResortSuiteAppDelegate *appDelegate;
	
	UILabel *instructionLabel;
	UIDatePicker *datePicker;
	UIPickerView *prefStaffPicker;	
	RSBookingTableView *mainTableView;
	UIButton *checkAvailButton;
	
	NSMutableArray *mainFieldArray;
	NSMutableArray *subFieldArray;
	NSMutableArray *prefStaffGenders;
	NSMutableArray *prefStaffNames;	

	NSString *prefStaffGender;
										
	RSSpaStaffParser *spaStaffParser;
	RSSpaStaffs *spaStaffs;
	    
	int selectedSection;
	int selectedDateStartTime;
	int selectedDateEndTime;
	
	NSString *selectedDateAndTime;
    
	bool isPickerJustDisable;
    
    RSSpaService *notifiedSpaService;
    
    NSString *selectedGender;
    NSString *selectedStaff;
    
    
    RSSpaServiceParser *spaServiceParser;
    NSMutableDictionary *spaCategoryDictionary;
	
	RSSpaAvailibilityParser *spaAvailibilityParser;	
}

@property(nonatomic,copy) NSString *viewTitle;
@property(nonatomic, copy) NSString *prefStaffGender;

@property(nonatomic,copy) NSString *selectedGender;
@property(nonatomic, copy) NSString *selectedStaff;

@property(nonatomic, retain) RSSpaStaffParser *spaStaffParser;
@property(nonatomic, retain) RSSpaServiceParser *spaServiceParser;
@property(nonatomic, retain) RSSpaStaffs *spaStaffs;

@property(nonatomic, retain) NSString *selectedDateAndTime;

@property(nonatomic, retain) RSSpaService *notifiedSpaService;

@property(nonatomic, retain) RSSpaAvailibilityParser *spaAvailibilityParser;	
@property(nonatomic) BOOL isCurrentTimeUpdated;
/*!
 @method		initWithViewTitle
 @brief			Initialization of the view with title
 @details		....
 @param			Title string
 @return		RSSpaServiceBookingMainVC class object
 */
-(id) initWithViewTitle:(NSString *) viewTitleString;

/*!
 @method		fetchSpaStaffsForId
 @brief			Fetch the staff details
 @details		....
 @param			NSString spaItemId, NSString gender
 @return		void
 */
-(void) fetchSpaStaffsForId:(NSString *) spaItemId forGender:(NSString *) gender;

/*!
 @method		loadStaffNamesinPicker
 @brief		    Loads staff names picker view
 @details		....
 @param			id (RSStaffs obj)
 @return		void
 */
-(void) loadStaffNamesinPicker:(id) parserModelData;

/*!
 @method		shouldBookButtonEnabled
 @brief		    Decides the button should be enabled or not
 @details		....
 @param			void
 @return		void
 */
-(void) shouldBookButtonEnabled;

/*!
 @method		fetchSpaServices
 @brief		    fetch the Spa Services at view did load
 @details		....
 @param			void
 @return		void
 */
-(void) fetchSpaServices;

/*!
 @method		createDictionaryAndReloadTable
 @brief		    Creates the dectionary depending of Spa category 
 @details		....
 @param			void
 @return		void
 */
-(void)createDictionaryAndReloadTable;

/*!
 @method		createDictionaryAndReloadTable
 @brief		    change the view depending upon the count of category 
 @details		....
 @param			void
 @return		void
 */
-(void)switchApplicationToSpaServices;
/*!
 @method		doesAvailableTimeExitsInAvailibilityArray
 @brief		    check if the user selected time is presentin the availibilty array 
 @details		....
 @param			void
 @return		bool
 */
-(BOOL)doesAvailableTimeExitsInAvailibilityArray;
@end
