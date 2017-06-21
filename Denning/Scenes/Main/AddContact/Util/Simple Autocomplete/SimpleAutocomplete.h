//
//  SimpleAutocomplete.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateSimpleAutocompletHandler)(NSString* model);

@interface SimpleAutocomplete : UIViewController


@property (strong, nonatomic) NSString* url;

@property (strong, nonatomic) UpdateSimpleAutocompletHandler updateHandler;
@end
