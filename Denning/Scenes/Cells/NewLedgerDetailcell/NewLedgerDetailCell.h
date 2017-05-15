//
//  NewLedgerDetailCell.h
//  Denning
//
//  Created by DenningIT on 19/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface NewLedgerDetailCell : DIGeneralCell

- (void) configureCellWithLedgerDetailModel:(LedgerDetailModel*) ledgerDetail;

@end
