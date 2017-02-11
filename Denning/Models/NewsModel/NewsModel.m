//
//  NewsModel.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
@synthesize URL;
@synthesize category;
@synthesize newsCode;
@synthesize fullDescription;
@synthesize imageURL;
@synthesize reminder;
@synthesize shortDescription;
@synthesize theDateTime;
@synthesize title;

+ (NewsModel*) getNewsFromResponse: (NSDictionary*) response
{
    NewsModel* newsModel = [NewsModel new];
    
    newsModel.URL = [response objectForKey:@"URL"];
    newsModel.category = [response objectForKey:@"category"];
    newsModel.newsCode = [response objectForKey:@"code"];
    newsModel.fullDescription = [response objectForKey:@"fullDesc"];
    newsModel.imageURL = [[response objectForKey:@"img"] objectForKey:@"FileName"];
    newsModel.reminder = [response objectForKey:@"reminder"];
    newsModel.shortDescription = [response objectForKey:@"shortDesc"];
    newsModel.theDateTime = [response objectForKey:@"theDateTime"];
    newsModel.title = [response objectForKey:@"title"];
    
    return newsModel;
}

+ (NSArray*) getNewsArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *newsArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [newsArray addObject:[NewsModel getNewsFromResponse:dictionary]];
        }
    }
    
    return newsArray;
}

@end
