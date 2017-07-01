//
//  myDueTaskCell.h
//  Denning
//
//  Created by Ho Thong Mee on 28/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface myDueTaskCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *clerk;
@property (weak, nonatomic) IBOutlet UILabel *task;
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *due;

- (void) configureCellWithModel:(TaskCheckModel*) model;

@end
