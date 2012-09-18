//
//  NewUserForm.h
//  ResortSuite
//
//  Created by Cybage on 12/23/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request to register with resort suite.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSConnection.h"
#import "RSCreateCustomerParser.h"
#import "DOBPickerView.h"
#import "OptionPickerView.h"
enum selectedPhoneTag
{
    mainHomePhone  = 0,
    mainWorkPhone,
    mainOtherPhone
};
@interface NewUserForm : UIViewController <UITextFieldDelegate,RSParserHandlerDelegate,RSConnectionHandlerDelegate,DOBPickerDelegate,OptionPickerDelegate> {
    IBOutlet UIScrollView *containerScrollView;

    IBOutlet UITextField *genderTxtView;
    IBOutlet UITextField *salutaionTxtView;
    IBOutlet UITextField *firstNameTxtView;
    IBOutlet UITextField *lastNameTxtView;
    IBOutlet UITextField *emailTxtView;
    IBOutlet UITextField *confirmEmailTxtView;
    IBOutlet UITextField *PasswordTxtView;
    IBOutlet UITextField *ConfirmPasswordTxtView;
    IBOutlet UITextField *dobTxtView;
    
    IBOutlet UITextField *homePhoneTxtView;
    IBOutlet UITextField *WorkPhoneTxtView;
    IBOutlet UITextField *workPhExtensionTxtView;
    IBOutlet UITextField *OtherPhoneTxtView;
    
    IBOutlet UILabel *address1Label;
    IBOutlet UILabel *address2Label;
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *stateLabel;
    IBOutlet UILabel *countryLabel;
    IBOutlet UILabel *zipLabel;
    
    IBOutlet UITextField *address1TxtView;
    IBOutlet UITextField *address2TxtView;
    IBOutlet UITextField *cityTxtView;
    IBOutlet UITextField *stateTxtView;
    IBOutlet UITextField *countryTxtView;
    IBOutlet UITextField *ZipTxtView;
    //---
    IBOutlet UILabel *otherAddressOptionalLabel;
//    IBOutlet UIButton *otherAddressOptionalButton;
    IBOutlet UILabel *otherAddress1Label;
    IBOutlet UILabel *otherAddress2Label;
    IBOutlet UILabel *otherCityLabel;
    IBOutlet UILabel *otherStateLabel;
    IBOutlet UILabel *otherCountryLabel;
    IBOutlet UILabel *otherZipLabel;
    
    IBOutlet UITextField *otherAddress1TxtView;
    IBOutlet UITextField *otherAddress2TxtView;
    IBOutlet UITextField *otherCityTxtView;
    IBOutlet UITextField *otherStateTxtView;
    IBOutlet UITextField *otherCountryTxtView;
    IBOutlet UITextField *otherZipTxtView;
    
    IBOutlet UIButton *mainHomeButton;
    IBOutlet UIButton *mainWorkButton;
    IBOutlet UIButton *mainOtherButton;
    
    NSArray *genderArray;
    NSArray *salutationArray;
    IBOutlet UIImageView *BGImageView;
    IBOutlet UIImageView *whiteOverLayImageView;
    

    ResortSuiteAppDelegate *appDelegate;
    NSString *responseString;
    RSCreateCustomerParser *createCustomerParser;
    
    UIAlertView *successAlertView;
    DOBPickerView *dobPicker;
    OptionPickerView *optionPickerView;
    //BOOL isAddresButton;
    
    NSMutableString * mainHomePhoneSelectionState;
    NSMutableString * mainWorkPhoneSelectionState;
    NSMutableString * mainOtherPhoneSelectionState;
}
@property (nonatomic, retain) IBOutlet UIImageView *whiteOverLayImageView;
@property (nonatomic, retain) IBOutlet UIImageView *BGImageView;

-(IBAction)DoneBtnAction:(id)sender;
-(IBAction)cancelBtnAction:(id)sender;
//-(IBAction)addAddressInformation:(id)sender;
//-(IBAction)addOtherAddressInformation:(id)sender;
@property (nonatomic, retain) IBOutlet UIScrollView *containerScrollView;

@property (nonatomic, retain) IBOutlet UITextField *genderTxtView;
@property (nonatomic, retain) IBOutlet UITextField *salutaionTxtView;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTxtView;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTxtView;
@property (nonatomic, retain) IBOutlet UITextField *emailTxtView;
@property (nonatomic, retain) IBOutlet UITextField *confirmEmailTxtView;
@property (nonatomic, retain) IBOutlet UITextField *PasswordTxtView;
@property (nonatomic, retain) IBOutlet UITextField *ConfirmPasswordTxtView;
@property (nonatomic, retain) IBOutlet UITextField *dobTxtView;

@property (nonatomic, retain) IBOutlet IBOutlet UITextField *homePhoneTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *WorkPhoneTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *workPhExtensionTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *OtherPhoneTxtView;

@property (nonatomic, retain) IBOutlet UITextField *address1TxtView;
@property (nonatomic, retain) IBOutlet UITextField *address2TxtView;
@property (nonatomic, retain) IBOutlet UITextField *cityTxtView;
@property (nonatomic, retain) IBOutlet UITextField *stateTxtView;
@property (nonatomic, retain) IBOutlet UITextField *countryTxtView;
@property (nonatomic, retain) IBOutlet UITextField *ZipTxtView;

@property (nonatomic, retain) IBOutlet UILabel *address1Label;
@property (nonatomic, retain) IBOutlet UILabel *address2Label;
@property (nonatomic, retain) IBOutlet UILabel *cityLabel;
@property (nonatomic, retain) IBOutlet UILabel *stateLabel;
@property (nonatomic, retain) IBOutlet UILabel *countryLabel;
@property (nonatomic, retain) IBOutlet UILabel *zipLabel;

@property (nonatomic, retain) IBOutlet IBOutlet UIButton *mainHomeButton;
@property (nonatomic, retain) IBOutlet IBOutlet UIButton *mainWorkButton;
@property (nonatomic, retain) IBOutlet IBOutlet UIButton *mainOtherButton;
//---
@property (nonatomic, retain) IBOutlet IBOutlet IBOutlet UILabel *otherAddressOptionalLabel;
//@property (nonatomic, retain) IBOutlet IBOutlet IBOutlet UIButton *otherAddressOptionalButton;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherAddress1Label;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherAddress2Label;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherCityLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherStateLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherCountryLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *otherZipLabel;

@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherAddress1TxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherAddress2TxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherCityTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherStateTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherCountryTxtView;
@property (nonatomic, retain) IBOutlet IBOutlet UITextField *otherZipTxtView;

@property (nonatomic,copy) NSString *responseString;
@property (nonatomic, retain) RSCreateCustomerParser *createCustomerParser;
/*!
 @method		validateEmail
 @brief			validate Email address
 @details		--
 @param			(NSString *) emai
 @return		BOOL
 */
+(BOOL) validateEmail: (NSString *) email;
/*!
 @method		ValidateText
 @brief			Validate Textfield for being empty
 @details		--
 @param			(NSString *)string
 @return		BOOL
 */
+(BOOL) ValidateText:(NSString *)string;
/*!
 @method		ValidatePhoneNumber
 @brief			Validate Phone Number
 @details		--
 @param			NSString *)phoneNum
 @return		BOOL
 */
+(BOOL) ValidatePhoneNumber:(NSString *)phoneNum;

/*!
 @method		setTheContentOffsetOfScrollViewFortextView
 @brief			set the content offset of the scrollview
 @details		set the content offset of the scroll with animation
 @param			(UITextField *)txtView;
 @return		void
 */
-(void)setTheContentOffsetOfScrollViewFortextView:(UITextField *)txtView;
/*!
 @method		alertForInvalidPhoneNumber
 @brief			alert For Invalid Phone Number
 @details		--
 @param			
 @return		(void)
 */
-(void) alertForInvalidPhoneNumber;
/*!
 @method		alertForInvalidEmailAddress
 @brief			alert For Invalid Email Address
 @details		--
 @param			
 @return		(void)
 */
-(void)alertForInvalidEmailAddress;
/*!
 @method		alertForInvalidText
 @brief			alert For Invalid Text
 @details		--
 @param			
 @return		(void)
 */
-(void) alertForInvalidText;
/*!
 @method		alertForAtleastOnePhoneNumber
 @brief         alert to enter atleast one contact number
 @details		--
 @param		
 @return		(void)
 */
-(void) alertForAtleastOnePhoneNumber;
/*!
 @method		createNewUserRequest
 @brief			create soap request boady to create new user
 @details		--
 @param			--
 @return		void
 */
-(void) createNewUserRequest;
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
 @method		createCustomerDataRecieved
 @brief			perform action when successful createCustomer responce is recived
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void)createCustomerDataRecieved:(id)parserModelData;
/*!
 @method		createAlertMessageWithTitle
 @brief			create an alert view to show message to user
 @details		--
 @param			(NSString *)title,(NSString *)message,(id)delegate
 @return		void
 */
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate;
/*!
 @method		allFieldValidated
 @brief			Do mandatory field validation
 @details		--
 @param			--
 @return		BOOL
 */
-(BOOL) allFieldValidated;
/*!
 @method		doAnimation
 @brief			Do animation for picker view
 @details		--
 @param			--
 @return		void
 */
-(void)doAnimation;
-(void)ResignResponderForAllTextField;
-(IBAction)selectMainPhone:(id)sender;
@end
