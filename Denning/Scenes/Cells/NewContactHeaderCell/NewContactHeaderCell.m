//
//  NewContactHeaderCell.m
//  Denning
//
//  Created by DenningIT on 25/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewContactHeaderCell.h"

@implementation NewContactHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithInfo:(NSString*) name number:(NSString*) number image:(UIImage*) image {
    self.nameLabel.text = name;
    self.fileNumberLable.text = number;
 //   self.mainImageView.image = image;
}
- (IBAction)didTapMessage:(id)sender {
    [self.delegate didTapMessage:self];
}

@end