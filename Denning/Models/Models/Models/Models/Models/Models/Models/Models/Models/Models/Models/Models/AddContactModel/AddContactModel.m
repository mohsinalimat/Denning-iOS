//
//  AddContactModel.m
//  Denning
//
//  Created by DenningIT on 04/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddContactModel.h"

@implementation AddContactModel

+ (AddContactModel*) getAddContactFromResponse: (NSDictionary*) response
{
    AddContactModel *addContact = [AddContactModel new];
    
    return addContact;
}

@end
