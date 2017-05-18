//
//  RelatedMatterModel.m
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "RelatedMatterModel.h"

@implementation RelatedMatterModel
@synthesize partyGroupArray;

+ (RelatedMatterModel*) getRelatedMatterFromResponse: (NSDictionary*) response
{
    RelatedMatterModel* relatedMatter = [RelatedMatterModel new];
    
    relatedMatter.systemNo = [response objectForKey:@"systemNo"];
    
    relatedMatter.clientName = [NSString stringWithFormat:@"%@", [[response objectForKey:@"primaryClient"] objectForKey:@"name"]];
    relatedMatter.contactCode = [[[response objectForKey:@"primaryClient"] objectForKey:@"code"] stringValue];
    relatedMatter.openDate = [response objectForKey:@"dateOpen"];
    relatedMatter.ref = [response objectForKey:@"referenceNo"];
    if ([relatedMatter.ref isKindOfClass:[NSNull class]]) {
        relatedMatter.ref = @"";
    }
    relatedMatter.matter = [[response objectForKey:@"matter"] objectForKey:@"description"];
    
    
    relatedMatter.partyGroupArray = [RelatedMatterModel getPartyGroupArrayFromResponse: [response objectForKey:@"partyGroup"]];
    
    relatedMatter.court = [CourtModel getCourtFromResponse:response];
    
    relatedMatter.solicitorGroupArray = [RelatedMatterModel getSolicitorGroupArrayFromResponse:[response objectForKey:@"solicitorsGroup"]];
    
    relatedMatter.propertyGroupArray = [PropertyModel getPropertyArrayFromResponse:[response objectForKey:@"propertyGroup"]];
    
    relatedMatter.bankGroupArray = [BankGroupModel getBankGroupArrayFromResponse:[response objectForKey:@"bankGroup"]];
    
    relatedMatter.RMGroupArray = [RelatedMatterModel getGeneralGroupArrayFromResponse:[response objectForKey:@"RMGroup"]];
    
    relatedMatter.dateGroupArray =  [RelatedMatterModel getGeneralGroupArrayFromResponse:[response objectForKey:@"dateGroup"]];
    
    relatedMatter.textGroupArray = [RelatedMatterModel getGeneralGroupArrayFromResponse:[response objectForKey:@"textGroup"]];
    
    return relatedMatter;
}

+(NSArray*) getPartyGroupArrayFromResponse: (NSArray*) response
{
    NSMutableArray* partyGroupArray = [NSMutableArray new];
    
    for (id group in response) {
         PartyGroupModel* partyGroupModel = [PartyGroupModel new];
        partyGroupModel.partyGroupName = [group objectForKey:@"PartyName"];
        partyGroupModel.partyArray = [PartyModel getPartyArrayFromResponse:[group objectForKeyNotNull:@"party"]];
        [partyGroupArray addObject:partyGroupModel];
    }
   
    return partyGroupArray;
}

+(NSArray*) getSolicitorGroupArrayFromResponse: (NSArray*) response
{
    NSMutableArray* solicitorGroupArray = [NSMutableArray new];
    for (id group in response) {
        SolicitorGroup* solicitorGroup = [SolicitorGroup new];
        solicitorGroup.solicitorGroupName = [group objectForKey:@"groupName"];
        id solicitor = [group objectForKey:@"solicitor"];
        if ([solicitor isKindOfClass:[NSNull class]]) {
            solicitorGroup.solicitorCode = @"";
            solicitorGroup.solicitorName = @"";
            solicitorGroup.solicitorReference = @"";
        } else {
            solicitorGroup.solicitorCode = [solicitor objectForKey:@"code"];
            solicitorGroup.solicitorName = [solicitor objectForKey:@"name"];
            solicitorGroup.solicitorReference = [group objectForKey:@"reference"];
        }
        
        [solicitorGroupArray addObject:solicitorGroup];
    }
    
    return solicitorGroupArray;
}

+(NSArray*) getGeneralGroupArrayFromResponse: (NSArray*) response
{
    NSMutableArray* RMGroupArray = [NSMutableArray new];
    for (id group in response) {
        GeneralGroup *model = [GeneralGroup new];
        model.value = [group objectForKey:@"value"];
        model.label = [group objectForKey:@"label"];
        [RMGroupArray addObject:model];
    }
    return RMGroupArray;
}

@end
