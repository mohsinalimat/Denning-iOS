//
//  SolicitorCell.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface SolicitorCell : DIGeneralCell

@property (weak, nonatomic) IBOutlet UILabel *firmName;
@property (weak, nonatomic) IBOutlet UILabel *branch;
@property (weak, nonatomic) IBOutlet UILabel *phoneAndFax;

- (void) configureCellWithModel:(SoliciorModel*) model;

@end
