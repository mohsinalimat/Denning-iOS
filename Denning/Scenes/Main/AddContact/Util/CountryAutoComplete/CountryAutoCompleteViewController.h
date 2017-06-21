//
//  CountryAutoCompleteViewController.h
//  Denning
//
//  Created by Ho Thong Mee on 15/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateCountryAutocompletHandler)(NSString* model);

@interface CountryAutoCompleteViewController : UIViewController


@property (strong, nonatomic) UpdateCountryAutocompletHandler updateHandler;

@end
