//
//  MatterPropertyCell.h
//  Denning
//
//  Created by DenningIT on 22/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralContactCell.h"

@interface MatterPropertyCell : GeneralContactCell
@property (weak, nonatomic) IBOutlet UILabel *propertyNumber;
@property (weak, nonatomic) IBOutlet UILabel *fullTitle;
@property (weak, nonatomic) IBOutlet UILabel *address;

- (void) configureCellWithFullTitle: (NSString*) fullTitle withAddress:(NSString*) address inNumber:(NSInteger) number;

@end
