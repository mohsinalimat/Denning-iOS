//
//  TwoColumnWithDotCell.h
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface TwoColumnWithDotCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *firstCaption;
@property (weak, nonatomic) IBOutlet UILabel *secondCaption;
@property (weak, nonatomic) IBOutlet BadgeLabel *secondValue;
@property (weak, nonatomic) IBOutlet BadgeLabel *firstValue;


- (void) configureCellWithFirstItem:(ItemModel*)firstItem  secondItem:(ItemModel*)secondItem;

@end
