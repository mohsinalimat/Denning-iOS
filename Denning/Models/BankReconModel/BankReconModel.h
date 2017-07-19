//
//  BankReconModel.h
//  Denning
//
//  Created by Ho Thong Mee on 14/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankReconModel : NSObject

@property (strong, nonatomic) NSString* API;
@property (strong, nonatomic) NSString* accountName;
@property (strong, nonatomic) NSString* accountNo;
@property (strong, nonatomic) NSString* credit;
@property (strong, nonatomic) NSString* debit;
@property (strong, nonatomic) NSString* lastMovement;
@property (strong, nonatomic) NSString* pid;

+ (BankReconModel*) getBankReconFromResponse:(NSDictionary*) response;

+ (NSArray*) getBankReconArrayFromResponse:(NSArray*) response;

@end
