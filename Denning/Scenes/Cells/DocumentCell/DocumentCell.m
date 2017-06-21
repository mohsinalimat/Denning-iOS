//
//  DocumentCell.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DocumentCell.h"

@interface DocumentCell()
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *documentIcon;

@end

@implementation DocumentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.fileNameLabel.copyingEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithFileModel: (FileModel*) model
{
    self.fileNameLabel.text = model.name;
    self.dateLabel.text = model.date;
    if([DIHelpers isWordFile:model.ext] || [DIHelpers isExcelFile:model.ext] || [DIHelpers isTextFile:model.ext]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_doc"];
    } else if([DIHelpers isImageFile:model.ext]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_png"];
    } else if([DIHelpers isPDFFile:model.ext]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_pdf"];
    } else if([DIHelpers isWebFile:model.ext]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_web"];
    }
}

@end
