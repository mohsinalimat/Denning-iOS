//
//  UserModel.h
//  Denning
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirmURLModel : RLMObject
@property NSString      *firmURL;
@end
RLM_ARRAY_TYPE(FirmURLModel)

@interface UserModel : RLMObject

@property   NSString    *sessionID;
@property   NSString    *email;
@property   NSString    *phoneNumber;
@property   NSString    *username;
@property   NSString    *status;
//@property   RLMArray<FirmURLModel *><FirmURLModel>    *firmList;
@property   NSString    *userType;
@property   NSString    *serverURL;
@property   NSInteger    activationCode;

@end
