
//
//  BankBranchModel.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BankBranchModel.h"

@implementation BankBranchModel
+ (BankBranchModel*) getBankBranchFromResponse:(NSDictionary*) response
{
    BankBranchModel* model = [BankBranchModel new];

    model.name = [response valueForKeyNotNull:@"name"];
    model.bankBranchCode = [response valueForKeyNotNull:@"code"];
    model.HQ = [HQModel getHQFromResponse:[response objectForKeyNotNull:@"HQ"]];
    model.CAC = [CACModel getCACFromResponse:[response objectForKeyNotNull:@"CAC"]];
    return model;
}

+ (NSArray*) getBankBranchArrayFromResponse:(NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[BankBranchModel getBankBranchFromResponse:obj]];
    }
    
    return result;

}

@end
