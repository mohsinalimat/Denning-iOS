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
}

- (void)initManager
{
    self.manager = [[AFHTTPSessionManager  alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
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

- (NSDictionary*) buildRquestParamsFromDictionary: (NSDictionary*) dict
{
    NSDictionary* basicParams = @{
                                    @"ipWAN": [DIHelpers getWANIP],
                                    @"ipLAN": [DIHelpers getLANIP],
                                    @"OS": [DIHelpers getOSName],
                                    @"device": [DIHelpers getDevice],
                                    @"deviceName": [DIHelpers getDeviceName]
                                    };
    NSMutableDictionary* mutableBasicParams = [basicParams mutableCopy];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    [mutableBasicParams addEntriesFromDictionary:params];
    
    return [mutableBasicParams copy];
}

/*
 ******** Auth *********
 */

-(void) userSignInWithEmail: (NSString*)email password:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error, NSInteger statusCode)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                            @"email": email,
                                                            @"password": password}];
    
    
    [self.manager POST:SIGNIN_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if  (completion != nil)
        {
            if ([[responseObject objectForKey:@"statusCode"] longValue] == 200) {
                completion(YES, nil, 200);
            } else if ([[responseObject objectForKey:@"statusCode"] longValue] == 250){
                completion(YES, nil, 250);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if  (completion != nil)
        {
            NSHTTPURLResponse *test = (NSHTTPURLResponse *)task.response;
            
            NSLog(@"%ld, %@", test.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:test.statusCode]);

            if (test.statusCode == 401){
                completion(NO, @"Invalid username and password", 401);
            } else {
                completion(NO, error.localizedDescription, test.statusCode);
            }
        }
    }];
}

- (void) sendSMSForgetPasswordWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"email": email,
                                                                   @"hpNumber": phoneNumber,
                                                                   @"reason": reason}];
    
    [self sendSMSGeneralWithEmail:params url:FORGOT_PASSWORD_SEND_SMS_URL withCompletion:completion];
}

- (void) sendSMSRequestWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"email": email,
                                                                   @"hpNumber": phoneNumber,
                                                                   @"reason": reason}];
    
    [self sendSMSGeneralWithEmail:params url:LOGIN_SEND_SMS_URL withCompletion:completion];
}

- (void) sendSMSGeneralWithEmail: (NSDictionary*) params url:(NSString*)url withCompletion:(void(^)(BOOL success, NSString* error)) completion
{

    
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

- (void) requestForgetPasswordWithEmail: (NSString*) email phoneNumber:(NSString*) phoneNumber activationCode: (NSString*) activationCode withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{@"email": email, @"hpNumber": phoneNumber, @"activationCode": activationCode}];
    
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

- (void) getFirmListWithCompletion: (void(^)(NSArray* resultArray)) completion
{
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

- (void) userSignupWithUsername:(NSString*) username phone:(NSString*) phone email:(NSString*) email password:(NSString*) password isLayer:(NSNumber*) isLayer firmCode: (NSString*) firmCode withCompletion:(void(^)(BOOL success, NSString* error)) completion
{
    NSDictionary* params = [self buildRquestParamsFromDictionary:@{
                                                                   @"name": username,
                                                                   @"hpphone": phone,
                                                                   @"email": email,
                                                                   @"password": password,
                                                                   @"isLawyer": isLayer,
                                                                   @"firmCode": firmCode}];
    
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

- (void) getGlobalSearchFromKeyword: (NSString*) keyword searchURL:(NSString*)searchURL forCategory:(NSInteger)category withCompletion:(void(^)(NSArray* resultArray, NSError* error)) completion
{
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@&category=%ld", searchURL, [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]], category];
    
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

// News

- (void) getLatestNewsWithCompletion: (void(^)(NewsModel* news, NSError* error)) completion
{
    [self.manager GET:NEWS_LATEST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NewsModel* result = [NewsModel getNewsFromResponse:responseObject];
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

- (void) getLatestEventWithCompletion: (void(^)(EventModel* event, NSError* error)) completion
{
    [self.manager GET:EVENT_LATEST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        EventModel* result = [EventModel getEventFromResponse:responseObject];
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
