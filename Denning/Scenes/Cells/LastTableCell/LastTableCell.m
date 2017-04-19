//
//  LastTableCell.m
//  Denning
//
//  Created by DenningIT on 11/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LastTableCell.h"

@interface LastTableCell()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@end

@implementation LastTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCellWithFirstTitle: (NSString*) firstTitle withSecondTitle: (NSString*) secondTitle
{
    [self.firstBtn setTitle:firstTitle forState:UIControlStateNormal];
    [self.secondBtn setTitle:secondTitle forState:UIControlStateNormal];
}

- (IBAction)didTapFirstBtn:(id)sender {
    [self.delgate didTapFirstBtn:self];
}

- (IBAction)didTapSecond:(id)sender {
    [self.delgate didTapSecondBtn:self];
}

@end
