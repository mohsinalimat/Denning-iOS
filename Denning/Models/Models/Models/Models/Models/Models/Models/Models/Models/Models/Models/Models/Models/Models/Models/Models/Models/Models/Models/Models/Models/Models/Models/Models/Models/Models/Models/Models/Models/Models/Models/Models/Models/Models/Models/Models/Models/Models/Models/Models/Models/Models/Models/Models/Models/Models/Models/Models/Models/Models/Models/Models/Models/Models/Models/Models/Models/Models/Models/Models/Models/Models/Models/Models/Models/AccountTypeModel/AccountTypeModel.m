//
//  AccountTypeModel.m
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AccountTypeModel.h"

@implementation AccountTypeModel

+ (AccountTypeModel*) getAccountTypeFromResponse: (NSDictionary*) response
{
    AccountTypeModel *model = [AccountTypeModel new];
    
    model.accountTypeCode = [response valueForKeyNotNull:@"code"];
    model.descriptionValue = [response valueForKeyNotNull:@"description"];
    model.ID = [response valueForKeyNotNull:@"ID"];
    model.shortDescription = [response valueForKeyNotNull:@"shortDesc"];
    
    return model;
}

+ (NSArray*) getAccountTypeArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[AccountTypeModel getAccountTypeFromResponse:obj]];
    }
    
    return result;
}
@end
