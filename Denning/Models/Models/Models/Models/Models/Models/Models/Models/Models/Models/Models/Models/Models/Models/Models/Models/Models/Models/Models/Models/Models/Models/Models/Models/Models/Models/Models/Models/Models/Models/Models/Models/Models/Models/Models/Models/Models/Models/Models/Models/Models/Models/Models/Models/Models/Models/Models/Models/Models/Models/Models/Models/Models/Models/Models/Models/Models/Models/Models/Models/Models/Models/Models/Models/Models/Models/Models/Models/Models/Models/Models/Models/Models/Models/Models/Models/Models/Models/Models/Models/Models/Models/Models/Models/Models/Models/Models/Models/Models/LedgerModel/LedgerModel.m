//
//  LedgerModel.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LedgerModel.h"

@implementation LedgerModel

+ (LedgerModel*) getLedgerFromResponse: (NSDictionary*) response
{
    LedgerModel* ledgerModel = [LedgerModel new];
    
    ledgerModel.accountName = [response objectForKey:@"accountName"];
    ledgerModel.accountType = [response objectForKey:@"accountType"];
    ledgerModel.availableBalance = [response objectForKey:@"availableBalance"];
    ledgerModel.currentBalance = [response objectForKey:@"currentBalance"];
    ledgerModel.lastStatementDate = [response objectForKey:@"lastStatementDate"];
    
    return ledgerModel;
}

+ (NSArray*) getLedgerArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* ledgerArray = [NSMutableArray new];
    
    for (id model in response) {
        [ledgerArray addObject:[LedgerModel getLedgerFromResponse:model]];
    }
    
    return ledgerArray;
}

@end
