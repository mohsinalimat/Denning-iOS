//
//  ClientModel.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ClientModel.h"

@implementation ClientModel

+ (ClientModel*) getClientFromResponse: (NSDictionary*) response
{
    ClientModel* client = [ClientModel new];
    
    client.IDNo = [response valueForKeyNotNull:@"IDNo"];
    client.address = [AddressModel getAddressFromResponse:[response objectForKeyNotNull:@"address"]];
    client.citizenship = [response objectForKeyNotNull:@"citizenship"];
    client.clientCode = [response valueForKeyNotNull:@"code"];
    client.dateBirth = [response valueForKeyNotNull:@"dateBirth"];
    client.emailAddress = [response valueForKeyNotNull:@"emailAddress"];
    client.idTypeCode = [[response objectForKeyNotNull:@"idType"] valueForKeyNotNull:@"code"];
    client.idTypeDescription = [[response objectForKeyNotNull:@"idType"] valueForKeyNotNull:@"description"];
    client.name = [response valueForKeyNotNull:@"name"];
    client.phoneFax = [response valueForKeyNotNull:@"phoneFax"];
    client.phoneHome = [response valueForKeyNotNull:@"phoneHome"];
    client.phoneMobile = [response valueForKeyNotNull:@"phoneMobile"];
    client.phoneOffice = [response valueForKeyNotNull:@"phoneOffice"];
    client.title = [response valueForKeyNotNull:@"title"];
    client.webSite = [response valueForKeyNotNull:@"webSite"];
    client.KPLama = [response valueForKeyNotNull:@"KPLama"];
    
    return client;
}

+ (NSArray*) getClientArrayFromReponse:(NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[ClientModel getClientFromResponse:obj]];
    }
    
    return result;
}

@end
