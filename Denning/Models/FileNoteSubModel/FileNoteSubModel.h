//
//  FileNoteSubModel.h
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileNoteSubModel : NSObject

@property (strong, nonatomic) NSString* subCode;
@property (strong, nonatomic) NSString* strIdno;
@property (strong, nonatomic) NSString* strInitials;
@property (strong, nonatomic) NSString* strName;

+ (FileNoteSubModel*) getFileNoteSubFromResponse:(NSDictionary*) response;
@end
