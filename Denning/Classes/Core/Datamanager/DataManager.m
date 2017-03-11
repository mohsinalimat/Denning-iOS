//
//  DataManager.m
//  Reach-iOS
//
//  Created by AlexFill on 23.02.16.
//  Copyright © 2016 Maksym Rachytskyy. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()

@end

@implementation DataManager
@synthesize user;
@synthesize searchType;

+ (DataManager *)sharedManager {
    static DataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        searchType = @"General";
//        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
//        configuration.fileURL = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"IT.Denning"] URLByAppendingPathComponent:@"Denning.realm"];
//        [RLMRealmConfiguration setDefaultConfiguration:configuration];
//        [[NSFileManager defaultManager] removeItemAtURL:[RLMRealmConfiguration defaultConfiguration].fileURL error:nil];
    }
    
    return self;
}

- (void) setUserInfoFromLogin: (NSDictionary*) response
{
    user = [UserModel allObjects].firstObject;
    if (!user) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            user = [UserModel createInDefaultRealmWithValue:@[@"", @"", @"", @"", @"", @"", @"", @0]];
        }];
    }
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        user.email = [response objectForKeyNotNull:@"email"];
        user.phoneNumber = [response objectForKeyNotNull:@"hpNumber"];
        //    user.firmList = [response objectForKeyNotNull:@"firmList"];
        user.userType = [response objectForKeyNotNull:@"userType"];
        user.sessionID = [response objectForKeyNotNull:@"sessionID"];
        user.status = [response objectForKeyNotNull:@"status"];
        user.username = [response objectForKeyNotNull:@"name"];
    }];
}

- (void) setUserInfoFromNewDeviceLogin: (NSDictionary*) response
{
    [[RLMRealm defaultRealm] transactionWithBlock:^{
//        user.firmList = [response objectForKey:@"firmList"];
        user.status = [response objectForKeyNotNull:@"status"];
        user.userType = [response objectForKeyNotNull:@"userType"];
    }];
}

- (void) setUserInfoFromChangePassword: (NSDictionary*) response
{
    [self setUserInfoFromNewDeviceLogin:response];
}

@end
