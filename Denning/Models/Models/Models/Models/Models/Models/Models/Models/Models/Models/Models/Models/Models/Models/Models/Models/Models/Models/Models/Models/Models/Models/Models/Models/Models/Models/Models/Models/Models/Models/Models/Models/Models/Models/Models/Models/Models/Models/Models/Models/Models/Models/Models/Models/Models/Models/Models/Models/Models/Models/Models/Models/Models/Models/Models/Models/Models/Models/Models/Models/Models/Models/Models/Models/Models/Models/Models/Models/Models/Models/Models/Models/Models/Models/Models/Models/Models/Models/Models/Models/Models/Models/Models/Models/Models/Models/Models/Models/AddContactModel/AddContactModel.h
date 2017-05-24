//
//  AddContactModel.h
//  Denning
//
//  Created by DenningIT on 04/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddContactModel : NSObject

@property (strong, nonatomic) NSString *IDNo;
@property (strong, nonatomic) NSString *IDType;
@property (strong, nonatomic) AddressModel* address;
@property (strong, nonatomic) NSString *citizenShip;
@property (strong, nonatomic) NSString *codeValue;
@property (strong, nonatomic) NSString *dateBirth;
@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phoneFax;
@property (strong, nonatomic) NSString *phoneHome;
@property (strong, nonatomic) NSString *phoneMobile;
@property (strong, nonatomic) NSString *phoneOffice;
@property (strong, nonatomic) NSString *titleValue;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSNumber *InviteToDenning;
@property (strong, nonatomic) NSString *KPLama;
// ChatStatus
@property (strong, nonatomic) NSString *contactPerson;
@property (strong, nonatomic) NSString *IRDBranch;
@property (strong, nonatomic) NSString *occupation;
@property (strong, nonatomic) NSString *registeredOffice;
@property (strong, nonatomic) NSArray *relatedMatter;
@property (strong, nonatomic) NSString *taxFileNo;

+ (AddContactModel*) getAddContactFromResponse: (NSDictionary*) response;

@end
