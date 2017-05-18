//
//  BranchListViewController.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateBankBranchHandler)(BankBranchModel* model);

@interface BranchListViewController : UITableViewController

@property (strong, nonatomic) UpdateBankBranchHandler updateHandler;

@end
