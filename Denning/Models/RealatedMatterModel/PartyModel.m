//
//  PartyModel.m
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PartyModel.h"

@implementation PartyModel

+ (PartyModel*) getPartyFromResponse:(NSDictionary*) response
{
    PartyModel* model = [PartyModel new];
    model.partyName = [response objectForKey:@"name"];
    model.partyCode = [response objectForKey:@"code"];
    return model;
}

+ (NSArray*) getPartyArrayFromResponse:(NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[PartyModel getPartyFromResponse:obj]];
    }
    
    return result;
}

@end
