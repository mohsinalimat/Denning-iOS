//
//  MatterLitigationCell.h
//  Denning
//
//  Created by Ho Thong Mee on 23/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface MatterLitigationCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *systemNo;
@property (weak, nonatomic) IBOutlet UILabel *courtCaseName;
@property (weak, nonatomic) IBOutlet UILabel *courtCaseNo;

- (void) configureCellWithModel: (MatterLitigationModel*) model;
@end
