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

+ (NSString*) getMAC
{
    NSString* MAC = @"44:78:3e:94:a0:e5";
    
    return MAC;
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

+ (NSString*) getDateInShortForm: (NSString*) date
{
    NSString* formattedDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]/3600];
    [formatter setTimeZone:timeZone];
    [newFormatter setTimeZone:timeZone];
    [newFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSDate *creationDate = [formatter dateFromString:date];
    
    formattedDate = [newFormatter stringFromDate:creationDate];
    return formattedDate;
}

+ (NSString*) getDateInLongForm: (NSString*) date
{
    NSString* formattedDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]/3600];
    [formatter setTimeZone:timeZone];
    [newFormatter setTimeZone:timeZone];
    [newFormatter setDateStyle:NSDateFormatterLongStyle];
    
    NSDate *creationDate = [formatter dateFromString:date];
    
    formattedDate = [newFormatter stringFromDate:creationDate];
    return formattedDate;
}

+ (NSString*) getTimeFromDate: (NSString*) date
{
    NSString* time;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]/3600];
    [formatter setTimeZone:timeZone];
    [newFormatter setTimeZone:timeZone];
    [newFormatter setDateFormat:@"HH:mm a"];
    
    NSDate *creationDate = [formatter dateFromString:date];
    
    time = [newFormatter stringFromDate:creationDate];
    
    return time;
}
@end
