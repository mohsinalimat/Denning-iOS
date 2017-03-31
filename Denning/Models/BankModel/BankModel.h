//
//  BankModel.h
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* IDNo;
@property (strong, nonatomic) NSString* tel;
@property (strong, nonatomic) NSString* fax;
@property (strong, nonatomic) NSString* mobile;
@property (strong, nonatomic) NSString* office;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSArray* relatedMatter;

+ (BankModel*) getBankFromResponse: (NSDictionary*) response;

@end
