//
//  ProfitLossDetailModel.h
//  Denning
//
//  Created by Ho Thong Mee on 16/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfitLossDetailModel : NSObject

@property (strong, nonatomic) NSString* expenses;
@property (strong, nonatomic) NSString* profitLoss;
@property (strong, nonatomic) NSString* revenue;
@property (strong, nonatomic) NSString* theYear;

+(ProfitLossDetailModel*) getProfitLossDetailFromResponse:(NSDictionary*) response;

@end
