//
//  LogoutScreen.h
//  ResortSuite
//
//  Created by Cybage on 1/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
enum logoutOptions
{
    Logout_ok = 0,
    Logout_changePassword,
    Logout_cancel
};
@class LogoutScreen;
@protocol LogoutViewDelegate <NSObject>

-(void)logoout:(LogoutScreen *)actionSheet buttonSelectedAtindex:(int)buttonIndex;

@end
@interface LogoutScreen : UIViewController
{
    ResortSuiteAppDelegate *appDelegate;
    IBOutlet UIButton *okButton;
    IBOutlet UIButton *changeButton;
    IBOutlet UIButton *cancelButton;
    
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *whiteOverLayImageView;
    id<LogoutViewDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UIButton *okButton;
@property (nonatomic, retain) IBOutlet UIButton *changeButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;

@property (nonatomic, retain) IBOutlet UIImageView *whiteOverLayImageView;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic,assign) id<LogoutViewDelegate> delegate;
-(IBAction)okButtonAction:(id)sender;
-(IBAction)changeButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@end
