//
//  ProfitLossDetailModel.m
//  Denning
//
//  Created by Ho Thong Mee on 16/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ProfitLossDetailModel.h"

@implementation ProfitLossDetailModel

+(ProfitLossDetailModel*) getProfitLossDetailFromResponse:(NSDictionary*) response
{
    ProfitLossDetailModel *model = [ProfitLossDetailModel new];
    
    model.expenses = [response valueForKeyNotNull:@"expenses"];
    model.profitLoss = [response valueForKeyNotNull:@"profitLoss"];
    model.revenue = [response valueForKeyNotNull:@"revenue"];
    model.theYear = [response valueForKeyNotNull:@"theYear"];
    return model;
}

@end
