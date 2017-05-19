//
//  BillCell.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface BillCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *quotationNo;
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *issueTo;
@property (weak, nonatomic) IBOutlet UILabel *primaryClient;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *issueBy;

- (void) configureCellWithMatterSimple:(QuotationModel*) model;

- (void) configureCellWithModel:(TaxModel*) model;

@end
