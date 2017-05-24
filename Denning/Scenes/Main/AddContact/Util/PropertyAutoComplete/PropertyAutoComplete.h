//
//  PropertyAutoComplete.h
//  Denning
//
//  Created by Ho Thong Mee on 22/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLPAutoCompleteTextField;
typedef void (^UpdatePropertyAutocompletHandler)(NSString* model);

@interface PropertyAutoComplete : UIViewController

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *autocompleteTF;
@property (strong, nonatomic) NSString* url;

@property (strong, nonatomic) UpdatePropertyAutocompletHandler updateHandler;
@end
