//
//  GovOfficeModel.m
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "GovOfficeModel.h"

@implementation GovOfficeModel

+ (GovOfficeModel*) getGovOfficeFromResponse: (NSDictionary*) response
{
    GovOfficeModel* govOfficeModel = [GovOfficeModel new];
    
    govOfficeModel.name = [response objectForKey:@"name"];
    if ([[response objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.name = @"";
    }
    govOfficeModel.IDNo = [response objectForKey:@"IDNo"];
    if ([[response objectForKey:@"IDNo"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.IDNo = @"";
    }
    
    govOfficeModel.tel = [response objectForKey:@"phoneHome"];
    if ([[response objectForKey:@"phoneHome"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.tel = @"";
    }
    govOfficeModel.fax = [response objectForKey:@"phoneFax"];
    if ([[response objectForKey:@"phoneFax"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.fax = @"";
    }
    govOfficeModel.mobile = [response objectForKey:@"phoneMobile"];
    if ([[response objectForKey:@"phoneMobile"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.mobile = @"";
    }
    govOfficeModel.office = [response objectForKey:@"phoneOffice"];
    if ([[response objectForKey:@"phoneOffice"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.office = @"";
    }
    
    govOfficeModel.email = [response objectForKey:@"emailAddress"];
    if ([[response objectForKey:@"emailAddress"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.email = @"";
    }
    govOfficeModel.address = [[response objectForKey:@"address"] objectForKey:@"fullAddress"];
    if ([[response objectForKey:@"address"] isKindOfClass:[NSNull class]]) {
        govOfficeModel.address = @"";
    }
    govOfficeModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKey:@"relatedMatter"]];
    return govOfficeModel;
}
@end
