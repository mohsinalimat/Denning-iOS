//
//  FullPropertyModel.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullPropertyModel : NSObject

@property (nonatomic, strong) NSString* propertyCode;
@property (nonatomic, strong) NSString* fullTitle;
@property (nonatomic, strong) NSString* projectName;
@property (nonatomic, strong) AddressModel* address;
@property (nonatomic, strong) CodeDescription* spaParcel;
@property (nonatomic, strong) NSString* spaCondoName;

+ (FullPropertyModel*) getFullPropertyFromResponse:(NSDictionary*) response;

+ (NSArray*) getFullPropertyArrayFromResponse: (NSDictionary*) response;

@end
