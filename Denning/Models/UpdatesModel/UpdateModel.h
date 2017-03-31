//
//  UpdateModel.h
//  Denning
//
//  Created by DenningIT on 31/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateModel : NSObject

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

+ (UpdateModel*) getUpdateFromResponse: (NSDictionary*) response;

+ (NSArray*) getUpdatesArrayFromResponse: (NSDictionary*) response;

@end
