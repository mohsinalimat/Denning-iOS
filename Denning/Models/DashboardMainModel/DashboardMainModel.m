//
//  DashboardMainModel.m
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DashboardMainModel.h"

@implementation DashboardMainModel

+ (DashboardMainModel*) getDashboardMainFromResponse: (NSDictionary*) response
{
    DashboardMainModel* model = [DashboardMainModel new];
    
    model.s1 = [S1Model getS1FromResponse:[response objectForKeyNotNull:@"s1"]];
    model.s2 = [S2Model getS2FromResponse:[response objectForKeyNotNull:@"s2"]];
    model.s3 = [S3Model getS3FromResponse:[response objectForKeyNotNull:@"s3"]];
    model.s4 = [S1Model getS1FromResponse:[response objectForKeyNotNull:@"s4"]];
    model.today = [response valueForKeyNotNull:@"todayDate"];
    return model;
}
@end
