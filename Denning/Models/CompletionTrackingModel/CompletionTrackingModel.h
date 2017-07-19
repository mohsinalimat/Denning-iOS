//
//  CompletionTrackingModel.h
//  Denning
//
//  Created by Ho Thong Mee on 17/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompletionTrackingModel : NSObject

@property (strong, nonatomic) NSString* completionDate;
@property (strong, nonatomic) NSString* dayToComplete;
@property (strong, nonatomic) NSString* extendedDate;
@property (strong, nonatomic) NSString* fileName;
@property (strong, nonatomic) NSString* fileNo;

+ (CompletionTrackingModel*) getCompletionTrackingFromResponse:(NSDictionary*) response;

+ (NSArray*) getCompletionTrackingArrayFromResponse:(NSArray*) response;

@end
