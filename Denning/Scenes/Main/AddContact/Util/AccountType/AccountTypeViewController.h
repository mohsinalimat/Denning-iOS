//
//  AccountTypeViewController.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateAccountTypeHandler)(AccountTypeModel* model);


@interface AccountTypeViewController : UITableViewController

@property (strong, nonatomic) UpdateAccountTypeHandler  updateHandler;

@end
