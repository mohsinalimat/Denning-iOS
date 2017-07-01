//
//  S2Model.m
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "S2Model.h"

@implementation S2Model

+ (S2Model*) getS2FromResponse: (NSDictionary*) response
{
    S2Model* model = [S2Model new];
    
    model.isVisible = [response valueForKeyNotNull:@"isVisible"];
    model.items = [SecondItemModel getSecondItemArrayFromResponse:[response objectForKeyNotNull:@"items"]];
    model.style = [response valueForKeyNotNull:@"style"];
    model.title = [response valueForKeyNotNull:@"title"];
    
    return model;
}

@end
