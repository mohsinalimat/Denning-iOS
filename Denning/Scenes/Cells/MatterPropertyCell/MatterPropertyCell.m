//
//  MatterPropertyCell.m
//  Denning
//
//  Created by DenningIT on 22/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MatterPropertyCell.h"

@implementation MatterPropertyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithFullTitle: (NSString*) fullTitle withAddress:(NSString*) address inNumber:(NSInteger) number
{
    self.propertyNumber.text = [NSString stringWithFormat:@"%ld", number + 1];
    self.fullTitle.text = [DIHelpers capitalizedString:fullTitle];
    self.address.text = [DIHelpers capitalizedString:address];
}

@end
