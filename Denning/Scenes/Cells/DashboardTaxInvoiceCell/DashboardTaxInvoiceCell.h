//
//  DashboardTaxInvoiceCell.h
//  Denning
//
//  Created by Ho Thong Mee on 28/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface DashboardTaxInvoiceCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *taxInvoiceNo;
@property (weak, nonatomic) IBOutlet UILabel *openDate;

@end
