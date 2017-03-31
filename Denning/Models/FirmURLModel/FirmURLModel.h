//
//  FirmURLModel.h
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Realm/Realm.h>

@interface FirmURLModel : RLMObject

@property NSString      *firmServerURL;
@property NSString      *name;

@end
