//
//  NewsModel.h
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (strong, nonatomic) NSString * URL;

@property (strong, nonatomic) NSString * category;

@property (strong, nonatomic) NSString * newsCode;

@property (strong, nonatomic) NSString * fullDescription;

@property (strong, nonatomic) NSString * imageURL;

@property (strong, nonatomic) NSString * imageData;

@property (strong, nonatomic) NSString * reminder;

@property (strong, nonatomic) NSString * shortDescription;

@property (strong, nonatomic) NSString * theDateTime;

@property (strong, nonatomic) NSString * title;

+ (NewsModel*) getNewsFromResponse: (NSDictionary*) response;

+ (NSArray*) getNewsArrayFromResponse: (NSDictionary*) response;
@end
