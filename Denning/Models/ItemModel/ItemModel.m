//
//  ItemModel.m
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+ (ItemModel*) getItemFromResponse: (NSDictionary*) response
{
    ItemModel* item = [ItemModel new];
    item.itemId = [response valueForKeyNotNull:@"id"];
    item.api = [response valueForKeyNotNull:@"api"];
    item.label = [response valueForKeyNotNull:@"label"];
    item.value = [response valueForKeyNotNull:@"value"];
    
    return item;
}

+ (NSArray*) getItemArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[ItemModel getItemFromResponse:obj]];
    }
    
    return result;
}

@end
