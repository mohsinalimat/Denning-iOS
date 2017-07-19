//
//  CompletionTrackingModel.m
//  Denning
//
//  Created by Ho Thong Mee on 17/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CompletionTrackingModel.h"

@implementation CompletionTrackingModel

+ (CompletionTrackingModel*) getCompletionTrackingFromResponse:(NSDictionary*) response
{
    CompletionTrackingModel* model = [CompletionTrackingModel new];
    
    model.completionDate = [response valueForKeyNotNull:@"completionDate"];
    model.dayToComplete = [response valueForKeyNotNull:@"dayToComplete"];
    model.extendedDate = [response valueForKeyNotNull:@"extendedDate"];
    model.fileName = [response valueForKeyNotNull:@"fileName"];
    model.fileNo = [response valueForKeyNotNull:@"fileNo"];
    
    return model;
}

+ (NSArray*) getCompletionTrackingArrayFromResponse:(NSArray*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[CompletionTrackingModel getCompletionTrackingFromResponse:obj]];
    }
    
    return result;
}

@end
