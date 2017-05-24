//
//  MatterCodeModel.m
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MatterCodeModel.h"

@implementation MatterCodeModel

+ (MatterCodeModel*) getMatterCodeFromResponse:(NSDictionary*) response
{
    MatterCodeModel* model = [MatterCodeModel new];
    model.category = [response objectForKeyNotNull:@"category"];
    model.matterCode = [response objectForKeyNotNull:@"code"];
    model.matterDescription = [response objectForKeyNotNull:@"description"];
    model.department = [response objectForKeyNotNull:@"department"];
    model.formName = [response objectForKeyNotNull:@"formName"];
    model.groupName1 = [response objectForKeyNotNull:@"groupName1"];
    model.groupName2 = [response objectForKeyNotNull:@"groupName2"];
    model.groupName3 = [response objectForKeyNotNull:@"groupName3"];
    model.groupName4 = [response objectForKeyNotNull:@"groupName4"];
    model.groupName5 = [response objectForKeyNotNull:@"groupName5"];
    model.isRental = [response objectForKeyNotNull:@"isRental"];
    model.turnAround = [response objectForKeyNotNull:@"turnAround"];
    
    return model;
}

+ (NSArray*) getMatterCodeArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[MatterCodeModel getMatterCodeFromResponse:obj]];
    }
    
    return result;
}
@end
