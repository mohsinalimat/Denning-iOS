//
//  ThreeItemModel.m
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ThreeItemModel.h"

@implementation ThreeItemModel

+ (ThreeItemModel*) getThreeItemFromResponse: (NSDictionary*) response
{
    ThreeItemModel* model = [ThreeItemModel new];
    
    model.iStyle = [response valueForKeyNotNull:@"iStyle"];
    model.items = [ItemModel getItemArrayFromResponse:[response objectForKeyNotNull:@"items"]];
    model.main = [VisibleModel getVisibleArrayFromResponse:[response objectForKeyNotNull:@"main"]];
    model.graphs = [GraphModel getGraphArrayFromResponse:[response objectForKeyNotNull:@"graphs"]];
    
    return model;
}

@end
