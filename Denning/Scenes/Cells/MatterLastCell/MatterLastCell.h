//
//  MatterLastCell.h
//  Denning
//
//  Created by DenningIT on 21/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@class MatterLastCell;

@protocol MatterLastCellDelegate <NSObject>

@optional

- (void) didTapFileFolder:(MatterLastCell*) cell;

- (void) didTapAccounts: (MatterLastCell*) cell;

- (void) didTapFileNote: (MatterLastCell*) cell;

- (void) didTapPaymentRecord: (MatterLastCell*) cell;

@end

@interface MatterLastCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UIButton *paymentRecordBtn;

@property (weak, nonatomic) id<MatterLastCellDelegate> matterLastCellDelegate;

@end
