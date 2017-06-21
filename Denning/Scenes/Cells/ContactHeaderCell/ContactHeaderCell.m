//
//  ContactHeaderCell.m
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ContactHeaderCell.h"

@interface ContactHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ContactHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithContact:(NSString*) contactID
{
    self.titleLabel.text = contactID.uppercaseString;
}

@end
