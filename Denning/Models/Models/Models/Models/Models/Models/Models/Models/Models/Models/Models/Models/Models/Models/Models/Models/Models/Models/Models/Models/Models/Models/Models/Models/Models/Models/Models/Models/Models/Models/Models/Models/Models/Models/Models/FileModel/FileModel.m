//
//  FileModel.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

+ (FileModel*) getFileFromResponse: (NSDictionary*) response
{
    FileModel *fileModel = [FileModel new];
    
    fileModel.URL = [response objectForKey:@"URL"];
    fileModel.date = [response objectForKey:@"date"];
    fileModel.ext = [response objectForKey:@"ext"];
    fileModel.name = [response objectForKey:@"name"];
    fileModel.size = [response objectForKey:@"size"];
    fileModel.type = [response objectForKey:@"type"];
    
    return fileModel;
}

+ (NSArray*) getFileArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* result = [NSMutableArray new];
    
    for (id model in response) {
        [result addObject:[FileModel getFileFromResponse:model]];
    }
    
    return [result copy];
}

@end
