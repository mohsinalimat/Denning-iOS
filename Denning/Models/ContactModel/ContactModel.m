//
//  ContactModel.m
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

+ (ContactModel*) getCotactFromResponse: (NSDictionary*) response
{
    ContactModel *contactModel = [ContactModel new];
    
    contactModel.contactCode = [response objectForKey:@"code"];
    contactModel.IDNo = [response objectForKey:@"IDNo"];
    contactModel.name = [response objectForKey:@"name"];
    contactModel.tel = [response objectForKey:@"phoneHome"];
    contactModel.mobile = [response objectForKey:@"phoneMobile"];
    contactModel.office = [response objectForKey:@"phoneOffice"];
    contactModel.email = [response objectForKey:@"emailAddress"];
    contactModel.address = [[response objectForKey:@"address"] objectForKey:@"fullAddress"];
    
    contactModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKey:@"relatedMatter"]];
    
    contactModel.matterDescription = @"";
    for(SearchResultModel* model in contactModel.relatedMatter) {
        contactModel.matterDescription = [NSString stringWithFormat:@"%@, %@", contactModel.matterDescription, model.key];
    }
    return contactModel;
}

+(NSString*) combineAddress: (NSDictionary*) address
{
    NSString *fullAddress;

    NSString *line1 = [address objectForKey:@"line1"];
    NSString *line2 = [address objectForKey:@"line2"];
    NSString *line3 = [address objectForKey:@"line3"];
    NSString *postCode = [address objectForKey:@"postcode"];
    NSString *city = [address objectForKey:@"city"];
    NSString *state = [address objectForKey:@"state"];
    NSString *country = [address objectForKey:@"country"];
    
    fullAddress = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@", line1, line2, line3, postCode, city, state, country];
    
    return fullAddress;
}

@end
