//
//  DIHelpers.h
//  Denning
//
//  Created by DenningIT on 25/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIHelpers : NSObject

+ (NSString*) getWANIP;

+ (NSString*) getLANIP;

+ (NSString*) getOSName;

+ (NSString*) getDevice;

+ (NSString*) getDeviceName;

+ (NSAttributedString*) getLastRefreshingTime;

@end
