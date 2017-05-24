//
//  ChatUserModel.m
//  Denning
//
//  Created by DenningIT on 14/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ChatUserModel.h"

@implementation ChatUserModel

+ (ChatUserModel*) getChatUserModelFromResponse: (NSDictionary*) response {
    ChatUserModel* userModel = [ChatUserModel new];
    userModel.email = [response objectForKey:@"email"];
    userModel.firm = [response objectForKey:@"firm"];
    userModel.firmCode = [response objectForKey:@"firmCode"];
    userModel.position = [response objectForKey:@"position"];
    return userModel;
}

+ (NSArray*) getChatUserModelArrayFromResponse: (NSArray*) response {
    NSMutableArray* result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[ChatUserModel getChatUserModelFromResponse:obj]];
    }
    return result;
}

@end
