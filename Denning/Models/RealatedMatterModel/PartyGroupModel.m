//
//  PartyGroupModel.m
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PartyGroupModel.h"

@implementation PartyGroupModel

+(NSArray*) getPartyGroupArrayFromResponse: (NSArray*) response
{
    NSMutableArray* partyGroupArray = [NSMutableArray new];
    
    for (id group in response) {
        PartyGroupModel* partyGroupModel = [PartyGroupModel new];
        partyGroupModel.partyGroupName = [group valueForKeyNotNull:@"PartyName"];
        partyGroupModel.partyArray = [ClientModel getClientArrayFromReponse:[group objectForKeyNotNull:@"party"]];
        if (partyGroupModel.partyArray.count > 0) {
            [partyGroupArray addObject:partyGroupModel];
        }
    }
    
    return partyGroupArray;
}


@end
