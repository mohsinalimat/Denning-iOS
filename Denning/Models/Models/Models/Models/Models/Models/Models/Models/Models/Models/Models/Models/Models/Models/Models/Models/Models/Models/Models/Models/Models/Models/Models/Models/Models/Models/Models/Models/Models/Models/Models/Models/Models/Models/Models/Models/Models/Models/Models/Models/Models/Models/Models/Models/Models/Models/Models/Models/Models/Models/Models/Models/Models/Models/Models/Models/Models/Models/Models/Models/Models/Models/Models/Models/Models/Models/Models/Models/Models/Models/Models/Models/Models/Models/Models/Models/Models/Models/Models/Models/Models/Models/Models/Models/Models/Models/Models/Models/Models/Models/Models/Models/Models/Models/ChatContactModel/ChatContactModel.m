//
//  ChatContactModel.m
//  Denning
//
//  Created by DenningIT on 05/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ChatContactModel.h"
#import "ChatFirmModel.h"

@implementation ChatContactModel

+ (ChatContactModel*) getChatContactFromResponse: (NSDictionary*) response
{
    ChatContactModel* chatContactModel = [ChatContactModel new];
    
    chatContactModel.favoriteContacts = [ChatFirmModel getChatFirmModelArrayFromResponse:[response objectForKey:@"favourite"]];
    chatContactModel.clientContacts = [ChatFirmModel getChatFirmModelArrayFromResponse:[response objectForKey:@"client"]];
    chatContactModel.staffContacts = [ChatFirmModel getChatFirmModelArrayFromResponse:[response objectForKey:@"staff"]];
    
    return chatContactModel;
}

@end
