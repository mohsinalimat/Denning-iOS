//
//  CommonTextCell.h
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"
#import "GeneralContactCell.h"

@interface CommonTextCell : GeneralContactCell

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

- (void) configureCellWithValue: (NSString*) value;
@end
