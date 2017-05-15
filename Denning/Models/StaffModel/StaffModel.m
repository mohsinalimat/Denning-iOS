//
//  StaffModel.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "StaffModel.h"

@implementation StaffModel

+ (StaffModel*) getStaffFromResponse: (NSDictionary*) response
{
    StaffModel *staff = [StaffModel new];
    staff.IDNo = [response objectForKeyNotNull:@"IDNo"];
    staff.address = [AddressModel getAddressFromResponse:[response objectForKey:@"address"]];
    staff.citizenship = [response objectForKeyNotNull:@"citizenship"];
    staff.staffCode = [response objectForKeyNotNull:@"code"];
    staff.dateBirth = [response objectForKeyNotNull:@"dateBirth"];
    staff.emailAddress = [response objectForKeyNotNull:@"emailAddress"];
    staff.idTypeCode = [[response objectForKey:@"idType"] objectForKey:@"code"];
    staff.idTypeDescription = [[response objectForKey:@"idType"] objectForKey:@"description"];
    staff.name = [response objectForKeyNotNull:@"name"];
    staff.phoneFax = [response objectForKeyNotNull:@"phoneFax"];
    staff.phoneHome = [response objectForKeyNotNull:@"phoneHome"];
    staff.phoneOffice = [response objectForKey:@"phoneOffice"];
    staff.title = [response objectForKeyNotNull:@"title"];
    staff.webSite = [response objectForKeyNotNull:@"webSite"];
    staff.chatStatus = [response objectForKeyNotNull:@"chatStatus"];
    staff.userID = [response objectForKeyNotNull:@"userID"];
    
    return staff;
}

+ (NSArray*) getStaffArrayFromRepsonse: (NSDictionary*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[StaffModel getStaffFromResponse:obj]];
    }
    
    return result;
}

@end
