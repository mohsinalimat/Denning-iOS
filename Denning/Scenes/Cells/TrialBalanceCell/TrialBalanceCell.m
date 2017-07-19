//
//  TrialBalanceCell.m
//  Denning
//
//  Created by Ho Thong Mee on 15/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TrialBalanceCell.h"

@implementation TrialBalanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(TrialBalanceModel*) model
{
    self.accountType.text = model.accountName;
    self.credit.text = [DIHelpers addThousandsSeparatorWithDecimal:model.credit];
    self.debit.text = [DIHelpers addThousandsSeparatorWithDecimal:model.debit];
    if ([model.isBalance isEqualToString:@"No"]) {
        self.balance.image = [UIImage imageNamed:@"icon_close"];
    } else {
        self.balance.image = [UIImage imageNamed:@"icon_check"];
    }
}

@end
