//
//  AddressModel.h
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (strong, nonatomic) NSString * city;

@property (strong, nonatomic) NSString * country;

@property (strong, nonatomic) NSString * fullAddress;

@property (strong, nonatomic) NSString * line1;

@property (strong, nonatomic) NSString * line2;

@property (strong, nonatomic) NSString * line3;

@property (strong, nonatomic) NSString * postCode;

@property (strong, nonatomic) NSString * state;


+ (AddressModel*) getAddressFromResponse: (NSDictionary*) response;

+ (NSArray*) getAddressArrayFromResonse: (NSDictionary*) response;

@end
