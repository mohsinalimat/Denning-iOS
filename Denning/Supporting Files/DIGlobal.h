//
//  PreHeader.h
//  Denning
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#ifndef PreHeader_h
#define PreHeader_h

// Constant for Search

typedef NS_ENUM(NSInteger, DIGeneralSearchFilter) {
    All                 = 0,
    Contact             = 1,
    RelatedMatter       = 2,
    Property            = 4,
    Bank                = 8,
    GovernmentOffices   = 16,
    LegalFirm           = 32,
    Documents            = 64
};

typedef NS_ENUM(NSInteger, DIPublicSearchFilter) {
    AllPublic               = -1,
    PublicLawFirm           = 128,
    PublicDocment           = 256,
    PublicGovernmentOffices = 512
};

#define kCountryName        @"name"
#define kCountryCallingCode @"dial_code"
#define kCountryCode        @"code"

#define HEIGHT(v)                                       v.frame.size.height
#define WIDTH(v)                                        v.frame.size.width
#define BOTTOM(v)                                       (v.frame.origin.y + v.frame.size.height)
#define AFTER(v)                                        (v.frame.origin.x + v.frame.size.width)
#define PH                                              [[UIScreen mainScreen].bounds.size.height]
#define PW                                              [[UIScreen mainScreen].bounds.size.width]

#define INNER_PADDING 10
#define SIDE_PADDING 15
#define LEGEND_VIEW 15
#define OFFSET_X 30
#define OFFSET_Y 30
#define OFFSET_PADDING 5

#define DEG2RAD(angle) angle*M_PI/180.0

#define ANIMATION_DURATION 1.5f

#define header_height 0

#define FORGOT_PASSWORD_SEND_SMS_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/SMS/lostPassword"

#define FORGOT_PASSWORD_REQUEST_URL     @"http://denningsoft.dlinkddns.com/denningwcf/v1/password/forget"

#define CHANGE_PASSWORD_URL     @"http://denningsoft.dlinkddns.com/denningwcf/v1/password/new"

#define LOGIN_SEND_SMS_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/SMS/request"

#define NEW_DEVICE_SEND_SMS_URL     @"http://denningsoft.dlinkddns.com/denningwcf/v1/SMS/newDevice"

#define DENNING_SIGNIN_URL  @"/denningwcf/v1/app/staffLogin"

#define DENNING_CLIENT_SIGNIN @"denningwcf/v1/app/clientLogin"

#define DENNING_CLIENT_FIRST_SIGNIN @"denningwcf/v1/app/clientLogin/first"

#define SIGNUP_FIRM_LIST_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/Solicitor"

#define SIGNUP_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/signUp"

#define SIGNIN_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/signIn"

#define Auth_ACTIVATION_URL @"http://denningsoft.dlinkddns.com/denningwcf/v1/signUp/activate"

#define GENERAL_KEYWORD_SEARCH_URL  @"denningwcf/v1/generalSearch/keyword?search="

#define GENERAL_SEARCH_URL   @"denningwcf/v1/generalSearch?search="

#define GENERAL_SEARCH_URL_V2   @"denningwcf/v2/generalSearch?search="

#define SEARCH_UPLOAD_SUGGESTED_FILENAME    @"denningwcf/v1/table/cboDocumentName?search="

#define PUBLIC_KEYWORD_SEARCH_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch/keyword?search="

#define PUBLIC_SEARCH_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch?search="

#define UPATES_LATEST_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningUpdate"

#define NEWS_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningNews"

#define EVENT_LATEST_URL        @"denningwcf/v1/DenningCalendar"

#define CALENDAR_MONTHLY_SUMMARY_URL    @"denningwcf/v1/DenningCalendar/MonthlySummary"

#define HOME_ADS_GET_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/advertisement"

#define GET_CHAT_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v2/chat/contact?userid="

#define PUBLIC_ADD_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"

#define PRIVATE_ADD_FAVORITE_CONTACT_URL    @"denningwcf/v1/chat/contact/fav"

#define REMOVE_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"

#define CONTACT_ID_DUPLICATE    @"denningwcf/v1/generalSearch?category=1&isAutoComplete=1&search="

#define CONTACT_NAME_DUPLICATE  @"denningwcf/v1/generalSearch?category=1&isAutoComplete=1&search="

#define CONTACT_IDTYPE_URL  @"denningwcf/v1/IDType?search="

#define CONTACT_TITLE_URL   @"denningwcf/v1/Salutation?search="

#define CONTACT_CITY_URL    @"denningwcf/v1/city?search="

#define CONTACT_STATE_URL   @"denningwcf/v1/State?search="

#define CONTACT_COUNTRY_URL @"denningwcf/v1/Country?search="

#define CONTACT_POSTCODE_URL    @"denningwcf/v1/Postcode?search="

#define CONTACT_CITIZENSHIP_URL     @"denningwcf/v1/Citizenship?search="

#define CONTACT_OCCUPATION_URL  @"denningwcf/v1/Occupation?search="

#define CONTACT_IRDBRANCH_URL   @"denningwcf/v1/IRDBranch?search="

#define CONTACT_SAVE_URL    @"/denningwcf/v1/app/contact"

#define CONTACT_GETLIST_URL @"denningwcf/v1/party?search="

#define CONTACT_SOLICITOR_GET_LIST_URL   @"denningwcf/v1/Solicitor?search="

#define CONTACT_UPDATE_URL    @"/denningwcf/v1/contact?search="


#define MATTERSIMPLE_GET_URL @"denningwcf/v1/matter/simpleList?search="

#define MATTER_FILEFOLDER @"denningwcf/v1/app/matter/fileFolder"

#define MATTER_FILE_STATUS_GET_LIST_URL @"denningwcf/v1/FileStatus?search="

#define MATTER_LIST_GET_URL    @"denningwcf/v1/matter?search="

#define MATTER_LITIGATION_GET_LIST_URL @"denningwcf/v1/matter/litigationCase?search="

#define MATTER_SAVE_URL @"denningwcf/v1/app/matter"

#define COURT_HEARINGTYPE_GET_URL @"denningwcf/v1/courtDiary/hearingType?search="

#define COURTDIARY_GET_LIST_URL @"denningwcf/v1/courtDiary/court?search="


#define COURT_HEARINGDETAIL_GET_URL @"denningwcf/v1/courtDiary/hearingDetails?search="

#define COURT_OFFICE_APPOINTMENT_GET_LIST_URL   @"denningwcf/v1/OfficeDiary/AppointmentDetails?search="

#define COURT_OFFICE_PLACE_GET_LIST_URL @"denningwcf/v1/OfficeDiary/AppointmentPlace?search="

#define COURT_ATTENDED_STATUS_GET_URL @"denningwcf/v1/generalSelection/frmCourtDiary/attendedStatus?search="

#define COURT_PERSONAL_PLACE_GET_LIST_URL   @"denningwcf/v1/PersonalDiary/AppointmentPlace?search="

#define COURT_PERSONAL_DETAIL_GET_LIST_URL  @"denningwcf/v1/PersonalDiary/AppointmentDetails?search="

#define COURT_CORAM_GET_LIST_URL @"denningwcf/v1/courtDiary/coram?search="

#define COURT_DECISION_GET_URL  @"denningwcf/v1/courtDiary/decision?search="

#define COURT_NEXTDATE_TYPE_GET_URL @"denningwcf/v1/generalSelection/frmCourtDiary/nextDateType?search="

#define COURT_SAVE_UPATE_URL  @"denningwcf/v1/CourtDiary"

#define OFFICE_DIARY_SAVE_URL   @"denningwcf/v1/OfficeDiary"

#define PERSONAL_DIARY_SAVE_URL @"denningwcf/v1/PersonalDiary"

#define COURT_COUNSEL_GET_URL   @"denningwcf/v1/Staff?type=attest"

#define STAFF_GET_URL @"denningwcf/v1/Staff?type="

#define STAFF_ATTEST_GET_URL    @"denningwcf/v1/Staff?type=attest"

#define STAFF_CLERK_GET_URL     @"denningwcf/v1/Staff?type=clerk"

#define STAFF_LA_GET_URL        @"denningwcf/v1/Staff?type=la"

#define STAFF_PARTNER_GET_URL   @"denningwcf/v1/Staff?type=partner"

#define PROPERTY_GET_LIST_URL   @"denningwcf/v1/Property?search="

#define PROPERTY_TYPE_GET_URL   @"denningwcf/v1/Property/PropertyType?search="

#define PROPERTY_TYPE_GET_LIST_URL   @"denningwcf/v1/generalSelection/frmProperty/propertyType?search="

#define PROPERTY_TITLE_ISSUED_GET_URL   @"denningwcf/v1/generalSelection/frmProperty/TitleIssued?search="

#define PROPERTY_TITLE_TYPE_GET_URL     @"denningwcf/v1/Property/TitleType?search="

#define PROPERTY_LOT_TYPE_GET_URL   @"denningwcf/v1/Property/LotType?search="

#define PROPERTY_MUKIM_TYPE_GET_URL     @"denningwcf/v1/Property/MukimType?search="

#define PROPERTY_MUKIM_GET_LIST_URL @"denningwcf/v1/Mukim?search="

#define PROPERTY_AREA_TYPE_GET_URL  @"denningwcf/v1/Property/AreaType?search="

#define PROPERTY_TENURE_TYPE_GET_URL    @"denningwcf/v1/Property/TenureType?search="

#define PROPERTY_RESTRICTION_GET_URL    @"denningwcf/v1/generalSelection/frmProperty/restrictionInInterest?search="

#define PROPERTY_RESTRICTION_AGAINST_GET_URL    @"denningwcf/v1/Property/RestrictionAgainst?search="

#define PROPERTY_APPROVING_AUTHORITY_GET_URL    @"denningwcf/v1/generalSelection/frmProperty/ApprovingAuthority?search="

#define PROPERTY_LANDUSE_GET_URL    @"denningwcf/v1/Property/LandUse?search="

#define PROPERTY_PROJECT_HOUSING_GET_URL    @"denningwcf/v1/HousingProject?search="

#define PROPERTY_PARCEL_TYPE_GETLIST_URL    @"denningwcf/v1/Property/ParcelType?search="

#define PROPERTY_MASTER_TITLE_GETLIST_URL   @"denningwcf/v1/Property/MasterTitle?search="

#define PROPERTY_SAVE_URL   @"denningwcf/v1/Property"

#define PROPERTY_UPDATE_URL @"denningwcf/v1/Property"

#define PRESET_BILL_GET_URL @"denningwcf/v1/PresetBill?search="

#define REPORT_VIEWER_PDF_QUATION_URL   @"denningwcf/v1/ReportViewer/pdf/Quotation/"

#define REPORT_VIEWER_PDF_TAXINVOICE_URL   @"denningwcf/v1/ReportViewer/pdf/TaxInvoice/"

#define TAXINVOICE_CALCULATION_URL  @"denningwcf/v1/Calculation/Invoice/draft"

#define QUOTATION_SAVE_URL  @"denningwcf/v1/Quotation"

#define TAXINVOICE_SAVE_URL  @"denningwcf/v1/TaxInvoice"

#define QUOTATION_GET_LIST_URL  @"denningwcf/v1/Quotation?search="

#define BANK_BRANCH_GET_LIST_URL    @"denningwcf/v1/bank/Branch?search="

#define RECEIPT_TAX_INVOICE_GET_LIST_URL    @"denningwcf/v1/TaxInvoice?FileNo="

#define RECEIPT_TRANS_DESC_GET_LIST_URL @"denningwcf/v1/account/receipt/transDesc?search="

#define ACCOUNT_TYPE_GET_LIST_URL   @"denningwcf/v1/account/type?search="

#define ACCOUNT_PAYMENT_MODE_GET_URL    @"denningwcf/v1/account/paymentMode?search="

#define ACCOUNT_CHEQUE_ISSUEER_GET_URL  @"denningwcf/v1/account/ChequeIssuerBank?search="

#define RECEIPT_SAVE_URL @"denningwcf/v1/ClientReceipt"

#define DASHBOARD_MAIN_GET_URL  @"denningwcf/v1/app/dashboard/main"

#define DASHBOARD_S1_MATTERLISTING_GET_URL @"denningwcf/v1/app/dashboard/S1"

#define DASHBOARD_S2_CONTACT_GET_URL @"denningwcf/v1/app/dashboard/S2"

#define DASHBOARD_DUE_TASK_GET_URL  @"v1/app/dashboard/spaCheckList"

#define DASHBOARD_COMPLETION_TRACKING_HEADER_GET_URL @"denningwcf/v1/app/dashboard/spaCompletionDate"

#define DASHBOARD_S10_GET_URL   @"denningwcf/v1/app/dashboard/S10"

#define DASHBOARD_S11_GET_URL   @"denningwcf/v1/app/dashboard/S11"

/*
 *  Notification Names
 */

#define CHANGE_FAVORITE_CONTACT    @"ChangeFavorite"

#endif /* PreHeader_h */
