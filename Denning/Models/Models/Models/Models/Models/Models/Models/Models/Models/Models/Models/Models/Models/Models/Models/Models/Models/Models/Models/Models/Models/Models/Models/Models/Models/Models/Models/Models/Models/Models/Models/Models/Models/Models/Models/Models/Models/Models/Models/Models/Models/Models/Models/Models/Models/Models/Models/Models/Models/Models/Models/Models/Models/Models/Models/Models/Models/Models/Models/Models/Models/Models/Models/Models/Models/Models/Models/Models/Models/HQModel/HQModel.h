//
//  HQModel.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQModel : NSObject

@property (nonatomic, strong) NSString* IDNo;

@property (nonatomic, strong) NSString* name;

+ (HQModel*) getHQFromResponse:(NSDictionary*) response;

@end
