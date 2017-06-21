//
//  MukimModel.m
//  Denning
//
//  Created by Ho Thong Mee on 06/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MukimModel.h"

@implementation MukimModel

+ (MukimModel*) getMukimFromResponse: (NSDictionary*) response
{
    MukimModel* model = [MukimModel new];
    model.mukimCode = [response valueForKeyNotNull:@"code"];
    model.mukim = [response valueForKeyNotNull:@"mukim"];
    model.daerah = [response valueForKeyNotNull:@"daerah"];
    model.negeri = [response valueForKeyNotNull:@"negeri"];
    model.sCode = [response valueForKeyNotNull:@"sCode"];
    return model;
}

+ (NSArray*) getMukimArrayFromReponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[MukimModel getMukimFromResponse:obj]];
    }
    
    return result;
}

@end
