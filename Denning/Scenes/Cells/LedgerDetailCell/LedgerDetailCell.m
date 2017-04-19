//
//  LedgerDetailCell.m
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LedgerDetailCell.h"
@interface LedgerDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *documentNo;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end

@implementation LedgerDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) configureCellWithLedgerDetail: (LedgerDetailModel*) model
{
    self.descriptionLabel.text = model.ledgerDescription;
    self.documentNo.text = model.documentNo;
    self.amount.text = model.amount;
}

@end
