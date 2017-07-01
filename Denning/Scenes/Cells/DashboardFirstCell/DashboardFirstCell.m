//
//  DashboardFirstCell.m
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DashboardFirstCell.h"

@implementation DashboardFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) configureCellWithModel:(FirstItemModel*) model
{
    self.centerLabel.text = model.mainValue;
    self.centerLabel.textColor = [UIColor colorWithHexString:model.mainValueColor];
    self.bottomBadge.text = model.footerDescription;
    self.bottomBadge.textColor = [UIColor colorWithHexString:model.footerDescriptionColor];
    self.bottomLabel.text = model.footerValue;
    self.bottomLabel.textColor = [UIColor colorWithHexString:model.footerValueColor];
    self.backgroundColor = [UIColor colorWithHexString:model.background];
    self.topLabel.text = model.title;
    self.topLabel.textColor = [UIColor colorWithHexString:model.titleColor];
}
@end
