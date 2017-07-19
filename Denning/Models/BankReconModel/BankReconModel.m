//
//  BankReconModel.m
//  Denning
//
//  Created by Ho Thong Mee on 14/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BankReconModel.h"

@implementation BankReconModel

+ (BankReconModel*) getBankReconFromResponse:(NSDictionary*) response
{
    BankReconModel* model = [BankReconModel new];
    
    model.API = [response valueForKeyNotNull:@"API"];
    
    model.accountName = [response valueForKeyNotNull:@"accountName"];
    model.accountNo = [response valueForKeyNotNull:@"accountNo"];
    model.credit = [response valueForKeyNotNull:@"credit"];
    model.debit = [response valueForKeyNotNull:@"debit"];
    model.lastMovement = [response valueForKeyNotNull:@"lastMovement"];
    model.pid = [response valueForKeyNotNull:@"pid"];
    
    return model;
}

+ (NSArray*) getBankReconArrayFromResponse:(NSArray*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[BankReconModel getBankReconFromResponse:obj]];
    }
    
    return result;
    
}

@end
