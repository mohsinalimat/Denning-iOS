//
//  DocumentCell.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface DocumentCell : DIGeneralCell

- (void) configureCellWithFileModel: (FileModel*) model;
@end
