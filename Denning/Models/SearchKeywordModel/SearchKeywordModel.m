//
//  SearchGeneralModel.m
//  MPAutoComplete
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 Custom Apps. All rights reserved.
//

#import "SearchKeywordModel.h"

@implementation SearchKeywordModel

+ (SearchKeywordModel*) getSearchKeywordModelFromResponse: (NSDictionary*) response
{
    SearchKeywordModel* searchKeywordModel = [SearchKeywordModel new];
    
    searchKeywordModel.keyword = [response objectForKey:@"keyword"];
    searchKeywordModel.score = [response objectForKey:@"score"];
    return searchKeywordModel;
}

+ (NSArray*) getSearchKeywordArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *searchKeywordArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [searchKeywordArray addObject: [SearchKeywordModel getSearchKeywordModelFromResponse: dictionary]];
        }
    }
    
    return searchKeywordArray;
}

@end
