//
//  CompletionTrackingCell.h
//  Denning
//
//  Created by Ho Thong Mee on 17/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface CompletionTrackingCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *completionDate;
@property (weak, nonatomic) IBOutlet UILabel *extenedCD;
@property (weak, nonatomic) IBOutlet UILabel *daysToCompletion;

- (void) configureCellWithModel:(CompletionTrackingModel*) model;

@end
