//
//  PartyGroupModel.h
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClientModel;

@interface PartyGroupModel : NSObject
@property (strong, nonatomic) NSString* partyGroupName;
@property (strong, nonatomic) NSArray<ClientModel*>* partyArray;

+ (PartyGroupModel*) getPartyGroupFromResponse: (NSDictionary*) response;

+(NSArray*) getPartyGroupArrayFromResponse: (NSArray*) response;
@end
