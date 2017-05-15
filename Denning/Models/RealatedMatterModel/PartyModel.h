//
//  PartyModel.h
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartyModel : NSObject
@property (strong, nonatomic) NSString* partyCode;
@property (strong, nonatomic) NSString* partyName;

+ (PartyModel*) getPartyFromResponse:(NSDictionary*) response;

+ (NSArray*) getPartyArrayFromResponse:(NSDictionary*) response;

@end
