//
//  BankModel.m
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

+ (BankModel*) getBankFromResponse: (NSDictionary*) response

{
    BankModel* bankModel = [BankModel new];
    
    id HQ = [response objectForKey:@"HQ"];
    bankModel.name = [HQ objectForKey:@"name"];
    if ([[response objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        bankModel.name = @"";
    }
    
    bankModel.IDNo = [HQ objectForKey:@"IDNo"];
    if ([[response objectForKey:@"IDNo"] isKindOfClass:[NSNull class]]) {
        bankModel.IDNo = @"";
    }

    bankModel.tel = [response objectForKey:@"phoneOffice"];
    if ([[response objectForKey:@"phoneOffice"] isKindOfClass:[NSNull class]]) {
        bankModel.tel = @"";
    }
    bankModel.fax = [response objectForKey:@"phoneFax"];
    if ([[response objectForKey:@"phoneFax"] isKindOfClass:[NSNull class]]) {
        bankModel.fax = @"";
    }
    bankModel.mobile = [response objectForKey:@"phoneMobile"];
    if ([[response objectForKey:@"phoneMobile"] isKindOfClass:[NSNull class]]) {
        bankModel.mobile = @"";
    }
    bankModel.office = [response objectForKey:@"phoneOffice"];
    if ([[response objectForKey:@"phoneOffice"] isKindOfClass:[NSNull class]]) {
        bankModel.office = @"";
    }
    bankModel.email = [response objectForKey:@"emailAddress"];
    if ([[response objectForKey:@"emailAddress"] isKindOfClass:[NSNull class]]) {
        bankModel.email = @"";
    }
    bankModel.address = [[response objectForKey:@"address"] objectForKey:@"fullAddress"];;
    if ([[response objectForKey:@"address"] isKindOfClass:[NSNull class]]) {
        bankModel.address = @"";
    }
    
    bankModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKey:@"relatedMatter"]];
    
    return bankModel;
}

@end
