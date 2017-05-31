//
//  VisibleModel.m
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "VisibleModel.h"

@implementation VisibleModel

+ (VisibleModel*) getVisibleFromReponse:(NSDictionary*) response
{
    VisibleModel *model = [VisibleModel new];
    
    model.iStyle = [response valueForKeyNotNull:@"iStyle"];
    model.sessionAPI = [response valueForKeyNotNull:@"sessionAPI"];
    model.isVisible = [response valueForKeyNotNull:@"isVisible"];
    model.sessionID = [response valueForKeyNotNull:@"sessionID"];
    model.sessionName = [response valueForKeyNotNull:@"sessionName"];
    
    
    return model;
}

+ (NSArray*) getVisibleArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[VisibleModel getVisibleFromReponse:obj]];
    }
    
    return result;
}

@end
