//
//  MaterTitleModel.h
//  Denning
//
//  Created by Ho Thong Mee on 26/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasterTitleModel : NSObject

@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* masterCode;
@property (strong, nonatomic) NSString* fullTitle;

+ (MasterTitleModel*) getMasterTitleFromResponse:(NSDictionary*) response;

+ (NSArray*) getMasterTitleArrayFromResponse: (NSArray*) response;

@end
