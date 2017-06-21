//
//  TwoColumnCell.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TwoColumnCell.h"

@implementation TwoColumnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.codeValue.copyingEnabled = YES;
    self.descValue.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithCodeLabel:(NSString*)codeLabel codeValue:(NSString*)codeValue descLabel:(NSString*)descLabel descValue:(NSString*) descValue
{
    self.codeLabel.text = codeLabel;
    self.codeValue.text = codeValue;
    self.descLabel.text = descLabel;
    self.descValue.text = descValue;
}

@end
