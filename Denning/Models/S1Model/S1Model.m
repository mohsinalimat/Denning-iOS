//
//  S1Model.m
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "S1Model.h"

@implementation S1Model

+ (S1Model*) getS1FromResponse:(NSDictionary*) response
{
    S1Model* model = [S1Model new];
    
    model.isVisible = [response valueForKeyNotNull:@"isVisible"];
    model.items = [FirstItemModel getFirstItemArrayFromResponse:[response objectForKeyNotNull:@"items"]];
    model.style = [response valueForKeyNotNull:@"style"];
    model.title = [response valueForKeyNotNull:@"title"];
    
    
    return model;
}

@end
