//
//  NewMatterModel.m
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewMatterModel.h"

@implementation NewMatterModel

+ (NewMatterModel*) getNewMatter: (NSDictionary*) response
{
    NewMatterModel *model = [NewMatterModel new];
    model.dateOpen = [response valueForKeyNotNull:@"dateOpen"];
    model.systemNo = [response valueForKeyNotNull:@"systemNo"];
    model.primaryClient = [ClientModel getClientFromResponse:[response objectForKeyNotNull:@"primaryClient"]];
    model.partner = [ClientModel getClientFromResponse:[response objectForKeyNotNull:@"partner"]];
    model.matter = [MatterCodeModel getMatterCodeFromResponse:[response objectForKeyNotNull:@"matter"]];
    return model;
}

+ (NSArray*) getNewMatterArray: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[NewMatterModel getNewMatter:obj]];
    }
    
    return result;
}
@end
