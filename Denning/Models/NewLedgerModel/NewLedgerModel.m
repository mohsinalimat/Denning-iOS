//
//  NewLedgerModel.m
//  Denning
//
//  Created by DenningIT on 19/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewLedgerModel.h"

@implementation NewLedgerModel

+ (NewLedgerModel*) getNewLedgerModelFromResponse: (NSDictionary*) response
{
    NewLedgerModel* newLedgerModel = [NewLedgerModel new];
    newLedgerModel.fileNo = [response objectForKey:@"fileNo"];
    newLedgerModel.fileName = [response objectForKey:@"fileName"];
    newLedgerModel.ledgerModelArray = [LedgerModel getLedgerArrayFromResponse:[response objectForKey:@"accountType"]];
    return newLedgerModel;
}
@end
