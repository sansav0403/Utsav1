//
//  EmailVerificationVC.h
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConnection.h"
#import "EmailVerificationParser.h"

@interface EmailVerificationVC : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>
{
    IBOutlet UIImageView *BGImageView;
    IBOutlet UIImageView *whiteOverLayImageView;
    IBOutlet UITextField *emailAddressTxtView;
    ResortSuiteAppDelegate *appDelegate;
    
    EmailVerificationParser *emailVerificationParser;
    NSString *responseString;
    
    UIAlertView *successAlertView;
}
@property (nonatomic, retain) IBOutlet UIImageView *whiteOverLayImageView;
@property (nonatomic, retain) IBOutlet UIImageView *BGImageView;
@property(nonatomic, retain) IBOutlet UITextField *emailAddressTxtView;

@property (nonatomic, retain) EmailVerificationParser *emailVerificationParser;
@property (nonatomic, copy) NSString *responseString;
/*!
 @method		cancelButton
 @brief			cancel Button action
 @details		pop back to the root view controller on cancel action
 @param			(id)sender
 @return		
 */
-(IBAction)cancelButton:(id)sender;
-(IBAction)verifyButton:(id)sender;
-(void) createEmailVerificationRequest;
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
-(void) showErrorMessage:(id)parserModelData;
-(void) verificationDataRecieved:(id)parserModelData;
-(void) createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate;

-(void)alertForInvalidEmailAddress;
@end
