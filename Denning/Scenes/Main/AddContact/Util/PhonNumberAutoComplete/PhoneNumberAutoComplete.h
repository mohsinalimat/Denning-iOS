//
//  PhonNumberAutoComplete.h
//  Denning
//
//  Created by Ho Thong Mee on 15/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateCountryCodeAutocompletHandler)(NSString* countrycode, NSString* countryCallingCode);

@interface PhoneNumberAutoComplete: UIViewController

@property (strong, nonatomic) UpdateCountryCodeAutocompletHandler updateHandler;

@end
