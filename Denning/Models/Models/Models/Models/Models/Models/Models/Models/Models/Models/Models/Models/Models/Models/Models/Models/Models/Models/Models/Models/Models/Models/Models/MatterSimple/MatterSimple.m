//
//  MatterSimple.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MatterSimple.h"
#import "ClientModel.h"

@implementation MatterSimple

+ (MatterSimple*) getMatterSimpleFromResponse: (NSDictionary*) response
{
    MatterSimple* matterSimple = [MatterSimple new];
    matterSimple.systemNo = [response objectForKeyNotNull:@"systemNo"];
    matterSimple.referenceNo = [response objectForKeyNotNull:@"referenceNo"];
    matterSimple.dateOpen = [response objectForKeyNotNull:@"dateOpen"];
    matterSimple.manualNo = [response objectForKeyNotNull:@"manualNo"];
    matterSimple.matter = [MatterCodeModel getMatterCodeFromResponse: [response objectForKeyNotNull:@"matter"]];
    matterSimple.partyGroupArray = [PartyGroupModel getPartyGroupArrayFromResponse: [response objectForKeyNotNull:@"partyGroup"]];
    matterSimple.primaryClient = [ClientModel getClientFromResponse:[response objectForKeyNotNull:@"primaryClient"]];
    
    return matterSimple;
}

+ (NSArray*) getMatterSimpleArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[MatterSimple getMatterSimpleFromResponse:obj]];
    }
    
    return result;
}

@end
