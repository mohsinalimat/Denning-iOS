//
//  CommonTextCell.m
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CommonTextCell.h"
@interface CommonTextCell()
@property (weak, nonatomic) IBOutlet UILabel *fixedLabel;

@end

@implementation CommonTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithValue: (NSString*) value
{
    self.valueLabel.text = value.uppercaseString;
}

@end
