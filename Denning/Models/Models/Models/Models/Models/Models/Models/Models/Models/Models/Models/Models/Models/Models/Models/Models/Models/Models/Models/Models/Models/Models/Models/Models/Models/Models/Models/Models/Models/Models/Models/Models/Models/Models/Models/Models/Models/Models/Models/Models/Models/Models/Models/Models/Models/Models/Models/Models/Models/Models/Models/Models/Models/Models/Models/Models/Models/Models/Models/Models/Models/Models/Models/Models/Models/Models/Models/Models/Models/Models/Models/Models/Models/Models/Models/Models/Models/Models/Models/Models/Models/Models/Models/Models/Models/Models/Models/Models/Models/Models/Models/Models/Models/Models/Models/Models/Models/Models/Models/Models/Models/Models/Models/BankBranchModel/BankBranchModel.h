//
//  BankBranchModel.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankBranchModel : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* bankBranchCode;
@property (nonatomic, strong) HQModel* HQ;
@property (nonatomic, strong) CACModel* CAC;

+ (BankBranchModel*) getBankBranchFromResponse:(NSDictionary*) response;

+ (NSArray*) getBankBranchArrayFromResponse:(NSDictionary*) response;

@end
