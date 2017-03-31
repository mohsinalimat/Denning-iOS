//
//  DataManager.h
//  Reach-iOS
//
//  Created by AlexFill on 23.02.16.
//  Copyright © 2016 Maksym Rachytskyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (strong, nonatomic) NSString  *searchType;
@property (strong, nonatomic) UserModel *user;
@property (strong, nonatomic) NSArray* denningArray;
@property (strong, nonatomic) NSArray* bussinessArray;
@property (strong, nonatomic) NSArray* personalArray;
@property (strong, nonatomic) NSString* seletedUserType;
@property (strong, nonatomic) NSNumber* statusCode;
@property (strong, nonatomic) NSString* documentView;

+ (DataManager *)sharedManager;

- (void) setUserPassword: (NSString*) password;

- (void) setUserInfoFromLogin: (NSDictionary*) response;

- (void) setUserInfoFromNewDeviceLogin: (NSDictionary*) response;

- (void) setUserInfoFromChangePassword: (NSDictionary*) response;

- (void) setServerAPI: (NSString*) serverAPI;


@end
