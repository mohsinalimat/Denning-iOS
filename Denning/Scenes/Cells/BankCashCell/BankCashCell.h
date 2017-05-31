//
//  BankCashCell.h
//  Denning
//
//  Created by Ho Thong Mee on 30/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface BankCashCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *acName;
@property (weak, nonatomic) IBOutlet UILabel *acNo;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end
