//
//  EventModel.h
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (strong, nonatomic) NSString * subject;

@property (strong, nonatomic) NSString * FileNo;

@property (strong, nonatomic) NSString * caseNo;

@property (strong, nonatomic) NSString * URL;

@property (strong, nonatomic) NSString * eventCode;

@property (strong, nonatomic) NSString * description;

@property (strong, nonatomic) NSString * eventStart;

@property (strong, nonatomic) NSString * eventEnd;

@property (strong, nonatomic) NSString * imageURL;

@property (strong, nonatomic) NSString * imageData;

@property (strong, nonatomic) NSString * location;

@property (strong, nonatomic) NSString * reminder1;

@property (strong, nonatomic) NSString * reminder2;

@property (strong, nonatomic) NSString * counsel;

+ (EventModel*) getEventFromResponse: (NSDictionary*) response;

+ (NSArray*) getEventsArrayFromResponse: (NSDictionary*) response;


@end
