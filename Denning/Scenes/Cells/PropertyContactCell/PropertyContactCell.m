//
//  PropertyContactCell.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PropertyContactCell.h"

@implementation PropertyContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ID.copyingEnabled = YES;
    self.name.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithStaffModel:(StaffModel*) model
{
    self.name.text = model.name;
    self.ID.text = model.IDNo;
}

@end
