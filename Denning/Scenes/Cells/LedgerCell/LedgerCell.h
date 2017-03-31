//
//  LedgerCell.h
//  Denning
//
//  Created by DenningIT on 31/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface LedgerCell : DIGeneralCell

- (void) configureCellWithLedger: (LedgerModel*) ledgerModel;

@end
