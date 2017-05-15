//
//  SearchResultCell.m
//  Denning
//
//  Created by DenningIT on 20/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SearchResultCell.h"

@interface SearchResultCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexData;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *fileFolderBtn;
@property (weak, nonatomic) IBOutlet UIButton *ledgerBtn;

@end

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void) configureCellWithSearchModel: (SearchResultModel*) searchResult
{
    self.titleLabel.text = searchResult.title;
    self.indexData.text = searchResult.header;
    self.descriptionLabel.text = searchResult.description;
}

#pragma mark - SearchDelegate
- (IBAction)relatedMatterTapped:(id)sender {
    [self.delegate didTapMatter:self];
}

@end
