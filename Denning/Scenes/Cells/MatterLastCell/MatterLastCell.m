//
//  MatterLastCell.m
//  Denning
//
//  Created by DenningIT on 21/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MatterLastCell.h"

@implementation MatterLastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.paymentRecordBtn.titleLabel.minimumScaleFactor = 0.5f;
    self.paymentRecordBtn.titleLabel.numberOfLines = 0;
    self.paymentRecordBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tapFileFolder:(id)sender {
    [self.matterLastCellDelegate didTapFileFolder:self];
}

- (IBAction)tapAccounts:(id)sender {
    [self.matterLastCellDelegate didTapAccounts:self];
}

- (IBAction)tapFileNote:(id)sender {
    [self.matterLastCellDelegate  didTapFileFolder:self];
}

- (IBAction)tapPaymentRecord:(id)sender {
    [self.matterLastCellDelegate didTapPaymentRecord:self];
}

@end
