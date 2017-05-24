//
//  ThreeFieldsCell.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ThreeFieldsCell.h"
@interface ThreeFieldsCell()
@property (weak, nonatomic) IBOutlet UILabel *firstValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdValuelabel;

@end

@implementation ThreeFieldsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithValue1: (NSString*) value1 value2:(NSString*) value2 value3: (NSString*) value3
{
    self.firstValueLabel.text = value1;
    self.secondValueLabel.text = value2.uppercaseString;
    self.thirdValuelabel.text = value3.uppercaseString;
}

@end
