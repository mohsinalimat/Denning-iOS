//
//  TaskCheckCell.h
//  Denning
//
//  Created by Ho Thong Mee on 02/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface TaskCheckCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *clerkLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *fileNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@end
