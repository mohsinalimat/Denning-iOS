//
//  FeeTransferCell.h
//  Denning
//
//  Created by Ho Thong Mee on 30/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface FeeTransferCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *batchLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end
