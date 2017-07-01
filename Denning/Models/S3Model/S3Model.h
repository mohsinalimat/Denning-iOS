//
//  S3Model.h
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S3Model : NSObject

@property(strong, nonatomic) NSString* isVisible;
@property(strong, nonatomic) NSArray<ThirdItemModel*>* items;
@property(strong, nonatomic) NSString* style;
@property(strong, nonatomic) NSString* title;

+ (S3Model*) getS3FromResponse:(NSDictionary*) response;


@end
