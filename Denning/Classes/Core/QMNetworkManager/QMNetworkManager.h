//
//  QMNetworkManager.h
//  reach-ios
//
//  Created by Admin on 2016-11-30.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "APIDataSource.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletionHandler)(BOOL success, id response, NSError *error);

@class UserModel;
@class NewsModel;
@class EventModel;
@class PropertyModel;

@interface QMNetworkManager : NSObject

@property(nonatomic, strong) AFHTTPSessionManager  *manager;

@property (nonatomic, strong) APIDataSource *searchDataSource;

@property (strong, atomic) NSString       *installDate;
@property (strong, atomic) NSString       *installDateTemp;
@property (assign) CLLocationCoordinate2D     oldLocation;
@property(strong, atomic) NSString       *countryName;
@property(strong, nonatomic) NSString       *cityName;
@property(strong, atomic) NSString       *stateName;
@property (strong, atomic) NSNumber      *invalidTry;
@property (strong, atomic) NSDate       *startTrackTimeForLogin;

@property(nonatomic, strong) UserModel*     myProfile;

@property (nonatomic, strong) NSString* selectedBaseURLForGeneral;

+ (QMNetworkManager *)sharedManager;

/*
 ******** Auth *********
 */

/*
 *  Sign In
 *   
 *  @param: username
 *  @param: email
 */

-(void) userSignInWithEmail: (NSString*)email password:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error , NSInteger statusCode, NSDictionary* responseObject)) completion;

/*
 *  Request SMS for New Device
 *  @param: email
 *  @param: activation code
 */

- (void) sendSMSNewDeviceWithEmail: (NSString*) email activationCode: (NSNumber*) activationCode withCompletion:(void(^)(BOOL success, NSString* error , NSInteger statusCode)) completion;

/*
 *  Forget Password
 *    1.  Request SMS
 *  @param: email
 *  @param: phone number
 *  @param: reason
 */

- (void) sendSMSForgetPasswordWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSString* error, NSDictionary* response)) completion;

- (void) sendSMSRequestWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSString* error, NSDictionary* response)) completion;

- (void) sendSMSForNewDeviceWithEmail: (NSString*) email activationCode: (NSString*) activationCode withCompletion: (void(^)(BOOL success, NSString* error, NSDictionary* response)) completion;;

/*
 *  Forget Password
 *  @param: email
 *  @param: phone number
 *  @param: activationCode
 */

- (void) requestForgetPasswordWithEmail: (NSString*) email phoneNumber:(NSString*) phoneNumber activationCode: (NSString*) activationCode withCompletion:(void(^)(BOOL success, NSString* error)) completion;

/*
 *  Change Pasword
 *
 *  @param: email
 *  @param: password
 */

- (void) changePasswordAfterLoginWithEmail: (NSString*) email password: (NSString*) password withCompletion: (void(^)(BOOL success, NSString* error, NSDictionary* response)) completion;

/*
 *  Get Firm List
 */

- (void) getFirmListWithCompletion: (void(^)(NSArray* resultArray)) completion;

/*
 *      Sign up
 *
 *  @param: username
 *  @param: phone
 *  @param: email
 *  @param: password
 *  @param: isLayer
 *  @param: firmCode
 *  @param: ipWan
 *  @param: ipLan
 *  @param: os
 *  @param: device
 *  @param: deviceName
 */

- (void) userSignupWithUsername:(NSString*) username phone:(NSString*) phone email:(NSString*) email password:(NSString*) password isLayer:(NSNumber*) isLayer firmCode: (NSString*) firmCode withCompletion:(void(^)(BOOL success, NSString* error)) completion;

// Home Search

- (void) getGlobalSearchFromKeyword: (NSString*) keyword searchURL:(NSString*)searchURL forCategory:(NSInteger)category withCompletion:(void(^)(NSArray* resultArray, NSError* error)) completion;

// News

- (void) getLatestNewsWithCompletion: (void(^)(NewsModel* news, NSError* error)) completion;

// Event

- (void) getLatestEventWithCompletion: (void(^)(EventModel* event, NSError* error)) completion;

// Property

- (void) loadPropertyfromSearchWithCode: (NSString*) code completion: (void(^)(PropertyModel* propertyModel, NSError* error)) completion;


@end

NS_ASSUME_NONNULL_END
