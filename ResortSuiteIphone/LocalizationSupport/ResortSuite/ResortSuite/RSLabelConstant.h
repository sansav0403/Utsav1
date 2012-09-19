//
//  RSLabelConstant.h
//  ResortSuite
//
//  Created by Cybage on 5/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSLocalizationManager.h"

#pragma Mark  - TabTitle and Tab icon Image

#define RSHotelTabIcon              @"hotel_icon.png"   //currently this icon is used for the static tab icon
#define RSSelfTabIcon               @"self_icon.png"
#define RSBookTabIcon               @"book_icon.png"
#define RSGroupTabIcon              @"group_icon.png"
#define RSStaticTabIcon             @"hotel_icon.png"   //---

#define RSHomeTabTitle              [RSLocalizationManager localizedStringForKey:@"RSHomeTabTitle"] //@"Home"
#define RSHomeTabIcon                       @"home_icon.png"

#define RSMyHotelTabTitle           [RSLocalizationManager localizedStringForKey:@"RSMyHotelTabTitle"]     
#define RSMyClubTabTitle            [RSLocalizationManager localizedStringForKey:@"RSMyClubTabTitle"];

#define RSHotelSelfTabTitle         [RSLocalizationManager localizedStringForKey:@"RSHotelSelfTabTitle"]
#define RSClubItineraryTabTitle     [RSLocalizationManager localizedStringForKey:@"RSClubItineraryTabTitle"]

#define RSHotelMyGroupTabTitle      [RSLocalizationManager localizedStringForKey:@"RSHotelMyGroupTabTitle"]
#define RSClubMyAccountTabTitle     [RSLocalizationManager localizedStringForKey:@"RSClubMyAccountTabTitle"]

#define RSBookingTabTitle           [RSLocalizationManager localizedStringForKey:@"RSBookingTabTitle"]
#define RSStaticTabTitle            [RSLocalizationManager localizedStringForKey:@"RSStaticTabTitle"]

#define RsGallaryTitle              [RSLocalizationManager localizedStringForKey:@"RsGallaryTitle"]
/********************************************************************/
#pragma mark- Pop up Error messages

#define POPUP_Error                         @""

#define POPUP_Sign_Out                      [RSLocalizationManager localizedStringForKey:@"POPUP_Sign_Out"]//@"Sign Out"
#define POPUP_Sign_Out_Text                 [RSLocalizationManager localizedStringForKey:@"POPUP_Sign_Out_Text"]//@"Do you want to sign out?"
#define POPUP_Offline_Mode                  [RSLocalizationManager localizedStringForKey:@"POPUP_Offline_Mode"]//@"Offline Mode"
#define POPUP_Offline_Content               [RSLocalizationManager localizedStringForKey:@"POPUP_Offline_Content"]//@"A network connection cannot be detected.  Offline content may be out of date."			
#define POPUP_Offline_Content_Unavailable   [RSLocalizationManager localizedStringForKey:@"POPUP_Offline_Content_Unavailable"]//@"A network connection cannot be detected. Content not available in offline mode."			

#define POPUP_Meeting_Data_Unavailable      [RSLocalizationManager localizedStringForKey:@"POPUP_Meeting_Data_Unavailable"]//You have no group meetings to display"


#define POPUP_Invalid_Email                 [RSLocalizationManager localizedStringForKey:@"POPUP_Invalid_Email"]//Invalid Email Address and/or Password"
#define POPUP_Invalid_Request               [RSLocalizationManager localizedStringForKey:@"POPUP_Invalid_Request"]//Invalid request. Missing reservation or customer credentials."
#define POPUP_Invalid_GuestPin              [RSLocalizationManager localizedStringForKey:@"POPUP_Invalid_GuestPin"]//Invalid guest pin for PMSFolioId"
#define POPUP_Invalid_FolioId               [RSLocalizationManager localizedStringForKey:@"POPUP_Invalid_FolioId"]//Invalid PMSFolioId"
#define POPUP_Start_End_Date                [RSLocalizationManager localizedStringForKey:@"POPUP_Start_End_Date"]//End date should be greater than Start date"
#define POPUP_Enter_Date                    [RSLocalizationManager localizedStringForKey:@"POPUP_Enter_Date"]//Please enter start date or/and end date"
#define POPUP_No_Bookings                   [RSLocalizationManager localizedStringForKey:@"POPUP_No_Bookings"]//There are no bookings for the selected date range"
#define POPUP_Server_Unavailable            [RSLocalizationManager localizedStringForKey:@"POPUP_Server_Unavailable"]//Server not available. Please try again later."
#define POPUP_No_Network                    [RSLocalizationManager localizedStringForKey:@"POPUP_No_Network"]//No network available"
#define POPUP_Select_Service                [RSLocalizationManager localizedStringForKey:@"POPUP_Select_Service"]//Please select service first"
#define POPUP_Select_Date                   [RSLocalizationManager localizedStringForKey:@"POPUP_Select_Date"]//Please select date first"
#define POPUP_Activity_Data_Unavailable     [RSLocalizationManager localizedStringForKey:@"POPUP_Activity_Data_Unavailable"]//No data available for requested activity"
#define POPUP_Service_Unavailable           [RSLocalizationManager localizedStringForKey:@"POPUP_Service_Unavailable"]//Requested service is not available. Please select an alternative day or time."
#define POPUP_Class_Already_Booked          [RSLocalizationManager localizedStringForKey:@"POPUP_Class_Already_Booked"]//You are already booked for a class or service during the requested date and time. Please select another date and/or time."
#define POPUP_Change_Search                 [RSLocalizationManager localizedStringForKey:@"POPUP_Change_Search"]//No available appointments. Change your search criteria and try again."

#define POPUP_Tee_Times                     [RSLocalizationManager localizedStringForKey:@"POPUP_Tee_Times"]//No tee times available"
#define POPUP_Tee_Times_Text                [RSLocalizationManager localizedStringForKey:@"POPUP_Tee_Times_Text"]//Please select another time"

#define POPUP_Booking_Unavailable           [RSLocalizationManager localizedStringForKey:@"POPUP_Booking_Unavailable"]//You have no bookings to display"

#define POPUP_Button_Ok                     [RSLocalizationManager localizedStringForKey:@"POPUP_Button_Ok"]//Ok"
#define POPUP_Button_Cancel                 [RSLocalizationManager localizedStringForKey:@"POPUP_Button_Cancel"]//Cancel"

#define kPOPUP_Guarantee_Required       [RSLocalizationManager localizedStringForKey:@"kPOPUP_Guarantee_Required"]//Please contact us with your credit card information in order to guarantee your booking first."
/********************************************************************/
#pragma Mark - Error Codes
#define kGuaranteeRequiredErrorId    1010


/********************************************************************/
#pragma Mark - Account Views Title
enum accountCount
{
    zeroAccount = 0,
    oneAccount = 1
};

#define AccountList_ViewTilte                   [RSLocalizationManager localizedStringForKey:@"AccountList_ViewTilte"]//Account's List"
#define Club_MyActivity                         [RSLocalizationManager localizedStringForKey:@"Club_MyActivity"]//My Activity"
#define ChargeDetail_ViewTilte                  [RSLocalizationManager localizedStringForKey:@"ChargeDetail_ViewTilte"]//Charge Detail"
#define BillingPeriod_ViewTilte                 [RSLocalizationManager localizedStringForKey:@"BillingPeriod_ViewTilte"]//Billing Periods"
#define BillingPeriod_Current                   [RSLocalizationManager localizedStringForKey:@"BillingPeriod_Current"]//Current"
#define BillingPeriod_Last                      [RSLocalizationManager localizedStringForKey:@"BillingPeriod_Last"]//Last"
#define BillingPeriod_Previous                  [RSLocalizationManager localizedStringForKey:@"BillingPeriod_Previous"]//Previous"

#define StatementOptions_ViewTilte              [RSLocalizationManager localizedStringForKey:@"StatementOptions_ViewTilte"]//Statement Options"
#define PreviousBilling_ViewTilte               [RSLocalizationManager localizedStringForKey:@"PreviousBilling_ViewTilte"]//Previous Billing Periods"
#define Club_ViewProfile                        [RSLocalizationManager localizedStringForKey:@"Club_ViewProfile"]//View Profile"
#define Club_ViewStatement                      [RSLocalizationManager localizedStringForKey:@"Club_ViewStatement"]//View Statement"

#define Club_Profile                            [RSLocalizationManager localizedStringForKey:@"Club_Profile"]//Profile"

#define Club_Summary                            [RSLocalizationManager localizedStringForKey:@"Club_Summary"]//Summary"
#define Club_Charges                            [RSLocalizationManager localizedStringForKey:@"Club_Charges"]//Charges"
#define Club_Payments                           [RSLocalizationManager localizedStringForKey:@"Club_Payments"]//Payments"


//Summary page screen text
#define AccountSummaryDetailHeader                  [RSLocalizationManager localizedStringForKey:@"AccountSummaryDetailHeader"]//Account Details"
#define AccountSummaryHeader                        [RSLocalizationManager localizedStringForKey:@"AccountSummaryHeader"]//Account Summary"
#define AccountAgedBalanceHeader                    [RSLocalizationManager localizedStringForKey:@"AccountAgedBalanceHeader"]//Aged Balance Summary"

#define AccountNumber                               [RSLocalizationManager localizedStringForKey:@"AccountNumber"]//Account #:"
#define AccountType                                 [RSLocalizationManager localizedStringForKey:@"AccountType"]//Account Type:"
#define AccountQwner                                [RSLocalizationManager localizedStringForKey:@"AccountQwner"]//Account Owner:"
#define AccountMemberShipCount                      [RSLocalizationManager localizedStringForKey:@"AccountMemberShipCount"]//Member #:"
#define AccountMemberShipID                         [RSLocalizationManager localizedStringForKey:@"AccountMemberShipID"]//Member Id:"
#define AccountMemberShipLevel                      [RSLocalizationManager localizedStringForKey:@"AccountMemberShipLevel"]//Member Level:"

#define AccountStatementperiod                      [RSLocalizationManager localizedStringForKey:@"AccountStatementperiod"]//Statement Period:"
#define AccountpreviousBalance                      [RSLocalizationManager localizedStringForKey:@"AccountpreviousBalance"]//Previous Balance:"
#define AccountPayments                             [RSLocalizationManager localizedStringForKey:@"AccountPayments"]//Payments:"
#define AccountNewCharges                           [RSLocalizationManager localizedStringForKey:@"AccountNewCharges"]//New Charges:"
#define AccountBalance                              [RSLocalizationManager localizedStringForKey:@"AccountBalance"]//Account Balance:"

#define AccountCurrentBalance                       [RSLocalizationManager localizedStringForKey:@"AccountCurrentBalance"]//Current Balance:"
#define AccountCurrent30dayBalance                  [RSLocalizationManager localizedStringForKey:@"AccountCurrent30dayBalance"]//30 Day Balance:"
#define AccountCurrent60dayBalance                  [RSLocalizationManager localizedStringForKey:@"AccountCurrent60dayBalance"]//60 Day Balance:"
#define AccountCurrent90dayBalance                  [RSLocalizationManager localizedStringForKey:@"AccountCurrent90dayBalance"]//90 Day Balance:"

//profile screen

#define AccountDetailHeader                     [RSLocalizationManager localizedStringForKey:@"AccountDetailHeader"]//Account Details"
#define CurrentMembershipHeader                 [RSLocalizationManager localizedStringForKey:@"CurrentMembershipHeader"]//Current Memberships"
#define AccountCustomerHeader                   [RSLocalizationManager localizedStringForKey:@"AccountCustomerHeader"]//Account Customers"

#define AccountNoStaticText                     [RSLocalizationManager localizedStringForKey:@"AccountNoStaticText"]//Account #:"
#define AccountTypeStaticText                   [RSLocalizationManager localizedStringForKey:@"AccountTypeStaticText"]//Account Type:"
#define AccountOwnerStaticText                  [RSLocalizationManager localizedStringForKey:@"AccountOwnerStaticText"]//Account Owner:"
#define AccountMemberNoStaticText               [RSLocalizationManager localizedStringForKey:@"AccountMemberNoStaticText"]//Member #:"
#define AccountMemberIDStaticText               [RSLocalizationManager localizedStringForKey:@"AccountMemberIDStaticText"]//Member Id:"
#define AccountMemberLevelStaticText            [RSLocalizationManager localizedStringForKey:@"AccountMemberLevelStaticText"]//Member Level:"
#define AccountAddressStaticText                [RSLocalizationManager localizedStringForKey:@"AccountAddressStaticText"]//Address:"
#define AccountPhoneStaticText                  [RSLocalizationManager localizedStringForKey:@"AccountPhoneStaticText"]//Phone:"
#define AccountEmailAddressStaticText           [RSLocalizationManager localizedStringForKey:@"AccountEmailAddressStaticText"]//Email Address:"

#define MembershipType                          [RSLocalizationManager localizedStringForKey:@"MembershipType"]//Type:"
#define MembershipName                          [RSLocalizationManager localizedStringForKey:@"MembershipName"]//Member:"
#define MembershipStatus                        [RSLocalizationManager localizedStringForKey:@"MembershipStatus"]//Status:"
#define MembershipEffectiveDate                 [RSLocalizationManager localizedStringForKey:@"MembershipEffectiveDate"]//Effective Date:"
#define MembershipExpiryDate                    [RSLocalizationManager localizedStringForKey:@"MembershipExpiryDate"]//Expiry Date:"

#define AccountName                             [RSLocalizationManager localizedStringForKey:@"AccountName"]//Name:"
#define AccountMemberShipLevel                  [RSLocalizationManager localizedStringForKey:@"AccountMemberShipLevel"]//Member Level:"

//charge and payment
#define Charge_PaymentDateTitle         [RSLocalizationManager localizedStringForKey:@"Charge_PaymentDateTitle"]//Date"
#define Charge_PaymentAmountTitle       [RSLocalizationManager localizedStringForKey:@"Charge_PaymentAmountTitle"]//Amount"
#define ChargeDescriptionTitle          [RSLocalizationManager localizedStringForKey:@"ChargeDescriptionTitle"]//Description"
#define PaymentTypeTitle                [RSLocalizationManager localizedStringForKey:@"PaymentTypeTitle"]//Payment Type"

#define TotalChargeText     [RSLocalizationManager localizedStringForKey:@"TotalChargeText"]//Total Charge"
#define TotalPaymentText    [RSLocalizationManager localizedStringForKey:@"TotalPaymentText"]//Total Payment"

//account statement option labels
#define AccOption_Chargesection_Title       [RSLocalizationManager localizedStringForKey:@"AccOption_Chargesection_Title"]//Account Charges"
#define AccOption_Paymentsection_Title      [RSLocalizationManager localizedStringForKey:@"AccOption_Paymentsection_Title"]//Account Payments"
#define AccOption_Accountnum                [RSLocalizationManager localizedStringForKey:@"AccOption_Accountnum"]//Account #:"
#define AccOption_AccountType               [RSLocalizationManager localizedStringForKey:@"AccOption_AccountType"]//Account Type:"
#define AccOption_AccountOwner              [RSLocalizationManager localizedStringForKey:@"AccOption_AccountOwner"]//Account Owner:"
#define AccOption_StatementPeriod           [RSLocalizationManager localizedStringForKey:@"AccOption_StatementPeriod"]//Statement Period:"
/********************************************************************/
#pragma Mark - My Itinerary/Group Views Title

#define MyItitnerary_ViewTite                   [RSLocalizationManager localizedStringForKey:@"MyItitnerary_ViewTite"]//My Itinerary"
#define AllFutureBooking_CellTitle              [RSLocalizationManager localizedStringForKey:@"AllFutureBooking_CellTitle"]//All Future Bookings"
#define SpecificDate_CellTitle                  [RSLocalizationManager localizedStringForKey:@"SpecificDate_CellTitle"]//Specific Dates"
#define SelectDates_ViewTitle                   [RSLocalizationManager localizedStringForKey:@"SelectDates_ViewTitle"]//Select Dates"
#define SelectDuration_viewTitle                [RSLocalizationManager localizedStringForKey:@"SelectDuration_viewTitle"]//Select Duration"

#define ItineraryCategory_ByDate                [RSLocalizationManager localizedStringForKey:@"ItineraryCategory_ByDate"]//By Date"
#define ItineraryCategory_ByCategory            [RSLocalizationManager localizedStringForKey:@"ItineraryCategory_ByCategory"]//By Category"
#define ItineraryCategory_ByAll                 [RSLocalizationManager localizedStringForKey:@"ItineraryCategory_ByAll"]//All"
//#pragma Mark - My Group Views Title
#define MyGroup_ViewTilte                       [RSLocalizationManager localizedStringForKey:@"MyGroup_ViewTilte"]//My Group"
//Duration selection in group and Itinerary
#define DurationSelection_Start     [RSLocalizationManager localizedStringForKey:@"DurationSelection_Start"]//Starts"
#define DurationSelection_Ends      [RSLocalizationManager localizedStringForKey:@"DurationSelection_Ends"]//Ends"
//Itinerary desccription view labels
#define Hotel_Reservation           [RSLocalizationManager localizedStringForKey:@"Hotel_Reservation"]//Reservation :"
#define Hotel_Arival_Date           [RSLocalizationManager localizedStringForKey:@"Hotel_Arival_Date"]//Arival Date :"
#define Hotel_Departure_Date        [RSLocalizationManager localizedStringForKey:@"Hotel_Departure_Date"]//Departure Date :"
#define Hotel_Total_Guest           [RSLocalizationManager localizedStringForKey:@"Hotel_Total_Guest"]//Total Guest(s) :"
#define Hotel_Room_Number           [RSLocalizationManager localizedStringForKey:@"Hotel_Room_Number"]//Room Number :"

#define Spa_Location            [RSLocalizationManager localizedStringForKey:@"Spa_Location"]//Location :"
#define Spa_Service             [RSLocalizationManager localizedStringForKey:@"Spa_Service"]//Service :"
#define Spa_Time                [RSLocalizationManager localizedStringForKey:@"Spa_Time"]//Time :"
#define Spa_Performed_By        [RSLocalizationManager localizedStringForKey:@"Spa_Performed_By"]//Performed By :"
#define Spa_Room                [RSLocalizationManager localizedStringForKey:@"Spa_Room"]//Room :"
#define Spa_Description         [RSLocalizationManager localizedStringForKey:@"Spa_Description"]//Description :"
#define Spa_Client_instruction  [RSLocalizationManager localizedStringForKey:@"Spa_Client_instruction"]//Client                   Instructions :"

#define Golf_Course             [RSLocalizationManager localizedStringForKey:@"Golf_Course"]//Course :"
#define Golf_Tee_Time           [RSLocalizationManager localizedStringForKey:@"Golf_Tee_Time"]//Tee-Time :"

#define Dining_Venue			[RSLocalizationManager localizedStringForKey:@"Dining_Venue"]//Venue :"
#define Dining_Time             [RSLocalizationManager localizedStringForKey:@"Dining_Time"]//Time :"
#define Dining_detail           [RSLocalizationManager localizedStringForKey:@"Dining_detail"]//detail :"

#define Transportation_Departure_location		[RSLocalizationManager localizedStringForKey:@"Transportation_Departure_location"]//Departure Location :"
#define Transportation_Departure_Time           [RSLocalizationManager localizedStringForKey:@"Transportation_Departure_Time"]//Departure Time :"
#define Transportation_Arrival_Location         [RSLocalizationManager localizedStringForKey:@"Transportation_Arrival_Location"]//Arrival Location :"
#define Transportation_Arrival_Time             [RSLocalizationManager localizedStringForKey:@"Transportation_Arrival_Time"]//Arrival Time :"
//group Table
#define GroupTableViewTitle                     [RSLocalizationManager localizedStringForKey:@"GroupTableViewTitle"]//Group Events"
//event description view
#define GroupEventDesc_viewTitle                [RSLocalizationManager localizedStringForKey:@"GroupEventDesc_viewTitle"]//Event Details"

#define GroupEventDesc_EventLbl                 [RSLocalizationManager localizedStringForKey:@"GroupEventDesc_EventLbl"]//Event"
#define GroupEventDesc_LocationLbl              [RSLocalizationManager localizedStringForKey:@"GroupEventDesc_LocationLbl"]//Location"
#define GroupEventDesc_DateLbl                  [RSLocalizationManager localizedStringForKey:@"GroupEventDesc_DateLbl"]//Date"
#define GroupEventDesc_TimeLbl                  [RSLocalizationManager localizedStringForKey:@"GroupEventDesc_TimeLbl"]//Time"

/********************************************************************/
#pragma Mark - Booking Views Title
#define NoBookingTitle   [RSLocalizationManager localizedStringForKey:@"NoBookingTitle"]//"
#define NoBookingMessage [RSLocalizationManager localizedStringForKey:@"NoBookingMessage"]//We are currently not accepting mobile reservation at this time."

#define Book_ViewTilte      [RSLocalizationManager localizedStringForKey:@"Book_ViewTilte"]//Book Menu"
#define GolfLocation_ViewTilte                [RSLocalizationManager localizedStringForKey:@"GolfLocation_ViewTilte"]//Golf Locations"
#define GolfCourse_ViewTilte                  [RSLocalizationManager localizedStringForKey:@"GolfCourse_ViewTilte"]//Golf Course"
#define BookGolf_ViewTilte                    [RSLocalizationManager localizedStringForKey:@"BookGolf_ViewTilte"]//Book Golf"
#define SpaAvailableTimes                     [RSLocalizationManager localizedStringForKey:@"SpaAvailableTimes"]//Available Times"
//
#define ClassActivityCellText                 [RSLocalizationManager localizedStringForKey:@"ClassActivityCellText"]//Class/Activity"
//spa booking form cell text
#define SpaBookingFormService       [RSLocalizationManager localizedStringForKey:@"SpaBookingFormService"]//Service"
#define SpaBookingFormDate          [RSLocalizationManager localizedStringForKey:@"SpaBookingFormDate"]//Date"
#define SpaBookingFormTime          [RSLocalizationManager localizedStringForKey:@"SpaBookingFormTime"]//Time"
#define SpaBookingFormStafGender    [RSLocalizationManager localizedStringForKey:@"SpaBookingFormStafGender"]//Pref. Staff Gender"
#define SpaBookingFormStaff         [RSLocalizationManager localizedStringForKey:@"SpaBookingFormStaff"]//Pref. Staff"
#define SpaBookingNoPref            [RSLocalizationManager localizedStringForKey:@"SpaBookingNoPref"]//No Pref."

#define SpaBookingStaffMale         [RSLocalizationManager localizedStringForKey:@"SpaBookingStaffMale"]//Male"
#define SpaBookingStaffFemale       [RSLocalizationManager localizedStringForKey:@"SpaBookingStaffFemale"]//Female"
//Spa service table view
#define SpaServiceTable_HeaderTitle     [RSLocalizationManager localizedStringForKey:@"SpaServiceTable_HeaderTitle"]//Search result"

#define SpaServiceTableCol_ServiceLbl   [RSLocalizationManager localizedStringForKey:@"SpaServiceTableCol_ServiceLbl"]//Service"
#define SpaServiceTableCol_PriceLbl     [RSLocalizationManager localizedStringForKey:@"SpaServiceTableCol_PriceLbl"]//Price"
#define SpaServiceTableCol_TimeLbl      [RSLocalizationManager localizedStringForKey:@"SpaServiceTableCol_TimeLbl"]//Time (min)"
//Class service table view
#define ClassServiceTableCol_StartTimeLbl       [RSLocalizationManager localizedStringForKey:@"ClassServiceTableCol_StartTimeLbl"]//Start Time"
#define ClassServiceTableCol_PriceLbl           [RSLocalizationManager localizedStringForKey:@"ClassServiceTableCol_PriceLbl"]//Price"
#define ClassServiceTableCol_TimeLbl            [RSLocalizationManager localizedStringForKey:@"ClassServiceTableCol_TimeLbl"]//Time (min)"
//Spa Service Desc View labels
#define SpaServiceDesc_TitleHeader          [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_TitleHeader"]//Service"

#define SpaServiceDesc_serviceLbl           [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_serviceLbl"]//Service :"
#define SpaServiceDesc_DescriptionLbl       [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_DescriptionLbl"]//Description :"
#define SpaServiceDesc_DurationLbl          [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_DurationLbl"]//Duration(min) :"
#define SpaServiceDesc_PriceLbl             [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_PriceLbl"]//Price :"
#define SpaServiceDesc_ClientInstructionLbl [RSLocalizationManager localizedStringForKey:@"SpaServiceDesc_ClientInstructionLbl"]//Client                   Instructions :"
//Class Service Desc View Labels
#define ClassServiceDesc_DescriptionLbl         [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_DescriptionLbl"]//Description :"
#define ClassServiceDesc_NoOfClassLbl           [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_NoOfClassLbl"]//# of Classes :"
#define ClassServiceDesc_StartTimeLbl           [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_StartTimeLbl"]//Start Time :"
#define ClassServiceDesc_DurationLbl            [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_DurationLbl"]//Duration(min) :"
#define ClassServiceDesc_PriceLbl               [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_PriceLbl"]//Price :"
#define ClassServiceDesc_ClientInstructionLbl   [RSLocalizationManager localizedStringForKey:@"ClassServiceDesc_ClientInstructionLbl"]//Client                   Instructions :"
//spa service confirmation view text
#define SpaConfirmationView_Service         [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Service"]//Service:"
#define SpaConfirmationView_Date            [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Date"]//Date:"
#define SpaConfirmationView_Time            [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Time"]//Time:"
#define SpaConfirmationView_Duration        [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Duration"]//Duration(min):"
#define SpaConfirmationView_Price           [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Price"]//Price:"
#define SpaConfirmationView_Description     [RSLocalizationManager localizedStringForKey:@"SpaConfirmationView_Description"]//Description:"
//Class Service Confirmation view text
#define ClassConfirmationView_Service           [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_Service"]//Class/Activity :"
#define ClassConfirmationView_NoOfClass         [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_NoOfClass"]//# of Classes :"
#define ClassConfirmationView_StartTime         [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_StartTime"]//Start Time :"
#define ClassConfirmationView_Date              [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_Date"]//Date :"
#define ClassConfirmationView_Duration          [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_Duration"]//Duration(min) :"
#define ClassConfirmationView_Price             [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_Price"]//Price :"
#define ClassConfirmationView_Description       [RSLocalizationManager localizedStringForKey:@"ClassConfirmationView_Description"]//Description :"
//Golf Booking Form
#define GolfBookingFormDate                     [RSLocalizationManager localizedStringForKey:@"GolfBookingFormDate"]//Date" 
#define GolfBookingFormPrefTeeTime              [RSLocalizationManager localizedStringForKey:@"GolfBookingFormPrefTeeTime"]//Pref. Tee Time" 
#define GolfBookingFormNoOfPlayer               [RSLocalizationManager localizedStringForKey:@"GolfBookingFormNoOfPlayer"]//No. of Player"
#define ConfirmGolfBookDetailheader             [RSLocalizationManager localizedStringForKey:@"ConfirmGolfBookDetailheader"]//Confirm Detail And Book Now"

//
#define ConfirmBooking_ViewTilte              [RSLocalizationManager localizedStringForKey:@"ConfirmBooking_ViewTilte"]//Confirm Booking"
#define pleaseSelectText                      [RSLocalizationManager localizedStringForKey:@"pleaseSelectText"]//   Please select"
#define searchResultText                      [RSLocalizationManager localizedStringForKey:@"searchResultText"]//  Search Results"
#define SpaAvailableTimeText                  [RSLocalizationManager localizedStringForKey:@"SpaAvailableTimeText"]//The requested time slot is not available,  Please select the following alternate time."
//golf select players
#define NoOfPlayerCellText          [RSLocalizationManager localizedStringForKey:@"NoOfPlayerCellText"]//No Of Players"
#define DefaultNoOfPlayers          [RSLocalizationManager localizedStringForKey:@"DefaultNoOfPlayers"]//2"
/********************************************************************/
#pragma mark - Login action sheet view
#define loginOption_screen_title            [RSLocalizationManager localizedStringForKey:@"loginOption_screen_title"]//Sign In"
#define LOGOUT_SCREEN_TITLE                 [RSLocalizationManager localizedStringForKey:@"LOGOUT_SCREEN_TITLE"]//Sign Out"
#define VERIFY_EMAIL_VIEW_TITLE             [RSLocalizationManager localizedStringForKey:@"VERIFY_EMAIL_VIEW_TITLE"]//Verify Email"
#define CHANGE_PASSWORD_VIEW_TITLE          [RSLocalizationManager localizedStringForKey:@"CHANGE_PASSWORD_VIEW_TITLE"]//Change Password"
#define FORGOT_PASSWORD_VIEW_TITLE          [RSLocalizationManager localizedStringForKey:@"FORGOT_PASSWORD_VIEW_TITLE"]//Forgot Password"

/********************************************************************/
#pragma mark - user registration screen alert messages

#define ALERT_OK_TITLE                      [RSLocalizationManager localizedStringForKey:@"ALERT_OK_TITLE"]//OK"

// Validation variables
#define PASSWORD_REQ_LENGTH                 8
#define alertTitleForInvalidText            [RSLocalizationManager localizedStringForKey:@"alertTitleForInvalidText"]//Enter valid Information"
#define alertMessageForInvalidText          [RSLocalizationManager localizedStringForKey:@"alertMessageForInvalidText"]//Field cannot be empty"

#define alertTitleForEmptyGender            [RSLocalizationManager localizedStringForKey:@"alertTitleForEmptyGender"]//"
#define alertMessageForEmptyGender          [RSLocalizationManager localizedStringForKey:@"alertMessageForEmptyGender"]//Please enter your Gender"

#define alertTitleForValidSalutation        [RSLocalizationManager localizedStringForKey:@"alertTitleForValidSalutation"]//"
#define alertMessageForValidSalutation      [RSLocalizationManager localizedStringForKey:@"alertMessageForValidSalutation"]//Please enter appropriate salutation"

#define alertTitleForInvalidEmailAddress            [RSLocalizationManager localizedStringForKey:@"alertTitleForInvalidEmailAddress"]//Invalid Email Address"
#define alertMessageForInvalidEmailAddress          [RSLocalizationManager localizedStringForKey:@"alertMessageForInvalidEmailAddress"]//Enter a valid email address"

#define alertTitleForUnmatchedEmail                 [RSLocalizationManager localizedStringForKey:@"alertTitleForUnmatchedEmail"]//Unmatched Email Address"
#define alertMessageForUnmatchedEmail               [RSLocalizationManager localizedStringForKey:@"alertMessageForUnmatchedEmail"]//Enter the same email address for confirmation"

#define alertTitleForImproperPassord                [RSLocalizationManager localizedStringForKey:@"alertTitleForImproperPassord"]//Invalid Password"
#define alertMessageForImproperPassord              [RSLocalizationManager localizedStringForKey:@"alertMessageForImproperPassord"]//Password must be of atleast %d length" //%d represents the requird length of the password

#define alertTitleForUnmatchedPassword          [RSLocalizationManager localizedStringForKey:@"alertTitleForUnmatchedPassword"]//Password Not Confirmed"
#define alertMessageForUnmatchedPassword        [RSLocalizationManager localizedStringForKey:@"alertMessageForUnmatchedPassword"]//Enter the same Password as above"

#define alertTitleForAtleastOnePhoneNumber      [RSLocalizationManager localizedStringForKey:@"alertTitleForAtleastOnePhoneNumber"]//Contact number"
#define alertMessageForAtleastOnePhoneNumber    [RSLocalizationManager localizedStringForKey:@"alertMessageForAtleastOnePhoneNumber"]//Please enter atleast one contact number"

#define alertMessageForPassWordResset [RSLocalizationManager localizedStringForKey:@"alertMessageForPassWordResset"]//You will receive an email with your new password"

#define alertTitleForUserCreated      [RSLocalizationManager localizedStringForKey:@"alertTitleForUserCreated"]//"
#define alertMessageForUserCreated [RSLocalizationManager localizedStringForKey:@"alertMessageForUserCreated"]//Your account has been successfully created"


#pragma mark - MAPS
#define MapView_title           [RSLocalizationManager localizedStringForKey:@"MapView_title"]//Map"
#define Map_infoBUtton_title    [RSLocalizationManager localizedStringForKey:@"Map_infoBUtton_title"]//Info"

#pragma mark - booking confirmation mesasge based on Guaranteed
#define GuaranteeStatusValueForYes          [RSLocalizationManager localizedStringForKey:@"GuaranteeStatusValueForYes"]//Y"
#define GuaranteeStatusValueForNo           [RSLocalizationManager localizedStringForKey:@"GuaranteeStatusValueForNo"]//N"
#define GuaranteedBookingMessage            [RSLocalizationManager localizedStringForKey:@"GuaranteedBookingMessage"]//Booking Confirmed - Your booking is successful. To make another booking, please select another from below:"
#define UnGuaranteedBookingMessage          [RSLocalizationManager localizedStringForKey:@"UnGuaranteedBookingMessage"]//A tentative booking has been made for you. To confirm your booking kindly contact us to provide us with your credit card information to guarantee your booking."