//
//  AccountTypeModel.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountTypeModel : NSObject

@property(strong, nonatomic) NSString *ID;
@property(strong, nonatomic) NSString *accountTypeCode;
@property (strong, nonatomic) NSString *descriptionValue;
@property(strong, nonatomic) NSString *shortDescription;

+ (AccountTypeModel*) getAccountTypeFromResponse: (NSDictionary*) response;

+ (NSArray*) getAccountTypeArrayFromResponse: (NSDictionary*) response;

@end
