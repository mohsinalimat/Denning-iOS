//
//  MatterLitigationModel.h
//  Denning
//
//  Created by Ho Thong Mee on 22/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MatterLitigationModel : NSObject
@property (strong, nonatomic) CourtModel *courtInfo;
@property (strong, nonatomic) NSString* dateOpen;
@property (strong, nonatomic) NSString* manualNo;
@property (strong, nonatomic) MatterCodeModel* matter;
@property (strong, nonatomic) PartyGroupModel* partyGroup;
@property (strong, nonatomic) ClientModel* primaryClient;
@property (strong, nonatomic) NSString* referenceNo;
@property (strong, nonatomic) NSString* systemNo;

+ (MatterLitigationModel*) getMatterLitigationFromResponse: (NSDictionary*) response;

+ (NSArray*) getMatterLitigationArrayFromResponse: (NSDictionary*) response;
@end
