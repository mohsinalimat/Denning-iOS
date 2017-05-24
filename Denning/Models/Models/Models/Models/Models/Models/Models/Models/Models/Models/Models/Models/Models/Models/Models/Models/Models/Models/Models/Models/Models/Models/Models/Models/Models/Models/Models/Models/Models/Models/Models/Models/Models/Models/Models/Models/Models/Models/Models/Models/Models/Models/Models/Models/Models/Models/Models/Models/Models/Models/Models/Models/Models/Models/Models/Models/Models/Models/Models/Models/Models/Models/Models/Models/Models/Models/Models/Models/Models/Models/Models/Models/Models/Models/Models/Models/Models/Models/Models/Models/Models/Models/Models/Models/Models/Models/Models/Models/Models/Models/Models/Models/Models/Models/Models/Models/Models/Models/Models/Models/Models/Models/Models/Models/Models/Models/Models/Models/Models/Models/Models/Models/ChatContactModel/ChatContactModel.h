//
//  ChatContactModel.h
//  Denning
//
//  Created by DenningIT on 05/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatFirmModel;

@interface ChatContactModel : NSObject

@property (strong, nonatomic) NSArray<ChatFirmModel*>* favoriteContacts;

@property (strong, nonatomic) NSArray<ChatFirmModel*>* staffContacts;

@property (strong, nonatomic) NSArray<ChatFirmModel*>* clientContacts;

+ (ChatContactModel*) getChatContactFromResponse: (NSDictionary*) response;

@end
