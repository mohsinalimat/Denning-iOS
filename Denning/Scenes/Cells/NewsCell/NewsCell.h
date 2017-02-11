//
//  NewsCell.h
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface NewsCell : DIGeneralCell

- (void) configureCellWithNews:(NewsModel*) news;

@end
