//
//  PresetBillModel.h
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresetBillModel : NSObject

@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) NSString* billCode;
@property (strong, nonatomic) NSString* billDescription;
@property (strong, nonatomic) NSString* state;

+ (PresetBillModel*) getPresetBillFromResponse: (NSDictionary*) response;

+ (NSArray*) getPresetBillArrayFromResponse: (NSDictionary*) response;

@end
