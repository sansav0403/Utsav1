//
//  RSGolfCourseBookingVC.h
//  ResortSuite
//
//  Created by Cybage on 10/4/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 viewController to display golf booking.
 * call the web service to fetch golf course for a particular location

 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@class RSBookingTableView;
@class ResortSuiteAppDelegate;
@class RSGolfCoursesParser;

@interface RSGolfCourseBookingVC : UIViewController <RSParserHandlerDelegate,RSConnectionHandlerDelegate, 
UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource> {
	
    RSBookingTableView* mainTableView;
	ResortSuiteAppDelegate *appDelegate;
    
    int golfLocationID;
    
    NSMutableArray *TableDataArray;
    NSMutableArray *golfCourseArray;
    
    RSGolfCoursesParser *golfCoursesParser;
}

@property(nonatomic,assign) int golfLocationID;
/*!
 @method		initWithGolflocationID
 @brief			init With Golfl ocationID
 @details		
 @param			int
 @return		id
 */
-(id)initWithGolflocationID:(int)locationID;
/*!
 @method		fetchDataForRequestWithBody
 @brief			fetch Data For Request With soap Body
 @details		
 @param			NSString
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
