//
//  PropertyModel.h
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyModel : NSObject

@property (strong, nonatomic) NSString* key;
@property (strong, nonatomic) NSString* fullTitle;
@property (strong, nonatomic) NSString* lotptType;
@property (strong, nonatomic) NSString* lotptValue;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* area;
@property (strong, nonatomic) NSArray* relatedMatter;
@property (strong, nonatomic) NSString* matterDescription;

+ (PropertyModel*) getPropertyFromResponse: (NSDictionary*) response;

+(NSArray*) getPropertyArrayFromResponse: (NSDictionary*) response;

@end
