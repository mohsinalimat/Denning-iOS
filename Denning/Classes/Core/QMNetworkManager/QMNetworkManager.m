//
//  QMNetworkManager.m
//  reach-ios
//
//  Created by Admin on 2016-11-30.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import "QMNetworkManager.h"
#import "QMCore.h"
#import "QMContent.h"
#import "QMMessagesHelper.h"
#import "SearchResultModel.h"
#import "NSError+Network.h"
#import "DIGlobal.h"
#import "DIHelpers.h"

@interface QMNetworkManager ()

@property(nonatomic, strong) NSURLSession *session;

@end

@implementation QMNetworkManager


+ (QMNetworkManager *)sharedManager {
    static QMNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QMNetworkManager alloc] init];
    });
    
    return manager;
}

#pragma mark -  Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        [self initManager];
        [self initVariables];
    }
    
    return self;
}

- (void) initVariables
{
    self.invalidTry = @0;
    self.selectedBaseURLForGeneral = @"http://43.252.215.163/";
}

- (void)initManager
{
    self.manager = [[AFHTTPSessionManager  alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer.timeoutInterval= 100;
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager.requestSerializer setValue:@"testdenningSkySea" forHTTPHeaderField:@"webuser-sessionid"];
    [self.manager.requestSerializer setValue:@"SkySea@denning.com.my" forHTTPHeaderField:@"webuser-id"];
    
    
    self.session = [NSURLSession sharedSession];
    
    // search datasource
    self.searchDataSource = [[APIDataSource alloc] init];
    self.searchDataSource.reqKey = @"keyword";         // your key
    self.searchDataSource.rvalue = @"score";   // Your responce value
    self.searchDataSource.api_type = APICallTypeGET;
    self.searchDataSource.requestParams = [[NSMutableDictionary alloc] init];     // Add your request parameters
}

- (void) setLoginHTTPHeader
{
    [self.manager.requestSerializer setValue:@"{334E910C-CC68-4784-9047-0F23D37C9CF9}" forHTTPHeaderField:@"webuser-sessionid"];
    [self.manager.requestSerializer setValue:@"SkySea@denning.com.my" forHTTPHeaderField:@"webuser-id"];
}

- (void) setOtherForLoginHTTPHeader
{
    [self.manager.requestSerializer setValue:@"testdenningSkySea" forHTTPHeaderField:@"webuser-sessionid"];
    [self.manager.requestSerializer setValue:@"email@com.mysdf" forHTTPHeaderField:@"webuser-id"];
}

- (NSDictionary*) buildRquestParamsFromDictionary: (NSDictionary*) dict
{
    NSDictionary* basicParams = @{
                                    @"ipWAN": [DIHelpers getWANIP],
                                    @"ipLAN": [DIHelpers getLANIP],
                                    @"OS": [DIHelpers getOSName],
                                    @"device": [DIHelpers getDevice],
                                    @"deviceName": [DIHelpers getDeviceName],
                                    @"MAC": [DIHelpers getMAC]
                                    };
    NSMutableDictionary* mutableBasicParams = [basicParams mutableCopy];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    [mutableBasicParams addEntriesFromDictionary:params];
    
    return [mutableBasicParams copy];
}

/*
 ******** Auth *********
 */

-(void) userSignInWithEmail: (NSString*)email password:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error, NSInteger statusCode, NSDictionary* responseObject)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                            @"email": email,
                                                            @"password": password}];
    
    [self setLoginHTTPHeader];
    
    [self.manager POST:SIGNIN_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if  (completion != nil)
        {
            completion(YES, nil, [[responseObject objectForKey:@"statusCode"] integerValue], responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if  (completion != nil)
        {
            NSHTTPURLResponse *test = (NSHTTPURLResponse *)task.response;
            
            NSLog(@"%@, %@", test.allHeaderFields, [NSHTTPURLResponse localizedStringForStatusCode:test.statusCode]);

            if (test.statusCode == 401){
                completion(NO, @"Invalid username and password", 401, nil);
            } else {
                completion(NO, error.localizedDescription, test.statusCode, nil);
            }
        }
    }];
}

- (void) sendSMSForgetPasswordWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"email": email,
                                                                   @"hpNumber": phoneNumber,
                                                                   @"reason": reason}];
    
    [self sendSMSGeneralWithEmail:params url:FORGOT_PASSWORD_SEND_SMS_URL withCompletion:completion];
}

- (void) sendSMSRequestWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"email": email,
                                                                   @"hpNumber": phoneNumber,
                                                                   @"reason": reason}];
    
    [self sendSMSGeneralWithEmail:params url:LOGIN_SEND_SMS_URL withCompletion:completion];
}

- (void) sendSMSForNewDeviceWithEmail: (NSString*) email activationCode: (NSString*) activationCode withCompletion: (void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"email": email,
                                                                   @"activationCode": activationCode}];
    
    [self sendSMSGeneralWithEmail:params url:NEW_DEVICE_SEND_SMS_URL withCompletion:completion];
}

- (void) sendSMSGeneralWithEmail: (NSDictionary*) params url:(NSString*)url withCompletion:(void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion
{

    [self setLoginHTTPHeader];
    
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if  (completion != nil)
        {
            NSHTTPURLResponse *test = (NSHTTPURLResponse *)task.response;
            completion(YES, test.statusCode, nil, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if  (completion != nil)
        {
            NSHTTPURLResponse *test = (NSHTTPURLResponse *)task.response;
            completion(NO, test.statusCode, error.localizedDescription, nil);
        }
    }];
}

- (void) requestForgetPasswordWithEmail: (NSString*) email phoneNumber:(NSString*) phoneNumber activationCode: (NSString*) activationCode withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{@"email": email, @"hpNumber": phoneNumber, @"activationCode": activationCode}];
    
    [self setLoginHTTPHeader];
    
    [self.manager.requestSerializer setValue:email forHTTPHeaderField:@"webuser-id"];
    
    [self.manager POST:FORGOT_PASSWORD_REQUEST_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion != nil) {
            completion(YES, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(NO, error.localizedDescription);
        }
    }];
}

- (void) changePasswordAfterLoginWithEmail: (NSString*) email password: (NSString*) password withCompletion: (void(^)(BOOL success, NSString* error, NSDictionary* response)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{@"email": email, @"password": password}];
    
    [self setOtherForLoginHTTPHeader];
    
    [self.manager POST:CHANGE_PASSWORD_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion != nil) {
            completion(YES, nil, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(NO, error.localizedDescription, nil);
        }
    }];
}

- (void) getFirmListWithCompletion: (void(^)(NSArray* resultArray)) completion
{
    [self setLoginHTTPHeader];
    
    [self.manager GET:SIGNUP_FIRM_LIST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [FirmModel getFirmArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil);
        }
    }];
}

-(void) denningSignIn:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error, NSDictionary* responseObject)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{@"email": [DataManager sharedManager].user.email, @"password": password, @"sessionID": [DataManager sharedManager].user.sessionID}];
    
    [self setLoginHTTPHeader];
    NSString* url = [[DataManager sharedManager].user.serverAPI stringByAppendingString:DENNING_SIGNIN_URL];
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion != nil) {
            completion(YES, nil, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(NO, error.localizedDescription, nil);
        }
    }];
}

- (void) clientSignIn: (NSString*) url password:(NSString*) password withCompletion: (void(^)(BOOL success, NSString* error,  DocumentModel* doumentModel)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{@"email": [DataManager sharedManager].user.email, @"password": password, @"sessionID": [DataManager sharedManager].user.sessionID}];

    [self setLoginHTTPHeader];
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DocumentModel* result = [DocumentModel getDocumentFromResponse:responseObject];
        if (completion != nil) {
            completion(YES, nil, result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(NO, error.localizedDescription, nil);
        }
    }];
}

- (void) userSignupWithUsername:(NSString*) username phone:(NSString*) phone email:(NSString*) email password:(NSString*) password isLayer:(NSNumber*) isLayer firmCode: (NSString*) firmCode withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"name": username,
                                                                   @"hpphone": phone,
                                                                   @"email": email,
                                                                   @"password": password,
                                                                   @"isLawyer": isLayer,
                                                                   @"firmCode": firmCode}];
    
    [self setLoginHTTPHeader];
    
    [self.manager POST:SIGNUP_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if  (completion != nil)
        {
            completion(YES, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if  (completion != nil)
        {
            completion(YES, error.localizedDescription);
        }
    }];
}

// Home Search

- (void) getGlobalSearchFromKeyword: (NSString*) keyword searchURL:(NSString*)searchURL forCategory:(NSInteger)category searchType:(NSString*)searchType withCompletion:(void(^)(NSArray* resultArray, NSError* error)) completion
{
    NSString* urlString;
    if ([[DataManager sharedManager].searchType isEqualToString:@"Public"]){
        [self setLoginHTTPHeader];
        urlString = [NSString stringWithFormat:@"%@%@&category=%ld", searchURL, [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]], category];
    } else {
        [self setOtherForLoginHTTPHeader];
        urlString = [NSString stringWithFormat:@"%@%@&category=%ld", searchURL, [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]], category];
    }
    
    if ([searchType isEqualToString:@"Special"]) { // Direct Tap on the search button
        urlString = [urlString stringByAppendingString:@"&isAutoComplete=1"];
    }
    
    [self.manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [SearchResultModel getSearchResultArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Updates
- (void) getLatestUpdatesWithCompletion: (void(^)(NSArray* updatesArray, NSError* error)) completion
{
    [self.manager GET:UPATES_LATEST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [NewsModel getNewsArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// News
- (void) getLatestNewsWithCompletion: (void(^)(NSArray* newsArray, NSError* error)) completion
{
    [self.manager GET:NEWS_LATEST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [NewsModel getNewsArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Event

- (void) getLatestEventWithCompletion: (void(^)(NSArray* eventsArray, NSError* error)) completion
{
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:EVENT_LATEST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [EventModel getEventsArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// property

- (void) loadPropertyfromSearchWithCode: (NSString*) code completion: (void(^)(PropertyModel* propertyModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/Property/%@", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *test = (NSHTTPURLResponse *)task.response;
        
        NSLog(@"%@, %@", test.allHeaderFields, [NSHTTPURLResponse localizedStringForStatusCode:test.statusCode]);
        
        PropertyModel* result = [PropertyModel getPropertyFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Contact
- (void) loadContactFromSearchWithCode: (NSString*) code completion: (void(^)(ContactModel* contactModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/Contact/%@", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ContactModel* result = [ContactModel getCotactFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];

}

// Related Matter
- (void) loadRelatedMatterWithCode: (NSString*) code completion: (void(^)(RelatedMatterModel* contactModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/matter/%@", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        RelatedMatterModel* result = [RelatedMatterModel getRelatedMatterFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Bank
- (void) loadBankFromSearchWithCode: (NSString*) code completion: (void(^)(BankModel* bankModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/bank/branch/%@", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BankModel* result = [BankModel getBankFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Government Offices
- (void) loadGovOfficesFromSearchWithCode: (NSString*) code type:(NSString*) type completion: (void(^)(GovOfficeModel* govOfficeModel, NSError* error)) completion
{
    NSString *point = @"";
    if ([type isEqualToString:@"LandOffice"]) {
        point = @"landOffice";
    } else {
        point = @"PTG";
    }
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/GovOffice/%@/%@", self.selectedBaseURLForGeneral, point, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GovOfficeModel* result = [GovOfficeModel getGovOfficeFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Legal firm (Solicitor)
- (void) loadLegalFirmWithCode: (NSString*) code completion: (void(^)(LegalFirmModel* legalFirmModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/Solicitor/%@", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LegalFirmModel* result = [LegalFirmModel getLegalFirmFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Ledger
- (void) loadLedgerWithCode: (NSString*) code completion: (void(^)(NSArray* ledgerModelArray, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/%@/ledger", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [LedgerModel getLedgerArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Ledger detail
- (void) loadLedgerDetailWithCode: (NSString*) code accountType:(NSString*)accountType completion: (void(^)(NSArray* ledgerModelDetailArray, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/%@/ledger/%@", self.selectedBaseURLForGeneral, code, accountType];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* result = [LedgerDetailModel getLedgerDetailArrayFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

// Documents
- (void) loadDocumentWithCode: (NSString*) code completion: (void(^)(DocumentModel* doumentModel, NSError* error)) completion
{
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/v1/app/matter/%@/fileFolder", self.selectedBaseURLForGeneral, code];
    [self setOtherForLoginHTTPHeader];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DocumentModel* result = [DocumentModel getDocumentFromResponse:responseObject];
        if (completion != nil) {
            completion(result, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (completion != nil) {
            completion(nil, error);
        }
        
        // Error Message
    }];
}

- (BFTask *) perfomRequestWithPath:(NSString *)path
                   parameters:(NSDictionary *)parameters{
    
    BFTaskCompletionSource* source = [BFTaskCompletionSource taskCompletionSource];
    
    NSString *URLString = [baseURLString stringByAppendingString:path];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[self.manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull __unused response, id  _Nullable responseObject, NSError * _Nullable error) {
          
        if (!error) {
            [source setResult:responseObject];
        } else {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [source setError:error];
        }
    }] resume];

    return source.task;
}
@end
