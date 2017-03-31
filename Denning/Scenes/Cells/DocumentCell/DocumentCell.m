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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithFileModel: (FileModel*) model
{
    self.fileNameLabel.text = model.name;
    self.dateLabel.text = model.date;
    if([model.ext isEqualToString:@".docx"] || [model.ext isEqualToString:@".txt"] || [model.ext isEqualToString:@".doc"] || [model.ext isEqualToString:@".rtf"]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_doc"];
    } else if([model.ext isEqualToString:@".png"] || [model.ext isEqualToString:@".tif"] || [model.ext isEqualToString:@".bmp"] || [model.ext isEqualToString:@".jpg"] || [model.ext isEqualToString:@".jpeg"] || [model.ext isEqualToString:@".gif"]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_png"];
    } else if([model.ext isEqualToString:@".pdf"]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_pdf"];
    } else if([model.ext isEqualToString:@".url"]){
        self.documentIcon.image = [UIImage imageNamed:@"icon_web"];
    }
}

@end
