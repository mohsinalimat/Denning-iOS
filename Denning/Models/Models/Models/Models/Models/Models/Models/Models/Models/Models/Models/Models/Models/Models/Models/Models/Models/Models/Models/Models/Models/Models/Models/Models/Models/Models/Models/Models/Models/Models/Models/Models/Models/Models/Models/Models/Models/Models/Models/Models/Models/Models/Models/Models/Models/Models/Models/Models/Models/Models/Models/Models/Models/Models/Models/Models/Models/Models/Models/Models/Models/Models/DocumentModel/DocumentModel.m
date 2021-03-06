//
//  DocumentModel.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DocumentModel.h"

@implementation DocumentModel

+ (DocumentModel*) getDocumentFromResponse: (NSDictionary*) response
{
    DocumentModel *documentModel = [DocumentModel new];
    
    documentModel.date = [response objectForKey:@"date"];
    documentModel.name = [response objectForKey:@"name"];
    documentModel.folders = [FolderModel getFolderArrayFromResponse: [response objectForKey:@"folders"]];
    documentModel.documents = [FileModel getFileArrayFromResponse: [response objectForKey:@"documents"]];
    
    return documentModel;
}

+ (NSArray*) getDocumentArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* result = [NSMutableArray new];
    
    for (id model in response) {
        [result addObject:[DocumentModel getDocumentFromResponse:model]];
    }
    
    return [result copy];
}

@end
