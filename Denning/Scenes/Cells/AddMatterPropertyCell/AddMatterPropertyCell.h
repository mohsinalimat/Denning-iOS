//
//  AddMatterPropertyCell.h
//  Denning
//
//  Created by Ho Thong Mee on 30/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralContactCell.h"

@interface AddMatterPropertyCell :GeneralContactCell
@property (weak, nonatomic) IBOutlet UILabel *propertyNumber;
@property (weak, nonatomic) IBOutlet UILabel *fullTitle;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (void) configureCellWithFullTitle: (NSString*) fullTitle withAddress:(NSString*) address inNumber:(NSInteger) number;
@end
