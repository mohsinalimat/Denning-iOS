//
//  EventModel.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel

@synthesize URL;
@synthesize FileNo;
@synthesize eventCode;
@synthesize description;
@synthesize eventStart;
@synthesize eventEnd;
@synthesize imageURL;
@synthesize imageData;
@synthesize location;
@synthesize reminder1;
@synthesize reminder2;

+ (EventModel*) getEventFromResponse: (NSDictionary*) response
{
    EventModel* eventModel = [EventModel new];
    
    eventModel.FileNo = [response objectForKey:@"FileNo"];
    eventModel.URL = [response objectForKey:@"URL"];
    eventModel.eventCode = [response objectForKey:@"code"];
    eventModel.description = [response objectForKey:@"description"];
    eventModel.eventStart = [response objectForKey:@"eventStart"];
    eventModel.eventEnd = [response objectForKey:@"eventEnd"];
    eventModel.imageURL = [[response objectForKey:@"img"] objectForKey:@"FileName"];
    eventModel.imageData = [[response objectForKey:@"img"] objectForKey:@"base64"];
    eventModel.location = [response objectForKey:@"location"];
    eventModel.reminder1 = [response objectForKey:@"reminder1"];
    eventModel.reminder2 = [response objectForKey:@"reminder2"];
    
    return eventModel;
}

+ (NSArray*) getEventsArrayFromResponse: (NSDictionary*) response
{
    NSMutableArray* eventsArray = [NSMutableArray new];
    
    if ([response isKindOfClass:[NSArray class]]) {
        for (NSDictionary* dictionary in response) {
            [eventsArray addObject:[EventModel getEventFromResponse:dictionary]];
        }
    }

    return eventsArray;
}

@end
