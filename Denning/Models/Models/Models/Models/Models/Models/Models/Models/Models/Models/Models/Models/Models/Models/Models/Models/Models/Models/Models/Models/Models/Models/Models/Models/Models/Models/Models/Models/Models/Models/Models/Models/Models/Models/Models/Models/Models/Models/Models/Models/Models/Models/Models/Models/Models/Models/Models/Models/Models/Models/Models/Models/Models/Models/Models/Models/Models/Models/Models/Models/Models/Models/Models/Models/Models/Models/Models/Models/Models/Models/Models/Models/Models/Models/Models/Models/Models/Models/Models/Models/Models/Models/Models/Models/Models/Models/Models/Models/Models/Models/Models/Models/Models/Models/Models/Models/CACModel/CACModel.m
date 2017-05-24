
//
//  CACModel.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CACModel.h"

@implementation CACModel

+ (CACModel*) getCACFromResponse:(NSDictionary*) response
{
    CACModel* model = [CACModel new];
    
    model.IDNo = [response valueForKeyNotNull:@"IDNo"];
    model.name = [response valueForKeyNotNull:@"name"];
    return model;
}
@end
