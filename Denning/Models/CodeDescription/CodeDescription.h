//
//  CodeDescription.h
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeDescription : NSObject

@property(strong, nonatomic) NSString *codeValue;
@property (strong, nonatomic) NSString *descriptionValue;

+ (CodeDescription*) getCodeDescriptionFromResponse: (NSDictionary*) response;

+ (NSArray*) getCodeDescriptionArrayFromResponse: (NSDictionary*) response;
@end
