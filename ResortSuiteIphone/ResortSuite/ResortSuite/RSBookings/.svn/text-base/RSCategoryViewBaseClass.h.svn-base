//
//  RSCategoryViewBaseClass.h
//  ResortSuite
//
//  Created by Cybage on 10/12/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Base class to display the category screen
 *Take the dictionay of the services as parameter
 * displays the keys in the UIPicker View
 * pushes a table view displaying the values for the key selected from UIPickerView
 
 
 ================================================================================
 */
#import <UIKit/UIKit.h>


@interface RSCategoryViewBaseClass : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UINavigationControllerDelegate>
{
    UIPickerView *_pickerView;
    NSDictionary *_categoryDictionary;
    NSArray      *_keyArray;                 //to hold the key form the dictionary.
    
    UIButton *_selectButton;                 // target to be added in the base calss
    
    ResortSuiteAppDelegate *appDelegate;
}

@property(nonatomic, retain) NSDictionary *categoryDictionary;       //should also contain key for "All"-complete array
@property(nonatomic, retain) NSArray      *keyArray;                 //to hold the key form the dictionary.
/*!
 @method		initWithDictionary
 @brief			initilize the object with required dictionary
 @details		
 @param			
 @return		void
 */
-(id)initWithDictionary:(NSDictionary *)dictionary;
/*!
 @method		AddSelectButtonWithTag
 @brief			Add Select Button With Tag 
 @details		
 @param			(int)rowinfo
 @return		void
 */
-(void)AddSelectButtonWithTag:(int)rowinfo;
/*!
 @method		createTitleHeader
 @brief			create Title Header at given ycord
 @details		
 @param			(NSString*)headerTitle, (float)yCoordinate
 @return		void
 */
-(void) createTitleHeader:(NSString*)headerTitle yPosition:(float)yCoordinate;  //to be called in subclass

@end
