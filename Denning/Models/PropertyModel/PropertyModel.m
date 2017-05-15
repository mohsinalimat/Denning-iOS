//
//  PropertyModel.m
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PropertyModel.h"

@implementation PropertyModel
@synthesize fullTitle;
@synthesize lotptType;
@synthesize lotptValue;
@synthesize address;
@synthesize area;
@synthesize relatedMatter;

+ (PropertyModel*) getPropertyFromResponse: (NSDictionary*) response
{
    PropertyModel* propertyModel = [PropertyModel new];
    propertyModel.key = [response objectForKey:@"code"];
    if ([[response objectForKey:@"code"] isKindOfClass:[NSNull class]]) {
        propertyModel.key = @"";
    }

    propertyModel.fullTitle = [response objectForKey:@"fullTitle"];
    if ([[response objectForKey:@"fullTitle"] isKindOfClass:[NSNull class]]) {
        propertyModel.fullTitle = @"";
    }
    NSDictionary* lotptObject = [response objectForKey:@"lotPT"];
    propertyModel.lotptType = [lotptObject objectForKey:@"type"];
    if ([lotptObject isKindOfClass:[NSNull class]]) {
        propertyModel.lotptType = @"";
        propertyModel.lotptValue = @"";
    }
    propertyModel.lotptValue = [lotptObject objectForKey:@"value"];

    NSDictionary* areaObject = [response objectForKey:@"area"];
    propertyModel.area = [NSString stringWithFormat:@"%@(%@)", [areaObject objectForKey:@"type"], [areaObject objectForKey:@"value"]];
    propertyModel.address = [response objectForKey:@"address"];
    if ([[response objectForKey:@"address"] isKindOfClass:[NSNull class]]) {
        propertyModel.address = @"";
    }
    propertyModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKey:@"relatedMatter"]];
    propertyModel.matterDescription = @"";
    for(SearchResultModel* model in propertyModel.relatedMatter) {
        propertyModel.matterDescription = [NSString stringWithFormat:@"%@, %@", propertyModel.matterDescription, model.key];
    }

    return propertyModel;
}

+(NSArray*) getPropertyArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* propertyArray = [NSMutableArray new];
    for (id object in response) {
        PropertyModel* propertyModel = [PropertyModel getPropertyFromResponse:object];
        [propertyArray addObject:propertyModel];
    }
    return propertyArray;
}
@end
