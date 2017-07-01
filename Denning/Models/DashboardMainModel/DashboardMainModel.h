//
//  DashboardMainModel.h
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class S1Model;
@class S2Model;
@class S3Model;

@interface DashboardMainModel : NSObject

@property (strong, nonatomic) S1Model* s1;
@property (strong, nonatomic) S2Model* s2;
@property (strong, nonatomic) S3Model* s3;
@property (strong, nonatomic) S1Model* s4;
@property (strong, nonatomic) NSString* today;

+ (DashboardMainModel*) getDashboardMainFromResponse: (NSDictionary*) response;
@end
