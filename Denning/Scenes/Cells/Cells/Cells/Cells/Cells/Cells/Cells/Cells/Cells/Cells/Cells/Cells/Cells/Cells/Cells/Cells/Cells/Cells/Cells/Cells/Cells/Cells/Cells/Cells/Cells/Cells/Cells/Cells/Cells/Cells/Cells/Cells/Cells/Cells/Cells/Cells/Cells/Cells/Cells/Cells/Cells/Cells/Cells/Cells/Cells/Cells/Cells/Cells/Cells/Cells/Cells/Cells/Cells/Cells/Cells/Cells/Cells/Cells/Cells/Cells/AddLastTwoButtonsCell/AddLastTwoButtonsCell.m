//
//  AddLastTwoButtonsCell.m
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddLastTwoButtonsCell.h"

@implementation AddLastTwoButtonsCell

- (IBAction)didTapCalculate:(id)sender {
    self.viewHandler();
}

- (IBAction)didTapConvertToTaxInvoice:(id)sender {
    self.convertHandler();
}


@end
