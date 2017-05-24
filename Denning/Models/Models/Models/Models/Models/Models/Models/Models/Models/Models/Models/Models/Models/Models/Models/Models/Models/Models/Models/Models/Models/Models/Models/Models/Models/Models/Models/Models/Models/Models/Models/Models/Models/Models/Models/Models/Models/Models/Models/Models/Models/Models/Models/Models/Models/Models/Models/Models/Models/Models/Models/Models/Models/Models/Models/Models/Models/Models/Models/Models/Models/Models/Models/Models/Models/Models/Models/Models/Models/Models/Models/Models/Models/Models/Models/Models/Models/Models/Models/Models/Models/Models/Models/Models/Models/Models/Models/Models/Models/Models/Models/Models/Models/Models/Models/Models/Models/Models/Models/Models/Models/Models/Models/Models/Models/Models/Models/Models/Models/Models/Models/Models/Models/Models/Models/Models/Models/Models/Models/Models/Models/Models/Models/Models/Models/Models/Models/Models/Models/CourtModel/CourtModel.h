//
//  CourtModel.h
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourtModel : NSObject


// Court case information
@property (strong, nonatomic) NSString* caseName;

@property (strong, nonatomic) NSString* partyType;

@property (strong, nonatomic) NSString * court;

@property (strong, nonatomic) NSString * place;

@property (strong, nonatomic) NSString * caseNumber;

@property (strong, nonatomic) NSString * judge;

@property (strong, nonatomic) NSString * SAR;

+ (CourtModel*) getCourtFromResponse: (NSDictionary*) response;
@end
