//
//  ItemModel.h
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (strong, nonatomic) NSString* api;
@property (strong, nonatomic) NSString* label;
@property (strong, nonatomic) NSString* itemId;
@property (strong, nonatomic) NSString* value;

+ (ItemModel*) getItemFromResponse: (NSDictionary*) response;

+ (NSArray*) getItemArrayFromResponse: (NSDictionary*) response;
@end
