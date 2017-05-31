//
//  GraphModel.h
//  Denning
//
//  Created by Ho Thong Mee on 29/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphModel : NSObject

@property (strong, nonatomic) NSString* graphID;
@property (strong, nonatomic) NSString* graphName;
@property (strong, nonatomic) NSString* xLegend;
@property (strong, nonatomic) NSString* yLegend;
@property (strong, nonatomic) NSArray* xValue;
@property (strong, nonatomic) NSArray* yValue;

+ (GraphModel*) getGraphFromResponse: (NSDictionary*) response;

+ (NSArray*) getGraphArrayFromResponse: (NSDictionary*) response;

@end
