//
//  DashboardSecondCell.h
//  Denning
//
//  Created by Ho Thong Mee on 26/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardSecondCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *RM;
@property (weak, nonatomic) IBOutlet UILabel *OR;
@property (weak, nonatomic) IBOutlet UILabel *deposited;

- (void) configurecellWithModel:(SecondItemModel*) model;

@end
