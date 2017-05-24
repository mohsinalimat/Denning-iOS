//
//  BankBranchCell.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface BankBranchCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *HQLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchName;
@property (weak, nonatomic) IBOutlet UILabel *CACLabel;

- (void) configureCellWithModel:(BankBranchModel*) model;

@end
