//
//  StaffOnlineCell.m
//  Denning
//
//  Created by Ho Thong Mee on 17/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "StaffOnlineCell.h"

@implementation StaffOnlineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(StaffOnlineModel*) model
{
    _staff.text = model.name;
    _device.text = model.device;
    if ([model.status isEqualToString:@"online"]) {
        _statusImage.image = [UIImage imageNamed:@"icon_status"];
    } else {
        _statusImage.image = [UIImage imageNamed:@"icon_status_offline"];
    }
}
@end
