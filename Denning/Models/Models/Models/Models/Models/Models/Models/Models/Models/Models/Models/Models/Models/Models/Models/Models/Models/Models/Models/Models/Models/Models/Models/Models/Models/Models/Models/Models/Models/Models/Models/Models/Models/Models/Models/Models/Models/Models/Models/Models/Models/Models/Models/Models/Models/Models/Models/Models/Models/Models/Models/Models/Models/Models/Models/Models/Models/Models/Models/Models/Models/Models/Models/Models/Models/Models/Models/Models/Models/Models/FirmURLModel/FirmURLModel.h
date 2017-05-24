//
//  FirmURLModel.h
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

@interface FirmURLModel : NSObject

@property(strong, nonatomic) NSString      *firmServerURL;
@property(strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString     *city;
@property(strong, nonatomic) DocumentModel* document;

+ (FirmURLModel*) getFirmModelFromResponse: (NSDictionary*) response;

+ (NSArray*) getFirmArrayFromResponse:(NSArray*) response;

@end
