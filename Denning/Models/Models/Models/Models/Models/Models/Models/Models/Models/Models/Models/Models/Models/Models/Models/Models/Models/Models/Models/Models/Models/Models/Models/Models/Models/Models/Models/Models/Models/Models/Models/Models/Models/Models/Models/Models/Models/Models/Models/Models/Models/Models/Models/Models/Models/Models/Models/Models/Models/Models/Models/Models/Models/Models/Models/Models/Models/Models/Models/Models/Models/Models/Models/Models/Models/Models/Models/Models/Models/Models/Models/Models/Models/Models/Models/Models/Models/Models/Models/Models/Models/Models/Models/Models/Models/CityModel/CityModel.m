//
//  CityModel.m
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (CityModel*) getCityModelFromResponse: (NSDictionary*) response
{
    CityModel *cityModel = [CityModel new];
    
    cityModel.city = [response objectForKey:@"city"];
    cityModel.country = [response objectForKey:@"country"];
    cityModel.postcode = [response objectForKey:@"postcode"];
    cityModel.state = [response objectForKey:@"state"];
    
    return cityModel;
}

+ (NSArray*) getCityModelArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* result = [NSMutableArray new];
    for (id obj in response) {
        [result addObject:[CityModel getCityModelFromResponse:obj]];
    }
    return result;
}

@end
