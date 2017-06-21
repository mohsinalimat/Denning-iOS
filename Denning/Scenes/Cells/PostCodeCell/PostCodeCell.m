//
//  PostCodeCell.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PostCodeCell.h"

@implementation PostCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.postCode.copyingEnabled = YES;
    self.city.copyingEnabled = YES;
    self.country.copyingEnabled = YES;
    self.state.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithPostModel:(CityModel*) cityModel
{
    self.city.text = cityModel.city;
    self.postCode.text = cityModel.postcode;
    self.country.text = cityModel.country;
    self.state.text = cityModel.state;
}

@end
