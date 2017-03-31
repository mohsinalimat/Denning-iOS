//
//  LedgerModel.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LedgerModel : NSObject

@property (strong, nonatomic) NSString* accountName;
@property (strong, nonatomic) NSString* accountType;
@property (strong, nonatomic) NSString* availableBalance;
@property (strong, nonatomic) NSString* currentBalance;
@property (strong, nonatomic) NSString* lastStatementDate;

+ (LedgerModel*) getLedgerFromResponse: (NSDictionary*) response;

+ (NSArray*) getLedgerArrayFromResponse: (NSDictionary*) response;

@end
