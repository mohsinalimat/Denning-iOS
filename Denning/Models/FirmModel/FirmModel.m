//
//  FirmModel.m
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FirmModel.h"
#include "AddressModel.h"

@implementation FirmModel

@synthesize IDNo;
@synthesize IDType;
@synthesize address;
@synthesize firmCode;
@synthesize emailAddress;
@synthesize name;
@synthesize phoneFax;
@synthesize phoneHome;
@synthesize phoneMobile;
@synthesize phoneOffice;
@synthesize title;
@synthesize website;

+ (FirmModel*) getFirmModelFromResponse: (NSDictionary*) response
{
    FirmModel* firmModel = [FirmModel new];
    firmModel.IDNo = [response objectForKey:@"IDNo"];
    firmModel.IDType = [response objectForKey:@"IDType"];
    firmModel.address = [AddressModel getAddressFromResponse: [response objectForKey:@"address"]];
    firmModel.firmCode = [response objectForKey:@"code"];
    firmModel.emailAddress = [response objectForKey:@"emailAddress"];
    firmModel.name = [response objectForKey:@"name"];
    firmModel.phoneFax = [response objectForKey:@"phoneFax"];
    firmModel.phoneHome = [response objectForKey:@"phoneHome"];
    firmModel.phoneMobile = [response objectForKey:@"phoneMobile"];
    firmModel.phoneOffice = [response objectForKey:@"phoneOffice"];
    firmModel.title = [response objectForKey:@"title"];
    firmModel.website = [response objectForKey:@"website"];
    
    return firmModel;
}

+ (NSArray*) getFirmArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray *firmArray = [[NSMutableArray alloc] init];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [firmArray addObject:[FirmModel getFirmModelFromResponse:dictionary]];
        }
    }
    
    return firmArray;
}

@end
