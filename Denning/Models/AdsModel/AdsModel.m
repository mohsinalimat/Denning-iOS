//
//  AdsModel.m
//  Denning
//
//  Created by Ho Thong Mee on 28/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AdsModel.h"

@implementation AdsModel

+ (AdsModel*) getAdsFromResponse:(NSDictionary*) response
{
    AdsModel *model = [AdsModel new];
    
    model.URL = [response valueForKeyNotNull:@"URL"];
    model.adsCode = [response valueForKeyNotNull:@"code"];
    model.imgData = [[response objectForKeyNotNull:@"img"] valueForKeyNotNull:@"base64"];
    
    return model;
}

+ (NSArray*) getAdsArrayFromResponse:(NSArray*) response
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (id obj in response) {
        [result addObject:[AdsModel getAdsFromResponse:obj]];
    }
    
    return result;

}
@end
