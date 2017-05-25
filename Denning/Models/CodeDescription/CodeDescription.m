//
//  CodeDescription.m
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CodeDescription.h"

@implementation CodeDescription

+ (CodeDescription*) getCodeDescriptionFromResponse: (NSDictionary*) response
{
    CodeDescription* codeDescription = [CodeDescription new];
    
    if (response) {
        codeDescription.codeValue = [response valueForKeyNotNull:@"code"];
        codeDescription.descriptionValue = [response valueForKeyNotNull:@"description"];
    } else {
        codeDescription.codeValue = @"";
        codeDescription.descriptionValue = @"";
    }
    
    return codeDescription;
}

+ (NSArray*) getCodeDescriptionArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[CodeDescription getCodeDescriptionFromResponse:obj]];
    }
    return result;
}

@end
