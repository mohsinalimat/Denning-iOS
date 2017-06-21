//
//  NSDictionary+NotNull.m
//  Pipol
//
//  Created by HiTechLtd on 3/7/16.
//  Copyright © 2016 HiTechLtd. All rights reserved.
//

#import "NSDictionary+NotNull.h"

@implementation NSDictionary (NotNull)

- (id)valueForKeyNotNull:(NSString *)key
{
    id object = [self valueForKey:key];
    if (object != nil && [object isEqual:[NSNull null]])
    {
        object = @"";
    }
    
    if (object == nil || (object != nil && [object isKindOfClass:[NSString class]] && [object isEqualToString:@"NIL"])) {
        object = @"";
    }
    
    return object;
}

- (id)objectForKeyNotNull:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isEqual:[NSNull null]])
    {
        object = nil;
    }
    return object;
}

@end
