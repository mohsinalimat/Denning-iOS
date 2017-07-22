//
//  FileNoteModel.h
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileNoteModel : NSObject

@property (strong, nonatomic) FileNoteSubModel* clsMeetBy;
@property (strong, nonatomic) NSString* noteCode;
@property (strong, nonatomic) NSString* dtDate;
@property (strong, nonatomic) NSString* strFileName;
@property (strong, nonatomic) NSString* strFileNo;
@property (strong, nonatomic) NSString* strNote;

+ (FileNoteModel*)getFileNoteFromResonse:(NSDictionary*) response;

+ (NSArray*) getFileNoteArrayFromResponse:(NSArray*) response;

@end
