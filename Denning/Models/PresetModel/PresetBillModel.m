//
//  PresetBillModel.m
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PresetBillModel.h"

@implementation PresetBillModel

+ (PresetBillModel*) getPresetBillFromResponse: (NSDictionary*) response
{
    PresetBillModel* model = [PresetBillModel new];
    
    model.category = [response valueForKeyNotNull:@"category"];
    model.billCode = [response valueForKeyNotNull:@"code"];
    model.billDescription = [response valueForKeyNotNull:@"description"];
    model.state = [response valueForKeyNotNull:@"state"];
    
    return model;
}

+ (NSArray*) getPresetBillArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[PresetBillModel getPresetBillFromResponse:obj]];
    }
    
    return result;
}

@end
