//
//  GraphModel.m
//  Denning
//
//  Created by Ho Thong Mee on 29/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "GraphModel.h"

@implementation GraphModel

+ (GraphModel*) getGraphFromResponse: (NSDictionary*) response
{
    GraphModel *model = [GraphModel new];
    
    model.graphID = [response valueForKeyNotNull:@"graphID"];
    model.graphName = [response valueForKeyNotNull:@"graphName"];
    model.xLegend = [response valueForKeyNotNull:@"xLegend"];
    model.yLegend = [response valueForKeyNotNull:@"yLegend"];
    model.xValue = [response objectForKeyNotNull:@"xValue"];
    model.yValue = [response objectForKeyNotNull:@"yValue"];
    
    return model;
}

+ (NSArray*) getGraphArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[GraphModel getGraphFromResponse:obj]];
    }
    
    return result;
}

@end
