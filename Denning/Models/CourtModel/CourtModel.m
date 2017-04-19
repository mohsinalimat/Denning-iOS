//
//  CourtModel.m
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CourtModel.h"

@implementation CourtModel

+ (CourtModel*) getCourtFromResponse: (NSDictionary*) response
{
    CourtModel* courtModel = [CourtModel new];
    if ([[response objectForKey:@"courtInfo"]  isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        courtModel.court = [[response objectForKey:@"courtInfo"] objectForKey:@"Court"];
        if ([courtModel.court isKindOfClass:[NSNull class]]) {
            courtModel.court = @"";
        }
        courtModel.place = [[response objectForKey:@"courtInfo"] objectForKey:@"Place"];
        if ([courtModel.place isKindOfClass:[NSNull class]]) {
            courtModel.place = @"";
        }
        
        courtModel.caseNumber = [[response objectForKey:@"courtInfo"] objectForKey:@"CaseNo"];
        if ([courtModel.caseNumber isKindOfClass:[NSNull class]]) {
            courtModel.caseNumber = @"";
        }
        courtModel.judge = [[response objectForKey:@"courtInfo"] objectForKey:@"Judge"];
        if ([courtModel.judge isKindOfClass:[NSNull class]]) {
            courtModel.judge = @"";
        }
        courtModel.SAR = [[response objectForKey:@"courtInfo"] objectForKey:@"SAR"];
        if ([courtModel.SAR isKindOfClass:[NSNull class]]) {
            courtModel.SAR = @"";
        }
    }
    return courtModel;
}
@end
