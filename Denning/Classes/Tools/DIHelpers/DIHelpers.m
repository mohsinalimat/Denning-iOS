//
//  DIHelpers.m
//  Denning
//
//  Created by DenningIT on 25/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DIHelpers.h"

@implementation DIHelpers

+ (NSString*) getWANIP
{
    NSString* WANIP = @"121.196.213.102";
    
    return WANIP;
}

+ (NSString*) getLANIP
{
    NSString* LANIP = @"192.168.0.101";
    
    return LANIP;
}

+ (NSString*) getOSName
{
    NSString* osName = @"iOS 10.2";
    
    return osName;
}

+ (NSString*) getDevice
{
    NSString* device = @"iPhone 6";
    
    return device;
}

+ (NSString*) getDeviceName
{
    NSString* deviceName = @"Denining iPhone 6";
    
    return deviceName;
}

+ (NSAttributedString*) getLastRefreshingTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor flatBlackColor]
                                                                forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
}
@end
