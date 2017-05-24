//
//  CityModel.h
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *postcode;
@property (strong, nonatomic) NSString *state;

+ (CityModel*) getCityModelFromResponse: (NSDictionary*) response;

+ (NSArray*) getCityModelArrayFromResponse: (NSDictionary*) response;

@end
