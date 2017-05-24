//
//  FolderModel.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FolderModel.h"

@implementation FolderModel

+ (FolderModel*) getFolderFromResponse:(NSDictionary*) response
{
    FolderModel *folderModel = [FolderModel new];
    
    folderModel.date = [response objectForKey:@"date"];
    folderModel.name = [response objectForKey:@"name"];
    folderModel.folders = [FolderModel getFolderArrayFromResponse: [response objectForKey:@"folders"]];
    folderModel.documents = [FileModel getFileArrayFromResponse: [response objectForKey:@"documents"]];
    
    return folderModel;
}

+ (NSArray*) getFolderArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* result = [NSMutableArray new];
    
    for (id model in response) {
        if (![model isKindOfClass:[NSNull class]]) {
            [result addObject:[FolderModel getFolderFromResponse:model]];
        }
    }
    
    return [result copy];

}
@end
