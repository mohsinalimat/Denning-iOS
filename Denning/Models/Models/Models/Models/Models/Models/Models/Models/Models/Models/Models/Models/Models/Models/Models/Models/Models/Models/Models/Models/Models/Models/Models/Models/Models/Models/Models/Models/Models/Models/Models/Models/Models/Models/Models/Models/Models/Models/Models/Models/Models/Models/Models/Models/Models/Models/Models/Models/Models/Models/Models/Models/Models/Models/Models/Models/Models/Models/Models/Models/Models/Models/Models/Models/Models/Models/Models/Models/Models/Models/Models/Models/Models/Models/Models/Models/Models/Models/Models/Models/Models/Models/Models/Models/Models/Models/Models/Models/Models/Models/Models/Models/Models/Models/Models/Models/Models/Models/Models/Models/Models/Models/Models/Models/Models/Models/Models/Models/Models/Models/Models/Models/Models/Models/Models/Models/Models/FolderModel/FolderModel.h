//
//  FolderModel.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FolderModel : NSObject

@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSArray* folders;
@property (strong, nonatomic) NSArray* documents;

+ (FolderModel*) getFolderFromResponse:(NSDictionary*) response;

+ (NSArray*) getFolderArrayFromResponse: (NSDictionary*) response;
@end
