//
//  CodeDescription.m
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CodeDescription.h"

@implementation CodeDescription

+ (CodeDescription*) getCodeDescriptionFromResponse: (NSDictionary*) resposne
{
    CodeDescription* codeDescription = [CodeDescription new];
    
    codeDescription.codeValue = [resposne valueForKeyNotNull:@"code"];
    codeDescription.descriptionValue = [resposne valueForKeyNotNull:@"description"];
    
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
