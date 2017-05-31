//
//  OneRowWithDot.h
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface OneRowWithDot : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet BadgeLabel *dotValue;

- (void) configureCellWithLeftValue:(NSString*)leftValue dotValue:(NSString*) dotValue;

@end
