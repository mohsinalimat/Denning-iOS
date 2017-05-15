//
//  DetailWithAutocomplete.h
//  Denning
//
//  Created by DenningIT on 09/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateDetailHandler)(CodeDescription* model);

@interface DetailWithAutocomplete : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *autocompleteTF;

@property (strong, nonatomic) UpdateDetailHandler updateHandler;
@property (strong, nonatomic) NSString* url;
@end
