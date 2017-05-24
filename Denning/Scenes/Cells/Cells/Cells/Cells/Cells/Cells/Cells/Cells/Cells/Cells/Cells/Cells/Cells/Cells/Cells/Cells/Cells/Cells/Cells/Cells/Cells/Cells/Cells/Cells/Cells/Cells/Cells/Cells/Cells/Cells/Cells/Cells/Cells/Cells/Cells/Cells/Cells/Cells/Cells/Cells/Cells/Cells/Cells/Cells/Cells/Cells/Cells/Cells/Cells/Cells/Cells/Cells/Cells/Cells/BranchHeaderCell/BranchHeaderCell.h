//
//  BranchHeaderCell.h
//  Denning
//
//  Created by DenningIT on 30/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@protocol BranchHeaderDelegate;

@interface BranchHeaderCell : DIGeneralCell
@property (weak, nonatomic) id<BranchHeaderDelegate> delegate;

- (void) configureCellWithTitle:(NSString*) title;
@end


@protocol BranchHeaderDelegate <NSObject>

- (void) didBackBtnTapped: (BranchHeaderCell*) cell;

@end
