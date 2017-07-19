//
//  CompletionTrackingCell.m
//  Denning
//
//  Created by Ho Thong Mee on 17/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CompletionTrackingCell.h"

@implementation CompletionTrackingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(CompletionTrackingModel*) model
{
    _fileNo.text = model.fileNo;
    _fileName.text = model.fileName;
    _completionDate.text = [DIHelpers getDateInShortForm:model.completionDate];
    _daysToCompletion.text = model.dayToComplete;
    _extenedCD.text = [DIHelpers getDateInShortForm:model.extendedDate];
}

@end
