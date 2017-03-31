//
//  SearchDocumentCell.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SearchDocumentCell.h"
@interface SearchDocumentCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation SearchDocumentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) configureCellWithSearchModel: (SearchResultModel*) model
{
    self.titleLabel.text = model.title;
    self.headerLabel.text = model.indexData;
    self.descriptionLabel.text = model.description;
}

- (IBAction)openFolderTapped:(id)sender {
    [self.delegate didTapOpenFolder:self];
}

- (IBAction)openMatterTapped:(id)sender {
    [self.delegate didTapOpenMatter:self];
}


@end
