//
//  TypeValueModel.h
//  Denning
//
//  Created by DenningIT on 20/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeValueModel : NSObject
@property(strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *value;

+ (TypeValueModel*) getTypeValueFromResponse: (NSDictionary*) resposne;

+ (NSArray*) getTypeValueArrayFromResponse: (NSDictionary*) response;
@end
