//
//  MatterLitigationModel.m
//  Denning
//
//  Created by Ho Thong Mee on 22/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MatterLitigationModel.h"

@implementation MatterLitigationModel

+ (MatterLitigationModel*) getMatterLitigationFromResponse: (NSDictionary*) response
{
    MatterLitigationModel *model = [MatterLitigationModel new];
    
    model.courtInfo = [CourtModel getCourtFromResponse:[response objectForKey:@"courtInfo"]];
    model.dateOpen = [response valueForKeyNotNull:@"dateOpen"];
    model.matter = [MatterCodeModel getMatterCodeFromResponse:[response objectForKeyNotNull:@"matter"]];
    model.manualNo = [response objectForKeyNotNull:@"manualNo"];
    model.partyGroup = [PartyGroupModel getPartyGroupFromResponse:[response objectForKeyNotNull:@"partyGroup"]];
    model.primaryClient = [ClientModel getClientFromResponse:[response objectForKeyNotNull:@"primaryClient"]];
    model.referenceNo = [response valueForKeyNotNull:@"referenceNo"];
    model.systemNo = [response valueForKeyNotNull:@"systemNo"];
    return model;
}

+ (NSArray*) getMatterLitigationArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[MatterLitigationModel getMatterLitigationFromResponse:obj]];
    }
    
    return result;
}
@end
