//
//  myDueTaskCell.m
//  Denning
//
//  Created by Ho Thong Mee on 28/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "myDueTaskCell.h"

@implementation myDueTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithModel:(TaskCheckModel*) model
{
    _clerk.text = model.clerkName;
    _due.text = [DIHelpers getDateInShortForm:model.endDate];
    _start.text = [DIHelpers getDateInShortForm:model.startDate];
    _task.text = model.taskName;
    _fileNo.text = model.fileNo;
    _fileName.text = model.fileName;
}

@end
