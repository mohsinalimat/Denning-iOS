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
@synthesize lotpt;
@synthesize address;
@synthesize area;
@synthesize relatedMatter;

+ (PropertyModel*) getPropertyFromResponse: (NSDictionary*) response
{
    PropertyModel* propertyModel = [PropertyModel new];
    propertyModel.fullTitle = [response objectForKey:@"fullTitle"];
    NSDictionary* lotptObject = [response objectForKey:@"lotPt"];
    propertyModel.lotpt = [NSString stringWithFormat:@"%@(%@)", [lotptObject objectForKey:@"type"], [lotptObject objectForKey:@"value"]];
    NSDictionary* areaObject = [response objectForKey:@"area"];
    propertyModel.area = [NSString stringWithFormat:@"%@(%@)", [areaObject objectForKey:@"type"], [areaObject objectForKey:@"value"]];
    propertyModel.address = [response objectForKey:@"address"];
    propertyModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKey:@"relatedMatter"]];
    
    return propertyModel;
}

@end
