//
//  MukimModel.h
//  Denning
//
//  Created by Ho Thong Mee on 06/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MukimModel : NSObject

@property (strong, nonatomic) NSString* mukimCode;
@property (strong, nonatomic) NSString* daerah;
@property (strong, nonatomic) NSString* mukim;
@property (strong, nonatomic) NSString* negeri;
@property (strong, nonatomic) NSString* sCode;

+ (MukimModel*) getMukimFromResponse: (NSDictionary*) response;

+ (NSArray*) getMukimArrayFromReponse: (NSDictionary*) response;

@end
