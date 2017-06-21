//
//  SolicitorCell.m
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SolicitorCell.h"

@implementation SolicitorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firmName.copyingEnabled = YES;
    self.branch.copyingEnabled = YES;
    self.phoneAndFax.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(SoliciorModel*) model
{
    _firmName.text = model.name;
    _branch.text = model.address.city;
    _phoneAndFax.text = [NSString stringWithFormat:@"%@ / %@", model.phoneHome, model.phoneFax];
}

@end
