//
//  FirmModel.h
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressModel;

@interface FirmModel : NSObject

@property (strong, nonatomic) NSString * IDNo;

@property (strong, nonatomic) NSString * IDType;

@property (strong, nonatomic) AddressModel * address;

@property (strong, nonatomic) NSString * firmCode;

@property (strong, nonatomic) NSString * emailAddress;

@property (strong, nonatomic) NSString * name;

@property (strong, nonatomic) NSString * phoneFax;

@property (strong, nonatomic) NSString * phoneHome;

@property (strong, nonatomic) NSString * phoneMobile;

@property (strong, nonatomic) NSString * phoneOffice;

@property (strong, nonatomic) NSString * title;

@property (strong, nonatomic) NSString * website;


+ (FirmModel*) getFirmModelFromResponse: (NSDictionary*) response;

+ (NSArray*) getFirmArrayFromResponse: (NSDictionary*) response;


@end
