//
//  DenningLabelCell.m
//  Denning
//
//  Created by DenningIT on 08/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DenningLabelCell.h"

@interface DenningLabelCell()
@property (weak, nonatomic) IBOutlet UILabel *firmLabel;


@end

@implementation DenningLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithText: (NSString*)text
{
    self.firmLabel.text = text;
}
@end
