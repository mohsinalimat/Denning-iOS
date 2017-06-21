//
//  DashboardLedgerModel.m
//  Denning
//
//  Created by Ho Thong Mee on 02/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DashboardLedgerModel.h"

@implementation DashboardLedgerModel

+ (DashboardLedgerModel*) getDashboardLedgerFromResponse: (NSDictionary*) response
{
    DashboardLedgerModel* model = [DashboardLedgerModel new];
    
    model.accountName = [response valueForKeyNotNull:@"accountName"];
    model.accountNo = [response valueForKeyNotNull:@"accountNo"];
    model.credit = [response valueForKeyNotNull:@"credit"];
    model.debit = [response valueForKeyNotNull:@"debit"];
    model.lastMovement = [response valueForKeyNotNull:@"lastMovement"];
    model.pid = [response valueForKeyNotNull:@"pid"];
    
    return model;
}

+ (NSArray*) getDashboardLedgerArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[DashboardLedgerModel getDashboardLedgerFromResponse:obj]];
    }
    
    return result;
}
@end
