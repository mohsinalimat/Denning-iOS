//
//  HQModel.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "HQModel.h"

@implementation HQModel

+ (HQModel*) getHQFromResponse:(NSDictionary*) response
{
    HQModel* model = [HQModel new];
//    
//    model.IDNo = [response valueForKeyNotNull:@"IDNo"];
    model.name = [response valueForKeyNotNull:@"name"];
    return model;
}

@end
