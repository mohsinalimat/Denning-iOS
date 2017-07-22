//
//  SimpleFileLedgerCell.h
//  Denning
//
//  Created by Ho Thong Mee on 20/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface SimpleFileLedgerCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *fileName;

@end
