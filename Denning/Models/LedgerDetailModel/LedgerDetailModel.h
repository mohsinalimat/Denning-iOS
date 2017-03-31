//
//  LedgerDetailModel.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LedgerDetailModel : NSObject

@property (strong, nonatomic) NSString* ChequeNo;
@property (strong, nonatomic) NSString* amount;
@property (strong, nonatomic) NSString* ledgerCode;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* ledgerDescription;
@property (strong, nonatomic) NSString* documentNo;
@property (strong, nonatomic) NSString* drORcr;

+ (LedgerDetailModel*) getLedgerDetailFromResponse: (NSDictionary*) response;

+ (NSArray*) getLedgerDetailArrayFromResponse: (NSDictionary*) response;

@end
