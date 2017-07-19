//
//  TrialBalanceCell.h
//  Denning
//
//  Created by Ho Thong Mee on 15/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface TrialBalanceCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *accountType;
@property (weak, nonatomic) IBOutlet UILabel *debit;
@property (weak, nonatomic) IBOutlet UILabel *credit;
@property (weak, nonatomic) IBOutlet UIImageView *balance;

- (void) configureCellWithModel:(TrialBalanceModel*) model;

@end
