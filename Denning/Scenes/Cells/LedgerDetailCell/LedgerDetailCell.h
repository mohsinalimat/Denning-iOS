//
//  LedgerDetailCell.h
//  Denning
//
//  Created by DenningIT on 29/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface LedgerDetailCell : DIGeneralCell

- (void) configureCellWithLedgerDetail: (LedgerDetailModel*) model;

@end
