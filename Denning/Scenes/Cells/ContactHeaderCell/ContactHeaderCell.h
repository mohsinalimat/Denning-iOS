//
//  ContactHeaderCell.h
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface ContactHeaderCell : DIGeneralCell

- (void) configureCellWithContact:(NSString*) contactID;

@end
