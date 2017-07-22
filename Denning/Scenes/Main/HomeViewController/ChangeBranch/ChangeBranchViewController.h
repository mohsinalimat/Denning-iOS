//
//  ChangeBranchViewController.h
//  Denning
//
//  Created by DenningIT on 04/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateBranchHandler)(FirmURLModel *model);

@interface ChangeBranchViewController : UITableViewController

@property (strong, nonatomic) NSArray *branchArray;
@property (strong, nonatomic) UpdateBranchHandler updateHandler;
@end
