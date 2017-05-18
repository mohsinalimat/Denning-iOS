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

+ (NSString*) getMAC;

+ (NSAttributedString*) getLastRefreshingTime;

+ (NSString*) getDateInLongForm: (NSString*) date;

+ (NSString*) getDateInShortForm: (NSString*) date;

+ (NSString*) getTimeFromDate: (NSString*) date;

+ (NSString*) getOnlyDateFromDateTime: (NSString*)dateTime;

+ (BOOL) isWordFile:(NSString*) fileExt;

+ (BOOL) isImageFile: (NSString*) fileExt;

+ (BOOL) isExcelFile: (NSString*) fileExt;

+ (BOOL) isPDFFile: (NSString*) fileExt;

+ (BOOL) isTextFile: (NSString*) fileExt;

+ (BOOL) isWebFile: (NSString*) fileExt;

+ (void) drawWhiteBorderToButton: (UIButton*) button;

+ (void) drawWhiteBorderToTextField: (UITextField*) textField;

+ (NSArray*) removeFileNoAndSeparateFromMatterTitle: (NSString*) title;

+ (NSString*) today;

+ (NSString*) todayWithTime;

+ (NSString*) sevenDaysLater;

+ (NSString*) sevenDaysLaterFromDate: (NSString*) date;

+ (NSString*) sevenDaysBefore;

+ (NSString*) currentSunday;
@end
