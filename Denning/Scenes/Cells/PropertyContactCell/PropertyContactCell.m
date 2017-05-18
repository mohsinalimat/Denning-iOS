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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithStaffModel:(StaffModel*) model
{
    self.fullName.text = model.name;
    self.NRIC.text = model.IDNo;
    self.mobileAndPhone.text = [NSString stringWithFormat:@"%@ / %@", model.phoneMobile, model.phoneHome];
}

@end
