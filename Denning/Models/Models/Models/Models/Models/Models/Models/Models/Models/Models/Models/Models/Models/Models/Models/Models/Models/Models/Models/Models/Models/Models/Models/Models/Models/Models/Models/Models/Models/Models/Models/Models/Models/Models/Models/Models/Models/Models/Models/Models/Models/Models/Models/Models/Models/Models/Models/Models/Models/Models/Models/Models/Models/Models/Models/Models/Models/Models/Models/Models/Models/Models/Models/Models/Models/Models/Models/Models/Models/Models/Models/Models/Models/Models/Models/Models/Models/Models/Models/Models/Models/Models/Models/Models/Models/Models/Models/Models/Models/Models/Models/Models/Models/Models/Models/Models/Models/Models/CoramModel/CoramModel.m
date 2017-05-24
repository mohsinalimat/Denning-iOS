//
//  CoramModel.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CoramModel.h"

@implementation CoramModel

+ (CoramModel*) getCoramFromResponse: (NSDictionary*) response
{
    CoramModel *coram = [CoramModel new];
    
    coram.coramCode = [response objectForKeyNotNull:@"code"];
    coram.courtType = [response objectForKeyNotNull:@"courtType"];
    coram.position = [response objectForKeyNotNull:@"position"];
    coram.name = [response objectForKeyNotNull:@"name"];
    
    return coram;
}

+ (NSArray*) getCoramArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[CoramModel getCoramFromResponse:obj]];
    }
    
    return result;
}

@end
