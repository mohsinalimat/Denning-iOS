//
//  PropertyCodeCell.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface PropertyCodeCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *propertyTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *parcelNo;
@property (weak, nonatomic) IBOutlet UILabel *condoName;

- (void) configureCellWithModel:(FullPropertyModel*) model;

@end
