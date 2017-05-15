//
//  RelatedMatterModel.h
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeneralGroup;
@class PartyGroupModel;
@class SolicitorGroup;
@class PartyModel;
@class CourtModel;

@interface RelatedMatterModel : NSObject

@property (strong, nonatomic) NSString *systemNo;

@property (strong, nonatomic) NSString* contactCode;

@property (strong, nonatomic) NSString * clientName;

// Matter information
@property (strong, nonatomic) NSString* openDate;

@property (strong, nonatomic) NSString * ref;

@property (strong, nonatomic) NSString * matter;

// Court Information
@property (strong, nonatomic) CourtModel* court;    

// Party Group
@property (strong, nonatomic) NSArray *partyGroupArray;

// Solicitor
@property (strong, nonatomic) NSArray * solicitorGroupArray;

// Property
@property (strong, nonatomic) NSArray * propertyGroupArray;

// Bank
@property (strong, nonatomic) NSArray * bankGroupArray;

// ImportantRM
@property (strong, nonatomic) NSArray * RMGroupArray;

// DateRM
@property (strong, nonatomic) NSArray * dateGroupArray;

// Other information
@property (strong, nonatomic) NSArray * textGroupArray ;

@property (strong, nonatomic) NSArray * relatedMatter;

+ (RelatedMatterModel*) getRelatedMatterFromResponse: (NSDictionary*) response;

@end
