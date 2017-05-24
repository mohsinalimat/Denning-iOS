//
//  BankModel.h
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BankGroupModel : NSObject

@property (strong, nonatomic) NSString* bankCode;

@property (strong, nonatomic) NSString * bankGroupName;

@property (strong, nonatomic) NSString * bankName;

+(BankGroupModel*) getBankGroupFromResponse: (NSDictionary*) response;

+(NSArray*) getBankGroupArrayFromResponse: (NSDictionary*) response;

@end
