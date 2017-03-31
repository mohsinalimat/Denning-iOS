//
//  SearchMatterCell.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SearchMatterCell.h"
@interface SearchMatterCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation SearchMatterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithSearchModel: (SearchResultModel*) model
{
    self.titleLabel.text = model.title;
    self.headerLabel.text = model.indexData;
    self.descriptionLabel.text = model.description;
}

- (IBAction)fileFolderTapped:(id)sender {
    [self.delegate didTapFileFolder:self];
}

- (IBAction)ledgerTapped:(id)sender {
    [self.delegate didTapLedger:self];
}



@end
