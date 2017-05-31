//
//  ThreeItemModel.h
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreeItemModel : NSObject

@property (strong, nonatomic) NSNumber* iStyle;
@property (strong, nonatomic) NSArray* graphs;
@property (strong, nonatomic) NSArray* main;
@property (strong, nonatomic) NSArray* items;

+ (ThreeItemModel*) getThreeItemFromResponse: (NSDictionary*) response;

@end
