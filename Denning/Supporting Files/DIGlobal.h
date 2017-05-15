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

#define PUBLIC_KEYWORD_SEARCH_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch/keyword?search="

#define PUBLIC_SEARCH_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch?search="

#define UPATES_LATEST_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningUpdate"

#define NEWS_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningNews"

#define EVENT_LATEST_URL        @"denningwcf/v1/DenningCalendar"

#define GET_CHAT_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v2/chat/contact?userid="

#define PUBLIC_ADD_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"

#define PRIVATE_ADD_FAVORITE_CONTACT_URL    @"denningwcf/v1/chat/contact/fav"

#define REMOVE_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"

#define CONTACT_IDTYPE_URL  @"denningwcf/v1/IDType"

#define CONTACT_TITLE_URL   @"denningwcf/v1/Salutation"

#define CONTACT_CITY_URL    @"denningwcf/v1/city"

#define CONTACT_STATE_URL   @"denningwcf/v1/State"

#define CONTACT_COUNTRY_URL @"denningwcf/v1/Country"

#define CONTACT_POSTCODE_URL    @"denningwcf/v1/Postcode"

#define CONTACT_CITIZENSHIP_URL     @"denningwcf/v1/Citizenship"

#define CONTACT_OCCUPATION_URL  @"denningwcf/v1/Occupation"

#define CONTACT_IRDBRANCH_URL   @"denningwcf/v1/IRDBranch"

#define CONTACT_SAVE_URL    @"/denningwcf/v1/app/contact"

#define CONTACT_GETLIST_URL @"denningwcf/v1/party"

#define CONTACT_UPDATE_URL    @"/denningwcf/v1/contact"


#define MATTERSIMPLE_GET_URL @"denningwcf/v1/matter/simpleList"

#define MATTER_LIST_GET_URL    @"denningwcf/v1/matter"

#define COURT_HEARINGTYPE_GET_URL @"denningwcf/v1/courtDiary/hearingType"

#define COURT_HEARINGDETAIL_GET_URL @"denningwcf/v1/courtDiary/hearingDetails"

#define COURT_ATTENDED_STATUS_GET_URL @"denningwcf/v1/generalSelection/frmCourtDiary/attendedStatus"

#define COURT_CORAM_GET_URL @"denningwcf/v1/courtDiary/coram"

#define COURT_DECISION_GET_URL  @"denningwcf/v1/courtDiary/decision"

#define COURT_NEXTDATE_TYPE_GET_URL @"denningwcf/v1/generalSelection/frmCourtDiary/nextDateType"

#define COURT_SAVE_UPATE_URL  @"denningwcf/v1/CourtDiary"

#define COURT_COUNSEL_GET_URL   @"denningwcf/v1/Staff?type=attest"


#define STAFF_ATTEST_GET_URL    @"denningwcf/v1/Staff?type=attest"

#define STAFF_CLERK_GET_URL     @"denningwcf/v1/Staff?type=clerk"

#define STAFF_LA_GET_URL        @"denningwcf/v1/Staff?type=la"

#define STAFF_PARTNER_GET_URL   @"denningwcf/v1/Staff?type=partner"


#define PROPERTY_TYPE_GET_URL   @"denningwcf/v1/Property/PropertyType"

#define PROPERTY_TITLE_ISSUED_GET_URL   @"denningwcf/v1/Property/TitleIssued"

#define PROPERTY_TITLE_TYPE_GET_URL     @"denningwcf/v1/Property/TitleType"

#define PROPERTY_LOT_TYPE_GET_URL   @"denningwcf/v1/Property/LotType"

#define PROPERTY_MUKIM_TYPE_GET_URL     @"denningwcf/v1/Property/MukimType"

#define PROPERTY_AREA_TYPE_GET_URL  @"denningwcf/v1/Property/AreaType"

#define PROPERTY_TENURE_TYPE_GET_URL    @"denningwcf/v1/Property/TenureType"

#define PROPERTY_RESTRICTION_GET_URL    @""

#define PROPERTY_RESTRICTION_AGAINST_GET_URL    @"denningwcf/v1/Property/RestrictionAgainst"

#define PROPERTY_CONDUSE_GET_URL    @""

#define PROPERTY_PROJECT_HOUSING_GET_URL    @"denningwcf/v1/HousingProject"

#define PROPERTY_SAVE_URL   @""

#define PROPERTY_UPDATE_URL @""

#define PRESET_BILL_GET_URL @"denningwcf/v1/PresetBill"

#define REPORT_VIEWER_PDF_QUATION_URL   @"denningwcf/v1/ReportViewer/pdf/TaxInvoice/"

#define TAXINVOICE_CALCULATION_URL  @"denningwcf/v1/Calculation/Invoice/draft"

#define QUOTATION_SAVE_URL  @"denningwcf/v1/Quotation"
/*
 *  Notification Names
 */

#define CHANGE_FAVORITE_CONTACT    @"ChangeFavorite"

#endif /* PreHeader_h */
