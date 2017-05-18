//
//  BillCell.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithMatterSimple:(QuotationModel*) model
{
    self.quotationNo.text = model.documentNo;
    self.fileNo.text = model.fileNo;
    self.issueTo.text = model.issueToName;
    self.issueBy.text = model.issueBy;
    self.primaryClient.text = model.primaryClient;
    self.titleLabel.text = model.propertyTitle;
}

@end
