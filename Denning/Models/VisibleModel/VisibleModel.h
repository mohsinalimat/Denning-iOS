//
//  VisibleModel.h
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisibleModel : NSObject

@property (strong, nonatomic) NSNumber* iStyle;
@property (strong, nonatomic) NSNumber* isVisible;
@property (strong, nonatomic) NSString* sessionAPI;
@property (strong, nonatomic) NSNumber* sessionID;
@property (strong, nonatomic) NSString* sessionName;

+ (VisibleModel*) getVisibleFromReponse:(NSDictionary*) response;

+ (NSArray*) getVisibleArrayFromResponse: (NSDictionary*) response;
@end
