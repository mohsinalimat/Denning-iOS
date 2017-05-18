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
  //  NSString* WANIP = [[SystemServices sharedServices] externalIPAddress];
    
    NSString* WANIP = @"10.17.9.2";
    
    return WANIP;
}

+ (NSString*) getLANIP
{
//    NSString* LANIP = [[SystemServices sharedServices] currentIPAddress];
    NSString* LANIP = @"192.168.2.29";
    
    return LANIP;
}

+ (NSString*) getOSName
{
    NSString* osName = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    
    return osName;
}

+ (NSString*) getDevice
{
    NSString* device = [UIDevice currentDevice].model;
    
    return device;
}

+ (NSString*) getDeviceName
{
   // NSString* deviceName = [[SystemServices sharedServices] deviceName];
    NSString* deviceName = [UIDevice currentDevice].model;
    return deviceName;
}

+ (NSString*) getMAC
{
//    NSString* MAC = [[SystemServices sharedServices] cellMACAddress];
    
    NSString* MAC = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
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
    [newFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *creationDate = [formatter dateFromString:date];
    
    formattedDate = [newFormatter stringFromDate:creationDate];
    return formattedDate;
}

+ (NSString*) getDateInLongForm: (NSString*) date
{
    NSString* formattedDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]/3600];
    [formatter setTimeZone:timeZone];
    [newFormatter setTimeZone:timeZone];
    [newFormatter setDateFormat:@"MM/dd/yyyy"];
    
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

+ (NSString*) getOnlyDateFromDateTime: (NSString*)dateTime
{
    NSString* date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone localTimeZone] secondsFromGMT]/3600];
    [formatter setTimeZone:timeZone];
    [newFormatter setTimeZone:timeZone];
    [newFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *creationDate = [formatter dateFromString:dateTime];
    
    date = [newFormatter stringFromDate:creationDate];
    return date;
}

+ (BOOL) isWordFile:(NSString*) fileExt
{
    NSArray* wordArray = @[@".docx", @".doc", @".rtf"];
    if([wordArray containsObject:[fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isImageFile: (NSString*) fileExt {
    NSArray* imageArray = @[@".png", @".tif", @".bmp", @".jpg", @".jpeg", @".gif"];
    if ([imageArray containsObject:[fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isExcelFile: (NSString*) fileExt {
    NSArray* excelArray = @[@".xls", @"xlsx", @"csv"];
    
    if ([excelArray containsObject: [fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isPDFFile: (NSString*) fileExt {
    NSArray* pdfArray = @[@".pdf"];
    
    if ([pdfArray containsObject: [fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isTextFile: (NSString*) fileExt {
    NSArray* textArray = @[@".txt"];
    
    if ([textArray containsObject: [fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isWebFile: (NSString*) fileExt
{
    NSArray* webArray = @[@".url"];
    
    if ([webArray containsObject: [fileExt lowercaseString]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void) drawWhiteBorderToButton: (UIButton*) button {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, button.frame.size.height - borderWidth, button.frame.size.width, button.frame.size.height);
    border.borderWidth = borderWidth;
    [button.layer addSublayer:border];
    button.layer.masksToBounds = YES;
}

+ (void) drawWhiteBorderToTextField: (UITextField*) textField {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)] && textField.placeholder.length != 0) {
        UIColor *color = [UIColor whiteColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
}

+ (NSArray*) removeFileNoAndSeparateFromMatterTitle: (NSString*) title
{
    NSString* removedTitle;
    
    NSRange range = NSMakeRange(9, title.length-9);
    removedTitle = [title substringWithRange:range];
    
    NSMutableArray *items = [[removedTitle componentsSeparatedByString:@"("] mutableCopy];
    
    if (items.count == 2) {
        items[1] = [@"(" stringByAppendingString:items[1]];
    }
   
    return items;
}

+ (NSString*) today {
    NSString* date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

+ (NSString*) todayWithTime {
    NSString* date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ii"];
    
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

+ (NSString*) sevenDaysLater {
    return [self sevenDaysLaterFromDate:[DIHelpers today]];
}

+ (NSString*) sevenDaysLaterFromDate: (NSString*) date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:[GLDateUtils dateByAddingDays:6 toDate:[formatter dateFromString:date]]];
}

+ (NSString*) sevenDaysBefore {
    NSString* date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    date = [formatter stringFromDate:[GLDateUtils dateByAddingDays:-6 toDate:[NSDate date]]];
    return date;
}

+ (NSString*) currentSunday {
    NSDate *currentDate  = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSDateComponents *components = [gregorianCalendar components:(NSCalendarUnitYear| NSCalendarUnitMonth
                                                                  | NSCalendarUnitDay| NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth)  fromDate:currentDate];
    
    NSLog(@"Current week day number %ld",(long)[components weekday]);
    NSLog(@"Current week number %ld",(long)[components weekOfMonth]);
    NSLog(@"Current month's day %ld",(long)[components day]);
    NSLog(@"Current month %ld",(long)[components month]);
    NSLog(@"Current year %ld",(long)[components year]);
    
    NSDateComponents *dt=[[NSDateComponents alloc]init];
    
    [dt setWeekOfMonth:[components weekOfMonth]];
    [dt setWeekday:1];
    [dt setMonth:[components month]];
    [dt setYear:[components year]];
    
    NSDate *Sunday=[gregorianCalendar dateFromComponents:dt];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:Sunday];
}

@end
