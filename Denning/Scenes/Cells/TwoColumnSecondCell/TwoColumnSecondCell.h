//
//  TwoColumnSecondCell.h
//  Denning
//
//  Created by Ho Thong Mee on 28/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface TwoColumnSecondCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
