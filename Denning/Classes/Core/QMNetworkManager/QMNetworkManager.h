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

@interface QMNetworkManager : NSObject

@property(nonatomic, strong) AFHTTPSessionManager  *manager;

@property (nonatomic, strong) APIDataSource *searchDataSource;

@property (strong, atomic) NSString       *installDate;
@property (strong, atomic) NSString       *installDateTemp;
@property (assign) CLLocationCoordinate2D     oldLocation;
@property(strong, atomic) NSString       *countryName;
@property(strong, atomic) NSString       *cityName;
@property(strong, atomic) NSString       *stateName;

@property(nonatomic, strong) UserModel*     myProfile;

+ (QMNetworkManager *)sharedManager;

/*
 ******** Auth *********
 */

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

@end

NS_ASSUME_NONNULL_END
