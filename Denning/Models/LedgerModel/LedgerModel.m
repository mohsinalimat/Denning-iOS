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
    
    ledgerModel.accountName = [response valueForKeyNotNull:@"accountName"];
    ledgerModel.urlDetail = [response valueForKeyNotNull:@"urlDetail"];
    ledgerModel.availableBalance = [response valueForKeyNotNull:@"availableBalance"];
    ledgerModel.currentBalance = [response valueForKeyNotNull:@"currentBalance"];
    ledgerModel.lastStatementDate = [response valueForKeyNotNull:@"lastStatementDate"];
    
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
