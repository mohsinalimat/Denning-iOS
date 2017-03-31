//
//  BranchHeaderCell.m
//  Denning
//
//  Created by DenningIT on 30/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BranchHeaderCell.h"
@interface BranchHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BranchHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithTitle:(NSString*) title
{
    self.titleLabel.text = title;
}

- (IBAction)backBtnTapped:(id)sender {
    [self.delegate didBackBtnTapped:self];
}


@end
