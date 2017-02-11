//
//  SearchGeneralModel.h
//  MPAutoComplete
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 Custom Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchKeywordModel : NSObject

@property (nonatomic, strong) NSString * keyword;

@property (strong, nonatomic) NSString * score;

+ (SearchKeywordModel*) getSearchKeywordModelFromResponse: (NSDictionary*) response;

+ (NSArray*) getSearchKeywordArrayFromResponse: (NSDictionary*) response;
@end
