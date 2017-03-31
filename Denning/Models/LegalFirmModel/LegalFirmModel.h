//
//  LegalFirmModel.h
//  Denning
//
//  Created by DenningIT on 13/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LegalFirmModel : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* IDNo;
@property (strong, nonatomic) NSString* tel;
@property (strong, nonatomic) NSString* fax;
@property (strong, nonatomic) NSString* mobile;
@property (strong, nonatomic) NSString* office;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSArray* relatedMatter;

+ (LegalFirmModel*) getLegalFirmFromResponse: (NSDictionary*) response;

@end
