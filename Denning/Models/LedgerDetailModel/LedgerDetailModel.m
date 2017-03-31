//
//  LedgerDetailModel.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LedgerDetailModel.h"

@implementation LedgerDetailModel

+ (LedgerDetailModel*) getLedgerDetailFromResponse: (NSDictionary*) response
{
    LedgerDetailModel* ledgerDetailModel = [LedgerDetailModel new];
    
    ledgerDetailModel.ChequeNo = [response objectForKey:@"ChequeNo"];
    ledgerDetailModel.amount = [response objectForKey:@"amount"];
    ledgerDetailModel.ledgerCode = [response objectForKey:@"ledgerCode"];
    ledgerDetailModel.date = [response objectForKey:@"date"];
    ledgerDetailModel.ledgerDescription = [response objectForKey:@"description"];
    ledgerDetailModel.documentNo = [response objectForKey:@"documentNo"];
    ledgerDetailModel.drORcr = [response objectForKey:@"drORcr"];

    return ledgerDetailModel;
}

+ (NSArray*) getLedgerDetailArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id model in response) {
        [result addObject:[LedgerDetailModel getLedgerDetailFromResponse:model]];
    }
    
    return [result copy];
}
@end
