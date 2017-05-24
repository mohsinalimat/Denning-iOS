//
//  MatterCodeModel.h
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatterCodeModel : NSObject
@property (strong, nonatomic) NSString* matterCode;
@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) NSString* department;
@property (strong, nonatomic) NSString* matterDescription;
@property (strong, nonatomic) NSString* formName;
@property (strong, nonatomic) NSString* groupName1;
@property (strong, nonatomic) NSString* groupName2;
@property (strong, nonatomic) NSString* groupName3;
@property (strong, nonatomic) NSString* groupName4;
@property (strong, nonatomic) NSString* groupName5;
@property (strong, nonatomic) NSString* isRental;
@property (strong, nonatomic) NSString* turnAround;

+ (MatterCodeModel*) getMatterCodeFromResponse:(NSDictionary*) response;

+ (NSArray*) getMatterCodeArrayFromResponse: (NSDictionary*) response;
@end
