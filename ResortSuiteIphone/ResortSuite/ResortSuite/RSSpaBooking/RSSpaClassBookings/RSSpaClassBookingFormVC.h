//
//  RSSpaClassBookingFormVC.h
//  ResortSuite
//
//  Created by Cybage on 10/13/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display the form to filled to book a spa Class.
 * Creates the dictionary based on the category of the spa Class.
 * Also checks for availiblity for the selected Class for the given date.
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSConnection.h"
#import "RSParseBase.h"
#import "RSSpaClass.h"
enum ClassTableSections {
    ClassDateSection,
	ClassServiceSection	
};

@class RSBookingTableView;
@class RSDailySpaClassesParser;
@class RSSpaCustomerConflictBookingsParser;

@interface RSSpaClassBookingFormVC : UIViewController <UITableViewDelegate, RSConnectionHandlerDelegate,RSParserHandlerDelegate,UITableViewDataSource,UINavigationControllerDelegate>{
    
    NSMutableArray *mainFieldArray;
	NSMutableArray *subFieldArray;
    
    NSString *viewTitle;
    ResortSuiteAppDelegate *appDelegate;
    
    RSBookingTableView *mainTableView;
    UILabel *instructionLabel;
    UIButton *checkAvailButton;
    
    int selectedSection;
    
    RSDailySpaClassesParser *dailySpaClassesParser;
    
    //to manage the dictiopnary creation
    NSMutableDictionary *classCategoryDictionary;
    RSSpaClass *selectedSpaClass;
    // for conflict check
    RSSpaCustomerConflictBookingsParser   *spaCustomerConflictBookingsParser ;
    
}

@property(nonatomic, copy) NSString *viewTitle;
@property (nonatomic, retain) RSDailySpaClassesParser *dailySpaClassesParser;
@property (nonatomic, retain) RSSpaCustomerConflictBookingsParser *spaCustomerConflictBookingsParser ;

@property (nonatomic, retain) RSSpaClass *selectedSpaClass;     //to store the obj from notification
/*!
 @method		shouldBookButtonEnabled
 @brief			check codition when the book button should be enabled
 @details		....
 @param			
 @return		void
 */
-(void) shouldBookButtonEnabled;
/*!
 @method		initWithViewTitle
 @brief			Initialization of the view with title
 @details		....
 @param			Title string
 @return		id
 */
-(id) initWithViewTitle:(NSString *) viewTitleString;
/*!
 @method		fetchSpaClasses
 @brief			fetch Spa Classes from the web services
 @details		....
 @param			Title string
 @return		RSSpaServiceBookingMainVC class object
 */
-(void) fetchSpaClasses;
/*!
 @method		createDictionaryAndReloadTable
 @brief			create Dictionary for spa class based on category and ReloadTable
 @details		....
 @param			
 @return		void
 */
-(void)createDictionaryAndReloadTable;

@end
