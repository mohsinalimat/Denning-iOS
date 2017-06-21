//
//  TaskCheckModel.m
//  Denning
//
//  Created by Ho Thong Mee on 02/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TaskCheckModel.h"

@implementation TaskCheckModel

+ (TaskCheckModel*) getTaskCheckFromResponse: (NSDictionary*) response
{
    TaskCheckModel* model = [TaskCheckModel new];
    
    model.fileName = [response valueForKeyNotNull:@"fileName"];
    model.fileNo = [response valueForKeyNotNull:@"fileNo"];
    model.clerkName = [response valueForKeyNotNull:@"clerkName"];
    model.startDate = [response valueForKeyNotNull:@"startDate"];
    model.endDate = [response valueForKeyNotNull:@"endDate"];
    model.taskName = [response valueForKeyNotNull:@"taskName"];
    
    return model;
}

+ (NSArray*) getTaskCheckArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[TaskCheckModel getTaskCheckFromResponse:obj]];
    }
    
    return result;
}
@end
