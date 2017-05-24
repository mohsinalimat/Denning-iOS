//
//  FileModel.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject


@property (strong, nonatomic) NSString* URL;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* ext;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* size;
@property (strong, nonatomic) NSString* type;

+ (FileModel*) getFileFromResponse: (NSDictionary*) response;

+ (NSArray*) getFileArrayFromResponse: (NSDictionary*) response;


@end
