//
//  FavContactCell.h
//  Denning
//
//  Created by DenningIT on 07/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralContactCell.h"

@interface FavContactCell : GeneralContactCell

- (void) configureCellWithContact: (QBUUser*) user;

@end
