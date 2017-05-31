//
//  OneRowWithDot.m
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "OneRowWithDot.h"

@implementation OneRowWithDot

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithLeftValue:(NSString*)leftValue dotValue:(NSString*) dotValue
{
    self.leftLabel.text = leftValue;
    self.dotValue.text = dotValue;
}

@end
