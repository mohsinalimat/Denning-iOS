//
//  DetailWithAutocomplete.h
//  Denning
//
//  Created by DenningIT on 09/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLPAutoCompleteTextField;
typedef void (^UpdateAutocompletHandler)(CodeDescription* model);

@interface DetailWithAutocomplete : UIViewController

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *autocompleteTF;
@property (strong, nonatomic) NSString* url;

@property (strong, nonatomic) UpdateAutocompletHandler updateHandler;
@end
