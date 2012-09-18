//
//  ChangePassword.h
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request o change the password
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSConnection.h"
#import "RSChangePasswordParser.h"
@interface ChangePassword : UIViewController<UITextFieldDelegate, UIAlertViewDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate>
{
    IBOutlet UITextField *emailAddressTxtView;
    IBOutlet UITextField *currentPasswordTxtView;
    IBOutlet UITextField *newerPasswordTxtView;
    IBOutlet UITextField *confirmPasswordTxtView;

    IBOutlet UIImageView *BGImageView;
    IBOutlet UIImageView *whiteOverLayImageView;
    
    ResortSuiteAppDelegate *appDelegate;
    RSChangePasswordParser *changePasswordParser;
    NSString *responseString;
    
    UIAlertView *successAlertView; 
}
@property (nonatomic, retain) RSChangePasswordParser *changePasswordParser;
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, retain) IBOutlet UIImageView *whiteOverLayImageView;

@property (nonatomic, retain) IBOutlet UIImageView *BGImageView;

@property(nonatomic, retain) IBOutlet UITextField *emailAddressTxtView;
@property(nonatomic, retain) IBOutlet UITextField *currentPasswordTxtView;
@property(nonatomic, retain) IBOutlet UITextField *newerPasswordTxtView;
@property(nonatomic, retain) IBOutlet UITextField *confirmPasswordTxtView;

/*!
 @method		changeButton
 @brief			change password
 @details       take action to change the users password
 @param			(id)sender
 @return		
 */
-(IBAction)changeButton:(id)sender;
/*!
 @method		cancelButton
 @brief			cancelButton action
 @details		pop to the root view controller on cancel button action
 @param			(id)sender
 @return		
 */
-(IBAction)cancelButton:(id)sender;
/*!
 @method		validNewPasswordAndConfirmPassword
 @brief			check if new and confirm password are valid and same
 @details		--
 @param			
 @return		
 */
-(BOOL) validNewPasswordAndConfirmPassword;
/*!
 @method		alertForInvalidEmailAddress
 @brief			alert For Invalid Email Address
 @details		--
 @param			(id)sender
 @return		
 */
-(void)alertForInvalidEmailAddress;
/*!
 @method		alertForInvalidPassword
 @brief			alert For Invalid Password
 @details		--
 @param			(id)sender
 @return		
 */
-(void)alertForInvalidPassword;
/*!
 @method		alertForDiffNewAndConfirmPassword
 @brief			alert For Diff New And Confirm Password
 @details		show alert if the new and confirm password are not same
 @param			(id)sender
 @return		
 */
-(void)alertForDiffNewAndConfirmPassword;
/*!
 @method		createChangePasswordRequest
 @brief			create soap request boady to change password
 @details		--
 @param			--
 @return		void
 */
-(void) createChangePasswordRequest;
/*!
 @method		fetchDataForRequestWithBody
 @brief			fetchs Data For Request With given soap Body
 @details		--
 @param			(NSString *) bodyString
 @return		
 */
-(void) fetchDataForRequestWithBody:(NSString *) bodyString;
/*!
 @method		responseReceived
 @brief			delegate method of RSConnection when responce is recieved
 @details		--
 @param			(NSMutableData *)dataFromWS
 @return		void
 */
-(void)responseReceived:(NSMutableData *)dataFromWS;
/*!
 @method		parsingComplete
 @brief			delegate method of RSParser when data from WebSErver is parsed
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void)parsingComplete:(id)parserModelData;
/*!
 @method		showErrorMessage
 @brief			show Error Message if recieved from Web services
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;
/*!
 @method		changePasswordDataRecieved
 @brief			perform action when successful changepassword responce is recived
 @details		--
 @param			(id)parserModelData
 @return		void
 */

-(void)changePasswordDataRecieved:(id)parserModelData;
/*!
 @method		createAlertMessageWithTitle
 @brief			create an alert view to show message to user
 @details		--
 @param			(NSString *)title,(NSString *)message,(id)delegate
 @return		void
 */
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate;
@end
