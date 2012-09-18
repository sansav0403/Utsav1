//
//  OptionPickerView.h
//  ResortSuite
//
//  Created by Cybage on 1/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OptionPickerDelegate <NSObject>

-(void)selectedOption:(NSString *)option withSelectedTextFeildTag:(int)tag;

@end
@interface OptionPickerView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    IBOutlet UIPickerView *optionPicker;
    IBOutlet UIButton *doneButton;
    id<OptionPickerDelegate> delegate;
    NSArray *optionArray;
    int selectedField;      //enum value for the selected field from the new user screen
    NSMutableString *selectedString;
    int selectedTextFeildTag;
}
@property(nonatomic, retain) IBOutlet UIPickerView *optionPicker;
@property(nonatomic, retain) IBOutlet UIButton *doneButton;
@property(nonatomic, assign) id<OptionPickerDelegate> delegate;
@property(nonatomic, retain) NSArray *optionArray;
@property(nonatomic,assign) int selectedTextFeildTag;
-(IBAction)doneButtonAction:(id)sender;

@end
