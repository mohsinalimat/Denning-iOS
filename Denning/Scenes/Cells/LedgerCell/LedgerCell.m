//
//  LedgerCell.m
//  Denning
//
//  Created by DenningIT on 31/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LedgerCell.h"

@interface LedgerCell()
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *availableBalance;

@end

@implementation LedgerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithLedger: (LedgerModel*) ledgerModel
{
    self.accountName.text = ledgerModel.accountName;
    if (ledgerModel.availableBalance.length == 0) {
        self.availableBalance.text = @"0.00";
    } else {
        self.availableBalance.text = ledgerModel.availableBalance;
    }
    
}

@end
