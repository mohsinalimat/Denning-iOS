//
//  SimpleAutocomplete.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateAutocompletHandler)(NSString* model);

@interface SimpleAutocomplete : UIViewController


@property (strong, nonatomic) NSString* url;

@property (strong, nonatomic) UpdateAutocompletHandler updateHandler;
@end
