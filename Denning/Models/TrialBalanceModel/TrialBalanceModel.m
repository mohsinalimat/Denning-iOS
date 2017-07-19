//
//  TrialBalanceModel.m
//  Denning
//
//  Created by Ho Thong Mee on 15/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TrialBalanceModel.h"

@implementation TrialBalanceModel

+ (TrialBalanceModel*) getTrialBalanceFromResponse:(NSDictionary*) response
{
    TrialBalanceModel* model = [TrialBalanceModel new];
    
    model.API = [response valueForKeyNotNull:@"API"];
    
    model.accountName = [response valueForKeyNotNull:@"accountName"];
    model.accountType = [response valueForKeyNotNull:@"accountType"];
    model.credit = [response valueForKeyNotNull:@"credit"];
    model.debit = [response valueForKeyNotNull:@"debit"];
    model.isBalance = [response valueForKeyNotNull:@"isBalance"];
    
    return model;
}

+ (NSArray*) getTrialBalanceArrayFromResponse:(NSArray*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[TrialBalanceModel getTrialBalanceFromResponse:obj]];
    }
    
    return result;

}

@end
