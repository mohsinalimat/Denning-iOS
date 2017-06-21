//
//  DashboardLedgerModel.h
//  Denning
//
//  Created by Ho Thong Mee on 02/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashboardLedgerModel.h"

@interface DashboardLedgerModel : NSObject
@property (strong, nonatomic) NSString* API;
@property (strong, nonatomic) NSString* accountName;
@property (strong, nonatomic) NSString* accountNo;
@property (strong, nonatomic) NSString* credit;
@property (strong, nonatomic) NSString* debit;
@property (strong, nonatomic) NSString* lastMovement;
@property (strong, nonatomic) NSString* pid;

+ (DashboardLedgerModel*) getDashboardLedgerFromResponse: (NSDictionary*) response;

+ (NSArray*) getDashboardLedgerArrayFromResponse: (NSDictionary*) response;
@end
