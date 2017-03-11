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

+ (DataManager *)sharedManager;


- (void) setUserInfoFromLogin: (NSDictionary*) response;

- (void) setUserInfoFromNewDeviceLogin: (NSDictionary*) response;

- (void) setUserInfoFromChangePassword: (NSDictionary*) response;



@end
