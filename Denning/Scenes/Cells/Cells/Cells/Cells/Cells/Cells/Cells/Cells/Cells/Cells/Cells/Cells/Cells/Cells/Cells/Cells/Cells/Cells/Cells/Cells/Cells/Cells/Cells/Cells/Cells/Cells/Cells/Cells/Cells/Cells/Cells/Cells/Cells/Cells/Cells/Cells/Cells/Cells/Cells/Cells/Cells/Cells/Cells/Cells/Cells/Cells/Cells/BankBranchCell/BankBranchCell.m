//
//  BankBranchCell.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BankBranchCell.h"

@implementation BankBranchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(BankBranchModel*) model
{
    _HQLabel.text = model.HQ.name;
    _branchName.text = model.name;
    _CACLabel.text = model.CAC.name;
}

@end
