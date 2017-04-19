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

#define PUBLIC_KEYWORD_SEARCH_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch/keyword?search="

#define PUBLIC_SEARCH_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch?search="

#define UPATES_LATEST_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningUpdate"

#define NEWS_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningNews"

#define EVENT_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningEvent"

#define GET_CHAT_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v2/chat/contact?userid="

#define PUBLIC_ADD_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"

#define PRIVATE_ADD_FAVORITE_CONTACT_URL    @"denningwcf/v1/chat/contact/fav"

#define REMOVE_FAVORITE_CONTACT_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/chat/contact/fav"


/*
 *  Notification Names
 */

#define CHANGE_FAVORITE_CONTACT    @"ChangeFavorite"

#endif /* PreHeader_h */
