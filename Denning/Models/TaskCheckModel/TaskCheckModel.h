//
//  TaskCheckModel.h
//  Denning
//
//  Created by Ho Thong Mee on 02/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskCheckModel : NSObject
@property (strong, nonatomic) NSString* clerkName;
@property (strong, nonatomic) NSString* startDate;
@property (strong, nonatomic) NSString* endDate;
@property (strong, nonatomic) NSString* fileName;
@property (strong, nonatomic) NSString* fileNo;
@property (strong, nonatomic) NSString* taskName;

+ (TaskCheckModel*) getTaskCheckFromResponse: (NSDictionary*) response;

+ (NSArray*) getTaskCheckArrayFromResponse: (NSDictionary*) response;

@end
