//
//  CACModel.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACModel : NSObject
@property (nonatomic, strong) NSString* IDNo;

@property (nonatomic, strong) NSString* name;


+ (CACModel*) getCACFromResponse:(NSDictionary*) response;
@end
