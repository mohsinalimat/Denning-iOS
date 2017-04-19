//
//  LastTableCell.h
//  Denning
//
//  Created by DenningIT on 11/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@class LastTableCell;

@protocol LastTableCellDelegate <NSObject>

@optional

- (void) didTapFirstBtn: (LastTableCell*) cell;
- (void) didTapSecondBtn: (LastTableCell*) cell;

@end

@interface LastTableCell : DIGeneralCell

@property (weak, nonatomic) id <LastTableCellDelegate> delgate;

-(void) configureCellWithFirstTitle: (NSString*) firstTitle withSecondTitle: (NSString*) secondTitle;

@end
