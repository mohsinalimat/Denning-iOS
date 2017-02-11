//
//  AddressModel.m
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
@synthesize city;
@synthesize country;
@synthesize fullAddress;
@synthesize line1;
@synthesize line2;
@synthesize line3;
@synthesize state;
@synthesize postCode;

+ (AddressModel*) getAddressFromResponse: (NSDictionary*) response
{
    AddressModel* addressModel = [AddressModel new];
    
    addressModel.city = [response objectForKey:@"city"];
    addressModel.country = [response objectForKey:@"country"];
    addressModel.fullAddress = [response objectForKey:@"fullAddress"];
    addressModel.line1 = [response objectForKey:@"line1"];
    addressModel.line2 = [response objectForKey:@"line2"];
    addressModel.line3 = [response objectForKey:@"line3"];
    addressModel.postCode = [response objectForKey:@"postcode"];
    addressModel.state = [response objectForKey:@"state"];
    
    
    return addressModel;
}

+ (NSArray*) getAddressArrayFromResonse: (NSDictionary*) response
{
    NSMutableArray *addressArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [addressArray addObject:[AddressModel getAddressFromResponse:dictionary]];
        }
    }
    
    return addressArray;
}
@end
