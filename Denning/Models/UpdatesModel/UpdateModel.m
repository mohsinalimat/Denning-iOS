//
//  UpdateModel.m
//  Denning
//
//  Created by DenningIT on 31/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "UpdateModel.h"

@implementation UpdateModel


+ (UpdateModel*) getUpdateFromResponse: (NSDictionary*) response
{
    UpdateModel* updateModel = [UpdateModel new];
    
    updateModel.URL = [response objectForKey:@"URL"];
    updateModel.category = [response objectForKey:@"category"];
    updateModel.newsCode = [response objectForKey:@"code"];
    updateModel.fullDescription = [response objectForKey:@"fullDesc"];
    if ([[response objectForKey:@"img"] isKindOfClass:[NSNull class]]) {
        updateModel.imageURL = @"";
        updateModel.imageData = @"";
    } else {
        updateModel.imageURL = [[response objectForKey:@"img"] objectForKey:@"FileName"];
        updateModel.imageData = [[response objectForKey:@"img"] objectForKey:@"base64"];
    }
    
    updateModel.imageURL = [[response objectForKey:@"img"] objectForKey:@"FileName"];
    updateModel.imageData = [[response objectForKey:@"img"] objectForKey:@"base64"];
    updateModel.reminder = [response objectForKey:@"reminder"];
    updateModel.shortDescription = [response objectForKey:@"shortDesc"];
    updateModel.theDateTime = [response objectForKey:@"theDateTime"];
    updateModel.title = [response objectForKey:@"title"];
    
    return updateModel;
}

+ (NSArray*) getUpdatesArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *updatesArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [updatesArray addObject:[UpdateModel getUpdateFromResponse:dictionary]];
        }
    }
    
    return updatesArray;
}

@end
