//
//  TwoColumnWithDotCell.m
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TwoColumnWithDotCell.h"

@implementation TwoColumnWithDotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithFirstItem:(ItemModel*)firstItem  secondItem:(ItemModel*)secondItem
{
    self.firstCaption.text = firstItem.label.capitalizedString;
    self.firstValue.text = firstItem.value;
    self.secondCaption.text = secondItem.label.capitalizedString;
    self.secondValue.text = secondItem.value;
}

@end
