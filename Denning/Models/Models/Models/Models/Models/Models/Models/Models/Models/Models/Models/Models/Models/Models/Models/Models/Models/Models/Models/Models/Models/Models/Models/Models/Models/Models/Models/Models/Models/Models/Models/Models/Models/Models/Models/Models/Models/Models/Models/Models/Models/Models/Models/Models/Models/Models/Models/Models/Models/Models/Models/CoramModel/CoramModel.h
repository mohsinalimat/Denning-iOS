//
//  CoramModel.h
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoramModel : NSObject

@property (strong, nonatomic) NSString* coramCode;
@property (strong, nonatomic) NSString* courtType;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* position;

+ (CoramModel*) getCoramFromResponse: (NSDictionary*) response;

+ (NSArray*) getCoramArrayFromResponse: (NSDictionary*) response;

@end
