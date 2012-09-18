//
//  DOBPickerView.h
//  ResortSuite
//
//  Created by Cybage on 1/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DOBPickerDelegate <NSObject>

-(void)dateSelected:(NSString *)date;

@end
@interface DOBPickerView : UIViewController
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *doneButton;
    id<DOBPickerDelegate> delegate;
}
@property(nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property(nonatomic, retain) IBOutlet UIButton *doneButton;
@property(nonatomic, assign) id<DOBPickerDelegate> delegate;
-(IBAction)doneButtonAction:(id)sender;
@end
