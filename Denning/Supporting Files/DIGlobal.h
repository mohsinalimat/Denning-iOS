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
    AllContact          = 1,
    RelatedMatter       = 2,
    Property            = 4,
    Bank                = 8,
    GovernmentOffices   = 16,
    Document            = 64
};

typedef NS_ENUM(NSInteger, DIPublicSearchFilter) {
    PublicLawFirm           = 128,
    PublicDocment           = 256,
    PublicGovernmentOffices = 512
};

#define FORGOT_PASSWORD_SEND_SMS_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/SMS/lostPassword"

#define FORGOT_PASSWORD_REQUEST_URL     @"http://denningsoft.dlinkddns.com/denningwcf/v1/password/forget"

#define LOGIN_SEND_SMS_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/SMS/request"

#define SIGNUP_FIRM_LIST_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/Solicitor"

#define SIGNUP_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/signUp"

#define SIGNIN_URL  @"http://denningsoft.dlinkddns.com/denningwcf/v1/signIn"

#define Auth_ACTIVATION_URL @"http://denningsoft.dlinkddns.com/denningwcf/v1/signUp/activate"

#define GENERAL_KEYWORD_SEARCH_URL  @"http://121.196.213.102:9339/denningwcf/v1/generalSearch/keyword?search="

#define GENERAL_SEARCH_URL   @"http://121.196.213.102:9339/denningwcf/v1/generalSearch?search="

#define PUBLIC_KEYWORD_SEARCH_URL   @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch/keyword?search="

#define PUBLIC_SEARCH_URL    @"http://denningsoft.dlinkddns.com/denningwcf/v1/publicSearch?search="

#define NEWS_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningNews/1"

#define EVENT_LATEST_URL        @"http://denningsoft.dlinkddns.com/denningwcf/v1/DenningEvent/1"

#endif /* PreHeader_h */
