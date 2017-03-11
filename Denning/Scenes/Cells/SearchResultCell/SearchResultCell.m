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
    self.indexData.text = searchResult.indexData;
    self.descriptionLabel.text = searchResult.description;
    
    [self detectItemType:searchResult.form];
}

- (void) detectItemType: (NSString*) form
{
    if ([form isEqualToString:@"200customer"])
    {
        self.tag = 1;
    } else if ([form isEqualToString:@"500file"]){
        self.tag = 2;
    } else if ([form isEqualToString:@"800property"]){
        self.tag = 4;
    } else if ([form isEqualToString:@"400Bank"]){
        self.tag = 8;
    } else if ([form isEqualToString:@"310landoffice"]){
        self.tag = 16;
    } else if ([form isEqualToString:@"300lawyer"]){
        self.tag = 32;
    } else if ([form isEqualToString:@"800property"]){
        self.tag = 64;
    }
}

#pragma mark - SearchDelegate

- (IBAction)fileFolderBtnClicked:(id)sender {
    [self.delegate didTapFileFolder:self];
}

- (IBAction)ledgerBtnClicked:(id)sender {
    [self.delegate didTapLedger:self];
}

@end
