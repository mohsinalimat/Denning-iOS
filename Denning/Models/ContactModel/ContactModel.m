//
//  ContactModel.m
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

+ (ContactModel*) getContactFromResponse: (NSDictionary*) response
{
    ContactModel *contactModel = [ContactModel new];
    
    contactModel.contactCode = [[response objectForKeyNotNull:@"code"] stringValue];
    contactModel.IDNo = [response objectForKeyNotNull:@"IDNo"];
    contactModel.name = [response objectForKeyNotNull:@"name"];
    contactModel.homePhone = [response objectForKeyNotNull:@"phoneHome"];
    contactModel.mobilePhone = [response objectForKeyNotNull:@"phoneMobile"];
    contactModel.officePhone = [response objectForKeyNotNull:@"phoneOffice"];
    contactModel.email = [response objectForKeyNotNull:@"emailAddress"];
    contactModel.address = [AddressModel getAddressFromResponse:[response objectForKeyNotNull:@"address"]];
    
    contactModel.dateOfBirth = [response objectForKeyNotNull:@"dateBirth"];
    contactModel.citizenShip = [response objectForKeyNotNull:@"citizenship"];
    contactModel.fax = [response objectForKeyNotNull:@"phoneFax"];
    contactModel.tax = @"";
    contactModel.IRDBranch = [response objectForKeyNotNull:@"irdBranch"];
    contactModel.idType = [response objectForKeyNotNull:@"idType"];
    contactModel.contactTitle = [response objectForKeyNotNull:@"title"];
    contactModel.contactPerson = [response objectForKeyNotNull:@"contactPerson"];
    contactModel.InviteDennig = [response objectForKeyNotNull:@"InviteDennig"];
    contactModel.registeredOffice = [response objectForKeyNotNull:@"registeredOffice"];
    contactModel.occupation = [CodeDescription getCodeDescriptionFromResponse:[response objectForKeyNotNull:@"occupation"]];
    
    contactModel.relatedMatter = [SearchResultModel getSearchResultArrayFromResponse:[response objectForKeyNotNull:@"relatedMatter"]];
    
    contactModel.matterDescription = @"";
    for(SearchResultModel* model in contactModel.relatedMatter) {
        contactModel.matterDescription = [NSString stringWithFormat:@"%@, %@", contactModel.matterDescription, model.key];
    }
    return contactModel;
}

+ (NSString*) combineAddress: (NSDictionary*) address
{
    NSString *fullAddress;

    NSString *line1 = [address objectForKeyNotNull:@"line1"];
    NSString *line2 = [address objectForKeyNotNull:@"line2"];
    NSString *line3 = [address objectForKeyNotNull:@"line3"];
    NSString *postCode = [address objectForKeyNotNull:@"postcode"];
    NSString *city = [address objectForKeyNotNull:@"city"];
    NSString *state = [address objectForKeyNotNull:@"state"];
    NSString *country = [address objectForKeyNotNull:@"country"];
    
    fullAddress = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@", line1, line2, line3, postCode, city, state, country];
    
    return fullAddress;
}

@end
