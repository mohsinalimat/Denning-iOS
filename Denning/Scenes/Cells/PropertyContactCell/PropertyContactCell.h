//
//  PropertyContactCell.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface PropertyContactCell : DIGeneralCell

@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *NRIC;
@property (weak, nonatomic) IBOutlet UILabel *mobileAndPhone;

- (void) configureCellWithStaffModel:(StaffModel*) model;
@end
