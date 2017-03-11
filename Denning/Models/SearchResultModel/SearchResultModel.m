//
//  SearchResultModel.m
//  MPAutoComplete
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 Custom Apps. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
@synthesize description;
@synthesize form;

+ (SearchResultModel*) getSearchResultFromResponse: (NSDictionary*) response
{
    SearchResultModel* searchResult = [SearchResultModel new];
    searchResult.description = [response objectForKey:@"Desc"];
    searchResult.form = [response objectForKey:@"Form"];
    searchResult.header = [response objectForKey:@"Header"];
    searchResult.indexData = [response objectForKey:@"IndexData"];
    searchResult.score = [response objectForKey:@"Score"];
    searchResult.title = [response objectForKey:@"Title"];
    searchResult.searchCode = [response objectForKey:@"code"];
    searchResult.dummy = [response objectForKey:@"dummy"];
    searchResult.key = [response objectForKey:@"key"];
    searchResult.row_number = [response objectForKey:@"row_number"];
    
    return searchResult;
}

+ (NSArray*) getSearchResultArrayFromResponse: (NSArray*) response
{
    NSMutableArray *searchResultArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [searchResultArray addObject:[SearchResultModel getSearchResultFromResponse:dictionary]];
        }
    }
    
    return searchResultArray;
}
@end
