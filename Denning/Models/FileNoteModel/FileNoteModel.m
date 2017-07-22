//
//  FileNoteModel.m
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FileNoteModel.h"

@implementation FileNoteModel

+ (FileNoteModel*)getFileNoteFromResonse:(NSDictionary*) response
{
    FileNoteModel* model = [FileNoteModel new];
    
    model.clsMeetBy = [FileNoteSubModel getFileNoteSubFromResponse:[response objectForKeyNotNull:@"clsMeetBy"]];
    model.noteCode = [response valueForKeyNotNull:@"code"];
    model.dtDate = [response valueForKeyNotNull:@"dtDate"];
    model.strFileName = [response valueForKeyNotNull:@"strFileName"];
    model.strFileNo = [response valueForKeyNotNull:@"strFileNo"];
    model.strNote = [response valueForKeyNotNull:@"strNote"];
    return model;
}

+ (NSArray*) getFileNoteArrayFromResponse:(NSArray*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[FileNoteModel getFileNoteFromResonse:obj]];
    }
    
    return result;
}

@end
