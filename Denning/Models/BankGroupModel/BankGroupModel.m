//
//  BankModel.m
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BankGroupModel.h"

@implementation BankGroupModel

+(BankGroupModel*) getBankGroupFromResponse: (NSDictionary*) response
{
    BankGroupModel* bankGroupModel = [BankGroupModel new];
    bankGroupModel.bankGroupName = [response objectForKey:@"groupName"];
    if ([[response objectForKey:@"bank"] isKindOfClass:[NSNull class]]) {
        bankGroupModel.bankCode = @"";
        bankGroupModel.bankName = @"";
    } else {
        bankGroupModel.bankCode = [[response objectForKey:@"bank"] objectForKey:@"code"];
        bankGroupModel.bankName = [[response objectForKey:@"bank"] objectForKey:@"name"];
    }
    
    return bankGroupModel;
}

+(NSArray*) getBankGroupArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* bankGroupArray = [NSMutableArray new];
    for (id group in response){
        BankGroupModel* model = [BankGroupModel getBankGroupFromResponse:group];
        [bankGroupArray addObject:model];
    }
    return bankGroupArray;
}
@end
