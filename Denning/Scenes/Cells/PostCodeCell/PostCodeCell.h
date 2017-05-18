//
//  PostCodeCell.h
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface PostCodeCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *postCode;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *country;

- (void) configureCellWithPostModel:(CityModel*) cityModel;

@end
