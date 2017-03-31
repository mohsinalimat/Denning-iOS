//
//  ContactModel.h
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject

@property (strong, nonatomic) NSString* contactCode;

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* IDNo;

@property (strong, nonatomic) NSString *tel;

@property (strong, nonatomic) NSString * mobile;

@property (strong, nonatomic) NSString * office;

@property (strong, nonatomic) NSString * email;

@property (strong, nonatomic) NSString * address;

@property (strong, nonatomic) NSArray * relatedMatter;

@property (strong, nonatomic) NSString* matterDescription;

+ (ContactModel*) getCotactFromResponse: (NSDictionary*) response;

@end
